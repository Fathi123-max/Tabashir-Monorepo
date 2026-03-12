import type { ButtonHTMLAttributes, ReactNode } from "react"
import Link from "next/link"

interface GradientButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  children: ReactNode
  className?: string
  href?: string
}

export function GradientButton({ children, className = "", href, ...props }: GradientButtonProps) {
  const buttonClasses = `py-2 px-4 bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white font-medium rounded-md hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#0D57E1] flex items-center justify-center ${className}`

  if (href) {
    return (
      <Link href={href} className={buttonClasses}>
        {children}
      </Link>
    )
  }

  return (
    <button className={buttonClasses} {...props}>
      {children}
    </button>
  )
}
