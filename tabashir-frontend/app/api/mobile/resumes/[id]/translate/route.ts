import { NextRequest, NextResponse } from "next/server";
import { authenticateCandidateRequest } from "@/lib/mobile-auth";
import { prisma } from "@/lib/prisma";
import { downloadFile } from "@/lib/uploadthing-service";

/**
 * POST /api/mobile/resumes/{id}/translate
 * Translate resume content to another language using Resume Backend
 * 
 * Request body:
 * {
 *   "targetLanguage": "ar" | "en" | "es" | "fr" | etc.
 * }
 */
export async function POST(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    // Authenticate user and get candidate info
    const authResult = await authenticateCandidateRequest(req);
    if (authResult instanceof NextResponse) {
      return authResult;
    }
    const { user } = authResult;

    // Parse request body
    const body = await req.json();
    const { targetLanguage } = body;

    if (!targetLanguage) {
      return NextResponse.json(
        { error: "Target language is required" },
        { status: 400 }
      );
    }

    // Validate language code
    const supportedLanguages = ["ar", "en", "es", "fr", "de", "it", "pt", "ru", "zh", "ja", "ko"];
    if (!supportedLanguages.includes(targetLanguage.toLowerCase())) {
      return NextResponse.json(
        { error: `Unsupported language. Supported: ${supportedLanguages.join(", ")}` },
        { status: 400 }
      );
    }

    // Check if resume exists and belongs to user
    const resume = await prisma.resume.findFirst({
      where: {
        id: params.id,
        candidateId: user.candidateId,
      },
      select: {
        id: true,
        filename: true,
        originalUrl: true,
      },
    });

    if (!resume) {
      return NextResponse.json(
        { error: "Resume not found" },
        { status: 404 }
      );
    }

    if (!resume.originalUrl) {
      return NextResponse.json(
        { error: "Resume file not available" },
        { status: 400 }
      );
    }

    // Call Resume Backend translate endpoint
    const backendUrl = process.env.NEXT_PUBLIC_BACKEND_URL || "https://backend.tabashir.ae";
    const apiToken = process.env.NEXT_PUBLIC_API_TOKEN;

    if (!apiToken) {
      return NextResponse.json(
        { error: "Backend API token not configured" },
        { status: 500 }
      );
    }

    // Download the resume file from UploadThing
    const downloadResult = await downloadFile(resume.originalUrl);

    if (!downloadResult.success || !downloadResult.blob) {
      return NextResponse.json(
        { error: downloadResult.error || "Failed to download resume file" },
        { status: 500 }
      );
    }

    const file = new File(
      [downloadResult.blob],
      resume.filename,
      { type: "application/pdf" }
    );

    // Prepare form data for Resume Backend
    const formData = new FormData();
    formData.append("file", file);
    formData.append("target_language", targetLanguage);

    // Call Resume Backend translate API
    const translateResponse = await fetch(`${backendUrl}/api/v1/resume/translate`, {
      method: "POST",
      headers: {
        "X-API-TOKEN": apiToken,
      },
      body: formData,
    });

    if (!translateResponse.ok) {
      const errorData = await translateResponse.json().catch(() => ({}));
      console.error("[TRANSLATE_BACKEND_ERROR]", errorData);
      return NextResponse.json(
        { error: errorData.detail || "Translation failed" },
        { status: translateResponse.status }
      );
    }

    const translatedData = await translateResponse.json();

    // The Resume Backend returns the translated file URL
    // Create a new resume record with the translated file
    const translatedResume = await prisma.resume.create({
      data: {
        candidateId: user.candidateId,
        filename: `${resume.filename.replace(/\.pdf$/i, "")}_${targetLanguage}.pdf`,
        originalUrl: translatedData.translated_file_url || translatedData.file_url,
        formatedUrl: null,
        formatedContent: null,
        isAiResume: false,
      },
      select: {
        id: true,
        filename: true,
        originalUrl: true,
        createdAt: true,
        updatedAt: true,
      },
    });

    // Language names for better response
    const languageNames: Record<string, string> = {
      ar: "Arabic",
      en: "English",
      es: "Spanish",
      fr: "French",
      de: "German",
      it: "Italian",
      pt: "Portuguese",
      ru: "Russian",
      zh: "Chinese",
      ja: "Japanese",
      ko: "Korean",
    };

    const targetLanguageName = languageNames[targetLanguage.toLowerCase()] || targetLanguage;

    return NextResponse.json({
      success: true,
      resume: translatedResume,
      targetLanguage: targetLanguageName,
      message: `Resume translated to ${targetLanguageName} successfully`,
    });
  } catch (error) {
    console.error("[TRANSLATE_RESUME_ERROR]", error);
    
    if (error instanceof Error && error.message.includes("API token")) {
      return NextResponse.json(
        { error: "Backend API token not configured" },
        { status: 500 }
      );
    }

    return NextResponse.json(
      { error: "Failed to translate resume" },
      { status: 500 }
    );
  }
}
