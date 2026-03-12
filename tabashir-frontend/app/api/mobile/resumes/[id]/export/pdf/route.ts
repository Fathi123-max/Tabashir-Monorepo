import { NextRequest, NextResponse } from "next/server";
import { authenticateCandidateRequest } from "@/lib/mobile-auth";
import { prisma } from "@/lib/prisma";

/**
 * POST /api/mobile/resumes/{id}/export/pdf
 * Export resume as PDF (returns the formatted PDF URL or original if no formatted version)
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
    const resume = await prisma.resume.findFirst({
      where: {
        id: params.id,
        candidateId: user.candidateId,
      },
      select: {
        id: true,
        filename: true,
        originalUrl: true,
        formatedUrl: true,
      },
    });

    if (!resume) {
      return NextResponse.json(
        { error: "Resume not found" },
        { status: 404 }
      );
    }

    // Return formatted PDF if available, otherwise original
    const pdfUrl = resume.formatedUrl || resume.originalUrl;

    if (!pdfUrl) {
      return NextResponse.json(
        { error: "No PDF available for this resume" },
        { status: 404 }
      );
    }

    return NextResponse.json({
      success: true,
      exportUrl: pdfUrl,
      filename: resume.filename,
      isFormatted: !!resume.formatedUrl,
      message: "PDF export ready",
    });
  } catch (error) {
    console.error("[EXPORT_PDF_ERROR]", error);
    return NextResponse.json(
      { error: "Failed to export PDF" },
      { status: 500 }
    );
  }
}
