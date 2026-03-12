import { NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';

export async function GET() {
  try {
    // Check total subscriptions
    const totalSubscriptions = await prisma.subscription.count();
    
    // Check LinkedIn optimization subscriptions
    const linkedinSubscriptions = await prisma.subscription.findMany({
      where: {
        plan: 'LINKEDIN_OPTIMIZATION',
      },
      include: {
        user: {
          select: {
            name: true,
            email: true,
          }
        }
      },
      orderBy: {
        createdAt: 'desc'
      }
    });

    // Check all subscription plans
    const allPlans = await prisma.subscription.groupBy({
      by: ['plan'],
      _count: {
        plan: true
      }
    });

    // Check if there are any users
    const totalUsers = await prisma.user.count();

    return NextResponse.json({ 
      debug: {
        totalSubscriptions,
        totalUsers,
        linkedinSubscriptionsCount: linkedinSubscriptions.length,
        linkedinSubscriptions,
        allPlans,
        message: 'Debug information'
      }
    });
  } catch (error) {
    console.error('Error in debug endpoint:', error);
    return NextResponse.json(
      { error: 'Debug failed', details: error.message },
      { status: 500 }
    );
  }
}
