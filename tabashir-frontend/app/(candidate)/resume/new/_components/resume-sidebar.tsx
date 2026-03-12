"use client"

import type React from "react"

import Link from "next/link"
import { usePathname } from "next/navigation"
import { User, FileText, Briefcase, GraduationCap, Lightbulb, Languages, CheckCircle } from "lucide-react"
import { useResumeStore, type ResumeSection } from "../store/resume-store"
import { cn } from "@/lib/utils"

interface ResumeSidebarProps {
  resumeId: string
}

interface SidebarItem {
  id: ResumeSection
  label: string
  icon: React.ElementType
  href: string
}

const NavItem = ({
  href,
  icon: Icon,
  label,
  isActive,
  isCompleted,
}: {
  href: string
  icon: React.ElementType
  label: string
  isActive: boolean
  isCompleted: boolean
}) => {
  return (
    <Link
      href={href}
      className={cn(
        "flex items-center gap-3 rounded-[6px] text-sm font-medium transition-all",
        " justify-between pt-[25px] pr-[23px] pb-[25px] pl-3",
        "bg-white shadow-[0px_4px_4px_0px_rgba(0,0,0,0.25)] mb-[20px] ",
        isActive
          ? "bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white pl-[23px]"
          : "text-gray-700 hover:bg-gradient-to-r hover:from-[#042052] hover:to-[#0D57E1] hover:text-white hover:pl-[23px]",
      )}
    >
      <div className="flex items-center gap-3">
        <Icon size={18} />
        <span>{label}</span>
      </div>
      {isCompleted && <CheckCircle className={cn("h-4 w-4", isActive ? "text-white" : "text-green-500")} />}
    </Link>
  )
}

export function ResumeSidebar({ resumeId }: ResumeSidebarProps) {
  const pathname = usePathname()
  const { isFormCompleted } = useResumeStore()

  const sidebarItems: SidebarItem[] = [
    {
      id: "personal-details",
      label: "Personal Details",
      icon: User,
      href: `/resume/new/${resumeId}/personal-details`,
    },
    {
      id: "professional-summary",
      label: "Professional Summary",
      icon: FileText,
      href: `/resume/new/${resumeId}/professional-summary`,
    },
    {
      id: "employment-history",
      label: "Work Experience",
      icon: Briefcase,
      href: `/resume/new/${resumeId}/employment-history`,
    },
    {
      id: "education",
      label: "Education",
      icon: GraduationCap,
      href: `/resume/new/${resumeId}/education`,
    },
    {
      id: "skills",
      label: "Skills",
      icon: Lightbulb,
      href: `/resume/new/${resumeId}/skills`,
    }
  ]

  return (
    <div className="w-[310px] h-full max-lg:w-full">
      <nav className="">
        {sidebarItems.map((item) => {
          const isActive = pathname === item.href
          const isCompleted = isFormCompleted(item.id)

          return (
            <NavItem
              key={item.id}
              href={item.href}
              icon={item.icon}
              label={item.label}
              isActive={isActive}
              isCompleted={isCompleted}
            />
          )
        })}
      </nav>
    </div>
  )
}
