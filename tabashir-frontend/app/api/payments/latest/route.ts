import { NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url)
    const userId = searchParams.get('userId')
    
    if (!userId) {
      return NextResponse.json({ error: 'User ID required' }, { status: 400 })
    }

    const latestPayment = await prisma.payment.findFirst({
      where: {
        userId: userId
      },
      orderBy: {
        createdAt: 'desc'
      },
      select: {
        id: true,
        amount: true,
        currency: true,
        status: true,
        createdAt: true
      }
    })

    if (!latestPayment) {
      return NextResponse.json({ payment: null })
    }

    // Convert amount from cents to actual amount (assuming it's stored in cents)
    const formattedPayment = {
      ...latestPayment,
      amount: latestPayment.amount / 100,
      formattedDate: latestPayment.createdAt.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
      })
    }

    return NextResponse.json({ payment: formattedPayment })
  } catch (error) {
    console.error('Error fetching latest payment:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
} 