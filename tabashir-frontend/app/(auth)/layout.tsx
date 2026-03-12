import type React from "react"
import Image from "next/image"

export default function AuthLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return <div className="">
    <Image src="/logo.png" alt="logo" width={200} height={100} className="pt-8 px-4 hidden max-lg:block" />
    {children}
  </div>
}
