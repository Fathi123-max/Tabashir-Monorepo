"use server";

import { prisma } from "@/lib/prisma";

export async function getAICVs(page: number = 1, itemsPerPage: number = 10) {
  const skip = (page - 1) * itemsPerPage;
  
  const [aiCvs, total] = await Promise.all([
    prisma.aiResume.findMany({
      skip,
      take: itemsPerPage,
      include: {
        candidate: {
          select: {
            user: {
              select: {
                name: true,
                email: true,
              },
            },
          },
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
    }),
    prisma.aiResume.count(),
  ]);

  const totalPages = Math.ceil(total / itemsPerPage);

  return {
    aiCvs,
    total,
    totalPages,
  };
} 