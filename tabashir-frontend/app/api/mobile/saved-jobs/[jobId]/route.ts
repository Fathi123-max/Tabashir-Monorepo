import { NextRequest, NextResponse } from "next/server";
import { verifyAccess } from "@/app/utils/jwt";
import { prisma } from "@/lib/prisma";

/**
 * DELETE /api/mobile/saved-jobs/{jobId}
 * Remove a job from saved jobs for the authenticated user
 */
export async function DELETE(
  req: NextRequest,
  { params }: { params: { jobId: string } }
) {
  try {
    // Get and verify JWT token
    const token = req.headers.get("authorization")?.replace("Bearer ", "");
    if (!token) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const { id: userId } = verifyAccess(token);

    const { jobId } = params;

    if (!jobId) {
      return NextResponse.json(
        { error: "Job ID is required" },
        { status: 400 }
      );
    }

    // Find the job by externalApiJobId
    const job = await prisma.job.findUnique({
      where: { externalApiJobId: jobId },
      select: { id: true },
    });

    if (!job) {
      return NextResponse.json(
        { error: "Job not found" },
        { status: 404 }
      );
    }

    // Check if the saved job exists
    const savedJob = await prisma.savedJobPost.findUnique({
      where: {
        userId_jobId: {
          userId,
          jobId: job.id,
        },
      },
      select: {
        jobId: true,
      },
    });

    if (!savedJob) {
      return NextResponse.json(
        { error: "Saved job not found" },
        { status: 404 }
      );
    }

    // Remove the saved job
    await prisma.savedJobPost.delete({
      where: {
        userId_jobId: {
          userId,
          jobId: job.id,
        },
      },
    });

    return NextResponse.json({
      success: true,
      message: "Job removed from saved jobs",
    });
  } catch (error) {
    console.error("[UNSAVE_JOB_ERROR]", error);
    return NextResponse.json(
      { error: "Failed to remove saved job" },
      { status: 500 }
    );
  }
}
