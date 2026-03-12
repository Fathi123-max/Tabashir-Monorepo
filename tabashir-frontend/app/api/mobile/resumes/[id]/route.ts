import { NextRequest, NextResponse } from "next/server";
import { verifyAccess } from "@/app/utils/jwt";
import { prisma } from "@/lib/prisma";
import { uploadFile, deleteFile, replaceFile, generateFilename } from "@/lib/uploadthing-service";

/**
 * GET /api/mobile/resumes/{id}
 * Get a specific resume by ID
 */
export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    // Get and verify JWT token
    const token = req.headers.get("authorization")?.replace("Bearer ", "");
    if (!token) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const { id: userId } = verifyAccess(token);

    // Get candidate ID from user ID
    const candidate = await prisma.candidate.findUnique({
      where: { userId },
      select: { id: true },
    });

    if (!candidate) {
      return NextResponse.json(
        { error: "Candidate profile not found" },
        { status: 404 }
      );
    }

    // Get the resume and verify ownership
    const resume = await prisma.resume.findFirst({
      where: {
        id: (await params).id,
        candidateId: candidate.id,
      },
      select: {
        id: true,
        filename: true,
        originalUrl: true,
        formatedUrl: true,
        formatedContent: true,
        isAiResume: true,
        createdAt: true,
        updatedAt: true,
      },
    });

    if (!resume) {
      return NextResponse.json(
        { error: "Resume not found or unauthorized" },
        { status: 404 }
      );
    }

    return NextResponse.json({
      success: true,
      resume,
    });
  } catch (error) {
    console.error("[GET_RESUME_ERROR]", error);
    return NextResponse.json(
      { error: "Failed to fetch resume" },
      { status: 500 }
    );
  }
}

/**
 * PUT /api/mobile/resumes/{id}
 * Update a resume (replace file)
 */
export async function PUT(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    // Get and verify JWT token
    const token = req.headers.get("authorization")?.replace("Bearer ", "");
    if (!token) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const { id: userId } = verifyAccess(token);

    // Get candidate ID from user ID
    const candidate = await prisma.candidate.findUnique({
      where: { userId },
      select: { id: true },
    });

    if (!candidate) {
      return NextResponse.json(
        { error: "Candidate profile not found" },
        { status: 404 }
      );
    }

    // Verify the resume exists and belongs to the candidate
    const existingResume = await prisma.resume.findFirst({
      where: {
        id: (await params).id,
        candidateId: candidate.id,
      },
      select: {
        id: true,
        originalUrl: true,
      },
    });

    if (!existingResume) {
      return NextResponse.json(
        { error: "Resume not found or unauthorized" },
        { status: 404 }
      );
    }

    // Parse multipart form data
    const formData = await req.formData();
    const file = formData.get("file") as File;

    // Extract original filename and extension
    const originalFileName = (file as any).name || 'resume.pdf';
    const fileExtension = originalFileName.split('.').pop() || 'pdf';
    const sanitizedOriginalName = originalFileName.replace(/\.[^/.]+$/, ""); // Remove extension
    const sanitizedName = sanitizedOriginalName.replace(/[^a-zA-Z0-9_-]/g, "_"); // Sanitize filename

    // Generate new filename preserving original name
    const fileName = generateFilename(`${sanitizedName}_${candidate.id}`, fileExtension);

    try {
      // Replace old file with new file
      const uploadResult = await replaceFile(existingResume.originalUrl, file, {
        allowedTypes: ["application/pdf"],
        maxSizeInMB: 2,
        filename: fileName,
      });

      // Update resume record in database
      const updatedResume = await prisma.resume.update({
        where: { id: (await params).id },
        data: {
          filename: uploadResult.data.name || fileName,
          originalUrl: uploadResult.data.url,
          formatedUrl: null, // Reset formatted version
          formatedContent: null, // Reset formatted content
          updatedAt: new Date(),
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
        resume: updatedResume,
      });
    } catch (error) {
      console.error("[UPDATE_RESUME_ERROR]", error);
      return NextResponse.json(
        { error: error instanceof Error ? error.message : "Failed to update resume" },
        { status: 500 }
      );
    }
  } catch (error) {
    console.error("[UPDATE_RESUME_ERROR]", error);
    return NextResponse.json(
      { error: "Failed to update resume" },
      { status: 500 }
    );
  }
}

/**
 * DELETE /api/mobile/resumes/{id}
 * Delete a resume
 */
export async function DELETE(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    // Get and verify JWT token
    const token = req.headers.get("authorization")?.replace("Bearer ", "");
    if (!token) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const { id: userId } = verifyAccess(token);

    // Get candidate ID from user ID
    const candidate = await prisma.candidate.findUnique({
      where: { userId },
      select: { id: true },
    });

    if (!candidate) {
      return NextResponse.json(
        { error: "Candidate profile not found" },
        { status: 404 }
      );
    }

    // Verify the resume exists and belongs to the candidate
    const resume = await prisma.resume.findFirst({
      where: {
        id: (await params).id,
        candidateId: candidate.id,
      },
      select: {
        id: true,
        originalUrl: true,
      },
    });

    if (!resume) {
      return NextResponse.json(
        { error: "Resume not found or unauthorized" },
        { status: 404 }
      );
    }

    // Delete file from UploadThing
    try {
      await deleteFile(resume.originalUrl);
    } catch (deleteError) {
      console.error("[UPLOADTHING_DELETE_ERROR]", deleteError);
      // Continue even if delete fails
    }

    // Delete resume record from database
    await prisma.resume.delete({
      where: { id: (await params).id },
    });

    return NextResponse.json({
      success: true,
      message: "Resume deleted successfully",
    });
  } catch (error) {
    console.error("[DELETE_RESUME_ERROR]", error);
    return NextResponse.json(
      { error: "Failed to delete resume" },
      { status: 500 }
    );
  }
}
