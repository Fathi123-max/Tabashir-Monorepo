import { NextResponse } from "next/server"
import { auth } from "@/app/utils/auth"
import { prisma } from "@/app/utils/db"

export async function POST(req: Request) {
  try {
    const session = await auth()

    if (!session?.user) {
      return new NextResponse("Unauthorized", { status: 401 })
    }

    const body = await req.json()
    const { jobType, skills, experience, education, degree } = body

    // Get candidate and update profile
    const candidate = await prisma.candidate.findUnique({
      where: {
        userId: session.user.id,
      },
      include: {
        profile: true,
      },
    })

    if (!candidate) {
      return new NextResponse("Candidate not found", { status: 404 })
    }

    const updatedProfile = await prisma.candidateProfile.update({
      where: {
        candidateId: candidate.id,
      },
      data: {
        jobType,
        skills,
        experience,
        education,
        degree,
        onboardingCompleted: true,
      },
    })

    return NextResponse.json(updatedProfile)
  } catch (error) {
    console.error("[PROFESSIONAL_INFO_POST]", error)
    return new NextResponse("Internal error", { status: 500 })
  }
} 