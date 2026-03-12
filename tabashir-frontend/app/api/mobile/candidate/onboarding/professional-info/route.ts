import { NextResponse } from "next/server";
import { verifyAccess } from "@/app/utils/jwt";
import { prisma } from "@/app/utils/db";

function getAuthHeader(req: Request) {
  const h = req.headers.get("authorization") || "";
  const m = h.match(/^Bearer\s+(.+)$/i);
  return m?.[1];
}

export async function POST(req: Request) {
  try {
    const token = getAuthHeader(req);
    if (!token) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const { id } = verifyAccess(token);

    const body = await req.json();
    const { jobType, skills, employmentHistory, educationList, summary } = body;

    console.log('[MOBILE_PROFESSIONAL_INFO] Updating professional info for user:', id);

    // Get candidate
    const candidate = await prisma.candidate.findUnique({
      where: {
        userId: id,
      },
      include: {
        profile: true,
      },
    });

    if (!candidate) {
      return NextResponse.json({ error: "Candidate not found" }, { status: 404 });
    }

    // Update or create candidate profile with professional info
    const profileData = {
      jobType,
      skills: skills?.map((s: any) => s.name ?? s) ?? [],
      onboardingCompleted: true,
    };

    const updatedProfile = await prisma.candidateProfile.upsert({
      where: {
        candidateId: candidate.id,
      },
      update: profileData,
      create: {
        candidateId: candidate.id,
        ...profileData,
      },
    });

    console.log('[MOBILE_PROFESSIONAL_INFO] Professional info updated successfully');

    return NextResponse.json({
      success: true,
      message: 'Professional info updated successfully',
      data: updatedProfile,
    });
  } catch (error) {
    console.error('[MOBILE_PROFESSIONAL_INFO] Error:', error);
    return NextResponse.json(
      { error: 'Failed to update professional info' },
      { status: 500 }
    );
  }
}
