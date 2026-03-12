import { NextResponse } from "next/server"
import { auth } from "@/app/utils/auth"
import { prisma } from "@/app/utils/db"

export async function POST(req: Request) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: "Unauthorized" },
        { status: 401 }
      )
    }

    const { userId } = await req.json()

    // Verify the user
    const candidate = await prisma.candidate.findUnique({
      where: {
        userId: session.user.id,
      },
    })

    if (!candidate) {
      return NextResponse.json(
        { error: "Candidate not found" },
        { status: 404 }
      )
    }

    // Create a new AI resume record
    const resume = await prisma.aiResume.create({
      data: {
        candidateId: candidate.id,
        status: "DRAFT",
        progress: 0,
      },
    })

    return NextResponse.json({ resumeId: resume.id })
  } catch (error) {
    console.error("[AI_RESUME_CREATE_ERROR]", error)
    return NextResponse.json(
      { error: "Failed to create AI resume" },
      { status: 500 }
    )
  }
} 