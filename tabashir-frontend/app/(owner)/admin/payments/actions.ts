"use server";

import { prisma } from "@/lib/prisma";

export async function getPayments(page: number = 1, itemsPerPage: number = 10, searchTerm?: string) {
  const skip = (page - 1) * itemsPerPage;
  
  let whereClause: any = {};
  
  // If search term is provided, search in subscription ID, user name, or user email
  if (searchTerm) {
    whereClause.OR = [
      {
        subscription: {
          id: {
            contains: searchTerm,
            mode: 'insensitive'
          }
        }
      },
      {
        user: {
          name: {
            contains: searchTerm,
            mode: 'insensitive'
          }
        }
      },
      {
        user: {
          email: {
            contains: searchTerm,
            mode: 'insensitive'
          }
        }
      }
    ];
  }
  
  const [payments, total] = await Promise.all([
    prisma.payment.findMany({
      skip,
      take: itemsPerPage,
      where: whereClause,
      include: {
        user: {
          select: {
            name: true,
            email: true,
          },
        },
        subscription: {
          select: {
            id: true,
            plan: true,
            status: true,
            startDate: true,
            endDate: true,
          }
        }
      },
      orderBy: {
        createdAt: 'desc',
      },
    }),
    prisma.payment.count({ where: whereClause }),
  ]);

  const totalPages = Math.ceil(total / itemsPerPage);

  return {
    payments,
    total,
    totalPages,
  };
}

export async function getSubscriptionById(subscriptionId: string) {
  try {
    const subscription = await prisma.subscription.findUnique({
      where: { id: subscriptionId },
      include: {
        user: {
          select: {
            name: true,
            email: true,
          }
        },
        payments: {
          select: {
            id: true,
            amount: true,
            currency: true,
            status: true,
            paymentDate: true,
            createdAt: true,
          },
          orderBy: {
            createdAt: 'desc'
          }
        }
      }
    });

    return { subscription };
  } catch (error) {
    console.error('Error fetching subscription:', error);
    return { error: 'Failed to fetch subscription' };
  }
}

