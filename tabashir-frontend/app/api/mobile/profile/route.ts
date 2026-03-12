import { NextResponse } from "next/server";
import { verifyAccess } from "@/app/utils/jwt";
import { prisma } from "@/app/utils/db";

function getAuthHeader(req: Request) {
  const h = req.headers.get("authorization") || "";
  const m = h.match(/^Bearer\s+(.+)$/i);
  return m?.[1];
}

export async function PUT(req: Request) {
  try {
    const token = getAuthHeader(req);
    if (!token) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const { id } = verifyAccess(token);

    const body = await req.json();
    const {
      name,
      email,
      phone,
      nationality,
      gender,
      jobTitle,
      location,
      company,
      education,
      linkedin,
    } = body;

    console.log('[PROFILE_UPDATE] Updating profile for user:', id);
    console.log('[PROFILE_UPDATE] Data:', body);

    // Get user with current data
    const user = await prisma.user.findUnique({
      where: { id },
      include: {
        candidate: {
          include: {
            profile: true,
          },
        },
        Owner: true,
      },
    });

    if (!user) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    console.log('[PROFILE_UPDATE] User type:', user.userType);

    // Update User table (only update name, keep existing email if new email is empty)
    const userUpdateData: any = { name };
    if (email && email.trim().length > 0) {
      // Check if email is being changed and if the new email already exists
      if (user.email !== email) {
        const existingUser = await prisma.user.findUnique({
          where: { email },
        });

        if (existingUser && existingUser.id !== id) {
          return NextResponse.json(
            { error: 'Email already in use by another account' },
            { status: 400 }
          );
        }
      }
      userUpdateData.email = email;
    }

    await prisma.user.update({
      where: { id },
      data: userUpdateData,
    });

    // Update profile based on user type
    if (user.userType === 'CANDIDATE') {
      // Ensure candidate exists
      let candidate = user.candidate;
      if (!candidate) {
        candidate = await prisma.candidate.create({
          data: {
            userId: id,
          },
        });
      }

      // Update or create candidate profile
      const profileData = {
        phone,
        nationality,
        gender,
        experience: jobTitle, // Map jobTitle to experience
        education,
        location,
        linkedin,
      };

      if (user.candidate?.profile) {
        // Update existing profile
        await prisma.candidateProfile.update({
          where: {
            candidateId: candidate.id,
          },
          data: profileData,
        });
      } else {
        // Create new profile
        await prisma.candidateProfile.create({
          data: {
            candidateId: candidate.id,
            ...profileData,
          },
        });
      }

      console.log('[PROFILE_UPDATE] Candidate profile updated');
    } else if (user.userType === 'RECRUITER') {
      // Get or create recruiter
      let recruiter = await prisma.recruiter.findUnique({
        where: { userId: id },
      });

      if (!recruiter) {
        // Create new recruiter with minimal data
        recruiter = await prisma.recruiter.create({
          data: {
            userId: id,
            companyName: company || 'Company Not Set',
            contactPersonName: name || 'Not Set',
            phone,
          },
        });
      } else {
        // Update existing recruiter
        await prisma.recruiter.update({
          where: { userId: id },
          data: {
            companyName: company,
            contactPersonName: name,
            phone,
          },
        });
      }

      console.log('[PROFILE_UPDATE] Recruiter profile updated');
    } else if (user.userType === 'ADMIN') {
      // Update owner profile
      let owner = user.Owner;
      if (!owner) {
        owner = await prisma.owner.create({
          data: {
            userId: id,
            phone,
          },
        });
      } else {
        await prisma.owner.update({
          where: { userId: id },
          data: {
            phone,
          },
        });
      }

      console.log('[PROFILE_UPDATE] Admin profile updated');
    }

    console.log('[PROFILE_UPDATE] Profile update completed successfully');

    return NextResponse.json({
      success: true,
      message: 'Profile updated successfully',
    });

  } catch (error) {
    console.error('[PROFILE_UPDATE] Error:', error);
    return NextResponse.json(
      { error: 'Failed to update profile' },
      { status: 500 }
    );
  }
}
