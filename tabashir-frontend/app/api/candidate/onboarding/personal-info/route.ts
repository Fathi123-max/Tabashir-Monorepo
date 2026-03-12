import { NextResponse } from "next/server"
import { auth } from "@/app/utils/auth"
import { prisma } from "@/app/utils/db"

export async function POST(req: Request) {
  try {
    const session = await auth()

    if (!session?.user?.id) {
      return new NextResponse("Unauthorized", { status: 401 })
    }

    const body = await req.json()
    const { phone, nationality, gender, languages, age, profilePicture } = body

    // Get or create candidate
    const candidate = await prisma.candidate.upsert({
      where: {
        userId: session.user.id,
      },
      create: {
        userId: session.user.id,
        profile: {
          create: {
            phone,
            nationality,
            gender,
            languages,
            age: parseInt(age),
            profilePicture,
            onboardingCompleted: false,
          },
        },
      },
      update: {
        profile: {
          update: {
            phone,
            nationality,
            gender,
            languages,
            age: parseInt(age),
            profilePicture,
            onboardingCompleted: false,
          },
        },
      },
    })

    return NextResponse.json(candidate)
  } catch (error) {
    console.error("[PERSONAL_INFO_POST]", error)
    return new NextResponse("Internal error", { status: 500 })
  }
} 