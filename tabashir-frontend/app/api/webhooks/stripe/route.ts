import { NextResponse } from 'next/server';
import { stripe } from '@/lib/stripe';
import { prisma } from '@/lib/prisma';
import { headers } from 'next/headers';

export async function POST(request: Request) {
  const body = await request.text();
  const headersList = await headers();
  const signature = headersList.get('stripe-signature');

  if (!signature) {
    return NextResponse.json({ error: 'No signature' }, { status: 400 });
  }

  if (!process.env.STRIPE_WEBHOOK_SECRET) {
    return NextResponse.json({ error: 'Webhook secret not configured' }, { status: 500 });
  }

  let event;

  try {
    event = stripe.webhooks.constructEvent(body, signature, process.env.STRIPE_WEBHOOK_SECRET);
  } catch (err) {
    console.error('Webhook signature verification failed:', err);
    return NextResponse.json({ error: 'Invalid signature' }, { status: 400 });
  }

  try {
    switch (event.type) {
      case 'checkout.session.completed':
        await handleCheckoutSessionCompleted(event.data.object);
        break;
      
      case 'payment_intent.succeeded':
        await handlePaymentIntentSucceeded(event.data.object);
        break;
      
      case 'payment_intent.payment_failed':
        await handlePaymentIntentFailed(event.data.object);
        break;
      
      default:
        console.log(`Unhandled event type: ${event.type}`);
    }

    return NextResponse.json({ received: true });
  } catch (error) {
    console.error('Error processing webhook:', error);
    return NextResponse.json({ error: 'Webhook processing failed' }, { status: 500 });
  }
}

async function handleCheckoutSessionCompleted(session: any) {
  const { serviceId, userId, resumeId, serviceTitle } = session.metadata;
  const amount = session.amount_total / 100; // Convert from cents
  const currency = session.currency.toUpperCase();

  // Create payment record
  await prisma.payment.create({
    data: {
      amount: amount,
      currency: currency,
      status: 'COMPLETED',
      paymentMethod: 'stripe',
      transactionId: session.payment_intent,
      paymentDate: new Date(),
      userId: userId,
    }
  });

  // Handle different service types
  if (serviceId === 'ai-job-apply') {
    // Add job count and AI job apply count
    await prisma.user.update({
      where: { id: userId },
      data: {
        jobCount: { increment: 200 },
        aiJobApplyCount: { increment: 1 },
      }
    });

    // Send LinkedIn email notification
    const user = await prisma.user.findUnique({
      where: { id: userId },
      select: { email: true, name: true }
    });

    if (user?.email) {
      try {
        await fetch(`${process.env.NEXT_PUBLIC_APP_URL}/api/v1/resume/send-linkedin-email`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            recipient_email: user.email,
            recipient_name: user.name || '',
          })
        });
      } catch (error) {
        console.error('Failed to send LinkedIn email:', error);
      }
    }
  } else if (serviceId === 'ai-resume-optimization' && (resumeId)) {
    // Update resume payment status
    await prisma.aiResume.update({
      where: { id: resumeId },
      data: { 
        paymentStatus: true, 
        paymentAmount: amount, 
        paymentDate: new Date() 
      }
    });
    console.log(`Resume payment status updated for ${resumeId}`);
  } else if (serviceId === 'linkedin-optimization') {
    // Handle LinkedIn optimization purchase
    const subscription = await prisma.subscription.create({
      data: {
        userId: userId,
        plan: 'LINKEDIN_OPTIMIZATION',
        status: 'ACTIVE',
        startDate: new Date(),
        endDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000),
      }
    });
    
    // Update the payment to link it to the subscription
    await prisma.payment.updateMany({
      where: { 
        transactionId: session.payment_intent,
        userId: userId 
      },
      data: { 
        subscriptionId: subscription.id 
      }
    });
    
    console.log(`LinkedIn optimization purchased by user ${userId}, subscription ID: ${subscription.id}`);
    // Add any specific logic for LinkedIn optimization
  } else if (serviceId === 'interview-training') {
    // Handle interview training purchase
    console.log(`Interview training purchased by user ${userId}`);
    // Add any specific logic for interview training
  }

  console.log(`Payment processed successfully for service: ${serviceTitle}`);
}

async function handlePaymentIntentSucceeded(paymentIntent: any) {
  console.log('Payment intent succeeded:', paymentIntent.id);
  // Additional logic for payment intent success if needed
}

async function handlePaymentIntentFailed(paymentIntent: any) {
  console.log('Payment intent failed:', paymentIntent.id);
  
  // Update payment status to failed
  await prisma.payment.updateMany({
    where: { transactionId: paymentIntent.id },
    data: { status: 'FAILED' }
  });
} 