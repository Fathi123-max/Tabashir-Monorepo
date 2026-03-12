"use server";

import { prisma } from "@/lib/prisma";
import { auth } from "@/app/utils/auth";
import bcrypt from "bcryptjs";

export async function getUserProfile() {
  const session = await auth();
  if (!session?.user) {
    throw new Error("Not authenticated");
  }

  const user = await prisma.user.findUnique({
    where: {
      id: session.user.id,
    },
    include: {
      candidate: {
        include: {
          profile: true,
        },
      },
    },
  });

  if (!user) {
    throw new Error("User not found");
  }

  return user;
}

export async function updateUserProfile(data: {
  name?: string;
  image?: string;
  phone?: string;
  gender?: string;
  nationality?: string;
  jobType?: string;
  experience?: string;
  education?: string;
  skills?: string[];
}) {
  const session = await auth();
  if (!session?.user) {
    throw new Error("Not authenticated");
  }

  const user = await prisma.user.findUnique({
    where: {
      id: session.user.id,
    },
    include: {
      candidate: true,
    },
  });

  if (!user) {
    throw new Error("User not found");
  }

  // Update user information
  if (data.name || data.image) {
    await prisma.user.update({
      where: { id: session.user.id },
      data: {
        name: data.name,
        image: data.image,
      },
    });
  }

  // Update or create candidate profile
  if (user.candidate) {
    await prisma.candidateProfile.upsert({
      where: { candidateId: user.candidate.id },
      create: {
        candidateId: user.candidate.id,
        phone: data.phone,
        gender: data.gender,
        nationality: data.nationality,
        jobType: data.jobType,
        experience: data.experience,
        education: data.education,
        skills: data.skills || [],
      },
      update: {
        phone: data.phone,
        gender: data.gender,
        nationality: data.nationality,
        jobType: data.jobType,
        experience: data.experience,
        education: data.education,
        skills: data.skills,
      },
    });
  }

  return { success: true, message: "Profile updated successfully" };
}

export async function updatePassword(password: { newPassword: string }) {
  const session = await auth();
  if (!session?.user) {
    throw new Error("Not authenticated");
  }

  const hashedPassword = await bcrypt.hash(password.newPassword, 12);

  await prisma.user.update({
    where: { id: session.user.id },
    data: {
      password: hashedPassword,
    },
  });

  return { success: true, message: "Password updated successfully" };
} 