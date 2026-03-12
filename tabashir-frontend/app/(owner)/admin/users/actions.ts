"use server";

import { prisma } from "@/lib/prisma";

export async function getUsers(page: number = 1, itemsPerPage: number = 10, query: string = "") {
  const skip = (page - 1) * itemsPerPage;

  const where = query
    ? {
        OR: [
          { name: { contains: query, mode: "insensitive" } },
          { email: { contains: query, mode: "insensitive" } },
        ],
      }
    : undefined;

  const [users, total] = await Promise.all([
    prisma.user.findMany({
      where,
      skip,
      take: itemsPerPage,
      include: {
        candidate: {
          include: {
            profile: true,
          },
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
    }),
    prisma.user.count({ where }),
  ]);

  const totalPages = Math.ceil(total / itemsPerPage);

  return {
    users,
    total,
    totalPages,
  };
}