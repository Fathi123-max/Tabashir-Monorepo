import { NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';
import { auth } from '@/app/utils/auth';

export async function GET() {
  try {
    console.log('Subscription API called');
    
    const session = await auth();
    console.log('Session:', session ? 'Found' : 'Not found');
    
    if (!session?.user?.email) {
      console.log('No session or email found');
      return NextResponse.json({ error: 'Unauthorized - No session or email' }, { status: 401 });
    }

    console.log('User email:', session.user.email);

    // Get user by email
    const user = await prisma.user.findUnique({
      where: { email: session.user.email },
      select: { id: true, email: true }
    });

    console.log('User found:', user ? 'Yes' : 'No');

    if (!user) {
      console.log('User not found in database');
      return NextResponse.json({ error: 'User not found in database' }, { status: 404 });
    }

    console.log('User ID:', user.id);

    // Get the latest LinkedIn optimization subscription
    const subscription = await prisma.subscription.findFirst({
      where: {
        userId: user.id,
        plan: 'LINKEDIN_OPTIMIZATION',
      },
      orderBy: {
        createdAt: 'desc'
      },
      select: {
        id: true,
        plan: true,
        status: true,
        startDate: true,
        endDate: true,
        createdAt: true,
      }
    });

    console.log('Subscription found:', subscription ? 'Yes' : 'No');

    if (!subscription) {
      console.log('No LinkedIn optimization subscription found for user');
      
      // Let's also check if there are any subscriptions for this user
      const allUserSubscriptions = await prisma.subscription.findMany({
        where: { userId: user.id },
        select: { id: true, plan: true, status: true }
      });
      
      console.log('All user subscriptions:', allUserSubscriptions);
      
      return NextResponse.json({ 
        error: 'No LinkedIn optimization subscription found',
        debug: {
          userId: user.id,
          userEmail: user.email,
          allUserSubscriptions
        }
      }, { status: 404 });
    }

    console.log('Returning subscription:', subscription.id);
    return NextResponse.json({ subscription });
  } catch (error) {
    console.error('Error in subscription API:', error);
    return NextResponse.json(
      { error: 'Failed to fetch subscription', details: (error as Error).message },
      { status: 500 }
    );
  }
}
