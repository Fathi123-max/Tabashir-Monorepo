import { NextRequest, NextResponse } from "next/server";
import { verifyAccess } from "@/app/utils/jwt";
import { prisma } from "@/lib/prisma";
import { uploadFile, generateFilename } from "@/lib/uploadthing-service";

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
 * Upload a new resume file
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
