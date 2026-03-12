"use client"

import Link from "next/link"
import { usePathname } from "next/navigation"
import {
  LayoutDashboard,
  Briefcase,
  ClipboardList,
  Heart,
  FileText,
  Sparkles,
  Video,
  Info,
  MessageCircle,
  BookOpen,
  User,
  LogOut,
} from "lucide-react"
import { onLogout } from "@/actions/auth"
import Image from "next/image"
import { useTranslation } from "@/lib/use-translation"

interface SidebarProps {
  onNavigate?: () => void;
}

export function Sidebar({ onNavigate }: SidebarProps) {
  const pathname = usePathname()
  const { t, isRTL } = useTranslation()

  const isActive = (path: string) => {
    return pathname === path
  }

  const handleNavigation = () => {
    if (onNavigate) {
      onNavigate();
    }
  };

  const navItems = [
    { icon: LayoutDashboard, label: t("dashboard"), href: "/dashboard" },
    { icon: Briefcase, label: t("jobs"), href: "/jobs" },
    { icon: ClipboardList, label: t("appliedJobs"), href: "/applied-jobs" },
    { icon: Heart, label: t("likedJobs"), href: "/liked-jobs" },
    { icon: FileText, label: t("resume"), href: "/resume" },
    { icon: Sparkles, label: t("aiJobApply"), href: "/ai-job-apply" },
    { icon: Video, label: t("interview"), href: "/interview-training" },
    { icon: Info, label: t("services"), href: "/service-details" },
    { icon: MessageCircle, label: t("whatsappCommunity"), href: "/whatsapp-community" },
    { icon: BookOpen, label: t("courses"), href: "/free-courses" },
  ]

  return (
    <div className={`h-full w-full lg:w-[250px] bg-white border-r flex flex-col rounded-lg p-3 ${isRTL ? 'rtl' : 'ltr'}`}>
      <div className="px-3 pb-4 pt-5 border-b mb-3 max-lg:hidden">
        <Image src="/logo.png" alt="logo" width={217} height={32} className="mx-auto" />
      </div>

      <div className="flex-1 overflow-auto py-4 max-lg:py-1">
        <nav className="px-2">
          {navItems.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              onClick={handleNavigation}
              className={`flex items-center px-2 py-2 mb-2 text-base font-medium rounded-md ${isActive(item.href)
                  ? "blue-gradient text-white"
                  : "text-gray-700 hover:bg-gray-100"
                } ${isRTL ? 'flex-row-reverse text-right' : 'flex-row text-left'}`}
            >
              <item.icon className={`h-5 w-5 ${isRTL ? 'ml-3' : 'mr-3'}`} />
              <span>{item.label}</span>
            </Link>
          ))}
        </nav>
      </div>

      <div className="p-4 border-t">
        <Link
          href="/account"
          onClick={handleNavigation}
          className={`flex items-center px-2 py-2 text-sm rounded-md text-gray-700 hover:bg-gray-100 ${isRTL ? 'flex-row-reverse text-right' : 'flex-row text-left'
            }`}
        >
          <User className={`h-5 w-5 ${isRTL ? 'ml-3' : 'mr-3'}`} />
          <span>{t("account")}</span>
        </Link>
        <button
          onClick={() => {
            onLogout("/candidate/login")
          }}
          className={`flex items-center px-2 py-2 mt-2 text-sm rounded-md text-red-500 hover:bg-gray-100 w-full ${isRTL ? 'flex-row-reverse text-right' : 'flex-row text-left'
            }`}
        >
          <LogOut className={`h-5 w-5 ${isRTL ? 'ml-3' : 'mr-3'}`} />
          <span>{t("logout")}</span>
        </button>
      </div>
    </div>
  )
}
