import { NextRequest, NextResponse } from "next/server";
import { verifyAccess } from "@/app/utils/jwt";
import { prisma } from "@/lib/prisma";

/**
 * POST /api/mobile/sync-jobs
 * Sync jobs from external API to local database
 * Body: { jobs: Array<{ id: string, title: string, company: string, ... }> }
 */
export async function POST(req: NextRequest) {
  try {
    // Get and verify JWT token
    const token = req.headers.get("authorization")?.replace("Bearer ", "");
    if (!token) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const { id: userId } = verifyAccess(token);

    // Parse request body
    const body = await req.json();
    const { jobs } = body;

    if (!jobs || !Array.isArray(jobs)) {
      return NextResponse.json(
        { error: "Jobs array is required" },
        { status: 400 }
      );
    }

    let syncedCount = 0;

    // Sync each job
    for (const jobData of jobs) {
      const { id: jobId, title, company, location, description } = jobData;

      if (!jobId || !title) continue;

      // Check if job exists
      const existingJob = await prisma.job.findFirst({
        where: { externalApiJobId: jobId },
      });

      if (existingJob) {
        // Update existing job
        await prisma.job.update({
          where: { id: existingJob.id },
          data: {
            title: title || 'Untitled',
            company: company || 'Unknown',
            location: location || '',
            description: description || '',
            updatedAt: new Date(),
          },
        });
      } else {
        // Create new job
        await prisma.job.create({
          data: {
            externalApiJobId: jobId,
            title: title || 'Untitled',
            company: company || 'Unknown',
            companyDescription: '',
            companyLogo: '',
            jobType: 'Full-time',
            salaryMin: 0,
            salaryMax: 0,
            location: location || '',
            description: description || '',
            requirements: '',
            benefits: [],
            isActive: true,
          },
        });
      }

      syncedCount++;
    }

    return NextResponse.json({
      success: true,
      syncedCount,
      message: `Synced ${syncedCount} jobs successfully`,
    });
  } catch (error) {
    console.error("[SYNC_JOBS_ERROR]", error);
    console.error("[SYNC_JOBS_ERROR_STACK]", error instanceof Error ? error.stack : 'No stack trace');
    return NextResponse.json(
      { error: "Failed to sync jobs", details: error instanceof Error ? error.message : String(error) },
      { status: 500 }
    );
  }
}
