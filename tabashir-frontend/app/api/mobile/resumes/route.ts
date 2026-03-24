import { NextRequest, NextResponse } from "next/server";
import { verifyAccess } from "@/app/utils/jwt";
import { prisma } from "@/lib/prisma";
import { uploadFile, generateFilename } from "@/lib/uploadthing-service";
import OpenAI from "openai";
import { extractText, getDocumentProxy } from 'unpdf';
import { downloadFile } from "@/lib/uploadthing-service";

/**
 * GET /api/mobile/resumes
 * List all resumes for the authenticated user
 */
export async function GET(req: NextRequest) {
  try {
    // Get and verify JWT token
    const token = req.headers.get("authorization")?.replace("Bearer ", "");
    if (!token) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const { id: userId } = verifyAccess(token);

    // Get candidate ID from user ID
    let candidate = await prisma.candidate.findUnique({
      where: { userId },
      select: { id: true },
    });

    // If candidate profile doesn't exist, create one
    if (!candidate) {
      candidate = await prisma.candidate.create({
        data: {
          userId: userId,
        },
        select: { id: true },
      });
    }

    // Get all resumes for the candidate
    const resumes = await prisma.resume.findMany({
      where: { candidateId: candidate.id },
      orderBy: { createdAt: "desc" },
      select: {
        id: true,
        filename: true,
        originalUrl: true,
        formatedUrl: true,
        isAiResume: true,
        createdAt: true,
        updatedAt: true,
      },
    });

    return NextResponse.json({
      success: true,
      resumes,
    });
  } catch (error) {
    console.error("[GET_RESUMES_ERROR]", error);
    return NextResponse.json(
      { error: "Failed to fetch resumes" },
      { status: 500 }
    );
  }
}

/**
 * POST /api/mobile/resumes
 * Upload a new resume file and extract personal information to update profile
 */
export async function POST(req: NextRequest) {
  try {
    // Get and verify JWT token
    const token = req.headers.get("authorization")?.replace("Bearer ", "");
    if (!token) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const { id: userId } = verifyAccess(token);

    // Get candidate ID from user ID
    let candidate = await prisma.candidate.findUnique({
      where: { userId },
      select: { id: true },
    });

    // If candidate profile doesn't exist, create one
    if (!candidate) {
      candidate = await prisma.candidate.create({
        data: {
          userId: userId,
        },
        select: { id: true },
      });
    }

    // Parse multipart form data
    const formData = await req.formData();
    const file = formData.get("file") as File;

    // Extract original filename and extension
    const originalFileName = (file as any).name || 'resume.pdf';
    const fileExtension = originalFileName.split('.').pop() || 'pdf';
    const sanitizedOriginalName = originalFileName.replace(/\.[^/.]+$/, ""); // Remove extension
    const sanitizedName = sanitizedOriginalName.replace(/[^a-zA-Z0-9_-]/g, "_"); // Sanitize filename

    // Generate unique filename preserving original name
    const fileName = generateFilename(`${sanitizedName}_${candidate.id}`, fileExtension);

    // Upload file to UploadThing
    const uploadResult = await uploadFile(file, {
      allowedTypes: ["application/pdf"],
      maxSizeInMB: 2,
      filename: fileName,
      maxRetries: 5, // Increased retries for better resilience
    });

    const originalUrl = uploadResult.data.url;

    // Create resume record in database
    const resume = await prisma.resume.create({
      data: {
        candidateId: candidate.id,
        filename: fileName,
        originalUrl: originalUrl,
      },
      select: {
        id: true,
        filename: true,
        originalUrl: true,
        formatedUrl: true,
        isAiResume: true,
        createdAt: true,
        updatedAt: true,
      },
    });

    // NEW: Extract personal information from CV and update profile in background
    // Don't wait for this to complete - return success immediately
    extractAndUpdateProfileFromCVInBackground(originalUrl, userId, candidate.id, resume.id);

    return NextResponse.json({
      success: true,
      resume,
    });
  } catch (error) {
    console.error("[UPLOAD_RESUME_ERROR]", error);
    let errorMessage = "Failed to upload resume";
    let errorDetail = "";

    if (error instanceof Error) {
      errorMessage = error.message;
      // Extract specific error information for certain error types
      if (error.message.toLowerCase().includes("timeout")) {
        errorDetail = "Upload timed out. Please try again or use a smaller file.";
      } else if (error.message.toLowerCase().includes("network")) {
        errorDetail = "Network error during upload. Please check your connection and try again.";
      } else if (error.message.toLowerCase().includes("und_err_connect_timeout")) {
        errorDetail = "Connection timed out during upload. The server may be experiencing high load. Please try again.";
      }
    }

    return NextResponse.json(
      {
        error: errorMessage,
        detail: errorDetail,
        timestamp: new Date().toISOString()
      },
      { status: 500 }
    );
  }
}

/**
 * Extract personal information from CV and update user profile (background task)
 */
async function extractAndUpdateProfileFromCVInBackground(
  fileUrl: string,
  userId: string,
  candidateId: string,
  resumeId: string
): Promise<void> {
  try {
    console.log("[CV_PROFILE_EXTRACTION] Starting background extraction for resume:", resumeId);

    // Download the file
    const downloadResult = await downloadFile(fileUrl);
    if (!downloadResult.success || !downloadResult.blob) {
      console.error("[CV_PROFILE_EXTRACTION] Failed to download file");
      return;
    }

    // Convert blob to buffer
    const arrayBuffer = await downloadResult.blob.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);

    // Extract text from PDF
    const pdf = await getDocumentProxy(new Uint8Array(buffer));
    const { text: rawText } = await extractText(pdf, { mergePages: true });

    if (!rawText || rawText.trim().length < 50) {
      console.warn("[CV_PROFILE_EXTRACTION] Extracted text too short");
      return;
    }

    // Use OpenAI to extract structured personal information
    const openai = new OpenAI({
      apiKey: process.env.OPENAI_API_KEY,
    });

    const extractionPrompt = `Extract the following personal information from this CV text and return it as a JSON object:
{
  "name": "Full name from CV",
  "email": "Email address",
  "phone": "Phone number",
  "location": "City, Country",
  "nationality": "Nationality if mentioned",
  "linkedin": "LinkedIn URL if available",
  "summary": "Professional summary or objective"
}

Only extract information that is explicitly present in the CV. Return empty strings for fields not found.
Return ONLY the JSON object, no other text.

CV Text:
${rawText.substring(0, 5000)} // Limit text to avoid token limits
`;

    const completion = await openai.chat.completions.create({
      model: "gpt-4o",
      messages: [
        { role: "system", content: "You are a data extraction assistant. Extract personal information from CVs and return only valid JSON." },
        { role: "user", content: extractionPrompt },
      ],
      temperature: 0,
      response_format: { type: "json_object" },
    });

    const extractedData = completion.choices[0]?.message?.content;
    if (!extractedData) {
      console.warn("[CV_PROFILE_EXTRACTION] No data extracted from CV");
      return;
    }

    const parsedData = JSON.parse(extractedData);
    console.log("[CV_PROFILE_EXTRACTION] Extracted data:", parsedData);

    // Update User table
    const userUpdateData: any = {};
    if (parsedData.name && parsedData.name.trim()) {
      userUpdateData.name = parsedData.name.trim();
    }
    if (parsedData.email && parsedData.email.trim()) {
      // Check if email is already used by another user
      const existingUser = await prisma.user.findUnique({
        where: { email: parsedData.email.trim() },
      });
      if (!existingUser || existingUser.id === userId) {
        userUpdateData.email = parsedData.email.trim();
      }
    }

    if (Object.keys(userUpdateData).length > 0) {
      await prisma.user.update({
        where: { id: userId },
        data: userUpdateData,
      });
      console.log("[CV_PROFILE_EXTRACTION] User table updated");
    }

    // Update or create CandidateProfile
    const candidate = await prisma.candidate.findUnique({
      where: { id: candidateId },
      include: { profile: true },
    });

    if (!candidate) {
      console.warn("[CV_PROFILE_EXTRACTION] Candidate not found");
      return;
    }

    const profileData: any = {
      phone: parsedData.phone?.trim() || null,
      nationality: parsedData.nationality?.trim() || null,
      location: parsedData.location?.trim() || null,
      linkedin: parsedData.linkedin?.trim() || null,
    };

    if (candidate.profile) {
      await prisma.candidateProfile.update({
        where: { candidateId: candidate.id },
        data: profileData,
      });
    } else {
      await prisma.candidateProfile.create({
        data: {
          candidateId: candidate.id,
          ...profileData,
        },
      });
    }

    console.log("[CV_PROFILE_EXTRACTION] Profile updated successfully for resume:", resumeId);

  } catch (error) {
    console.error("[CV_PROFILE_EXTRACTION_ERROR]", error);
    // Don't rethrow - this is a background task
  }
}
