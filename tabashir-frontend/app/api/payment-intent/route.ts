// app/api/payment-intent/route.ts
import { NextResponse } from 'next/server'

const ZIINA_API = 'https://api-v2.ziina.com/api/payment_intent'

export async function POST(request: Request) {
  const { amount, currency, successUrl, cancelUrl } = await request.json()

  const res = await fetch(ZIINA_API, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${process.env.ZIINA_API_KEY}`,
    },
    body: JSON.stringify({
      amount,                // in fils, e.g. AED 50 → 5000
      currency_code: currency,
      success_url: successUrl,
      cancel_url: cancelUrl,
      failure_url: cancelUrl,   // optional
      test: true,               // set false in production
      transaction_source: 'directApi',
    }),
  })

  const data = await res.json()
  return NextResponse.json(data, { status: res.status })
}
