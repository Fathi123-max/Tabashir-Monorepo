import { NextRequest, NextResponse } from "next/server";
import { authenticateCandidateRequest } from "@/lib/mobile-auth";
import { prisma } from "@/lib/prisma";

/**
 * POST /api/mobile/resumes/{id}/duplicate
 * Duplicate an existing resume
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

    // Check if resume exists and belongs to user
    const existingResume = await prisma.resume.findFirst({
      where: {
        id: params.id,
        candidateId: user.candidateId,
      },
    });

    if (!existingResume) {
      return NextResponse.json(
        { error: "Resume not found" },
        { status: 404 }
      );
    }

    // Create duplicate resume
    const duplicatedResume = await prisma.resume.create({
      data: {
        candidateId: user.candidateId,
        filename: `Copy of ${existingResume.filename}`,
        originalUrl: existingResume.originalUrl,
        formatedUrl: existingResume.formatedUrl,
        formatedContent: existingResume.formatedContent,
        isAiResume: existingResume.isAiResume,
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
      resume: duplicatedResume,
      message: "Resume duplicated successfully",
    });
  } catch (error) {
    console.error("[DUPLICATE_RESUME_ERROR]", error);
    return NextResponse.json(
      { error: "Failed to duplicate resume" },
      { status: 500 }
    );
  }
}
