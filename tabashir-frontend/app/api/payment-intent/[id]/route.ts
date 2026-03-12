// app/api/payment-intent/[id]/route.ts
import { NextResponse } from 'next/server'

export async function GET(
  request: Request,
  { params }: { params: { id: string } }
) {
  const { id } = params

  const res = await fetch(
    `https://api-v2.ziina.com/api/payment_intent/${id}`,
    {
      headers: {
        Authorization: `Bearer ${process.env.ZIINA_API_KEY}`,
      },
      body: JSON.stringify({
        amount: 4000,
        currency_code: 'AED',
      }),
    }
  )

  if (!res.ok) {
    return NextResponse.json({ error: 'Unable to fetch intent' }, { status: res.status })
  }
  const data = await res.json()
  return NextResponse.json(data)
}
