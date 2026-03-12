import type { Metadata } from 'next'
import './globals.css'
import { Toaster } from 'sonner'

import { Poppins } from 'next/font/google'

export const metadata: Metadata = {
  title: 'Tabashir',
  description: 'Joabboard platform',
}

const poppins = Poppins({
  subsets: ['latin'],
  weight: ['400', '500', '600', '700', '800', '900'],
  variable: '--font-poppins',
})

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en">
      <body className={poppins.className}>
        <Toaster />
        {children}
      </body>
    </html>
  )
}
