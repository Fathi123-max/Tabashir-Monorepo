"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import {
  LayoutDashboard,
  Briefcase,
  Calendar,
  FileText,
  User,
  HelpCircle,
  LogOut,
  CreditCard,
  Users,
  Mail,
  UserCog,
  ChevronRight,
  Book,
} from "lucide-react";
import { signOut } from "@/app/utils/auth";
import { onLogout } from "@/actions/auth";
import { useAdminPermissions } from "@/hooks/use-admin-permissions";
import { AdminPermission } from "@prisma/client";

interface SidebarProps {
  open: boolean;
  setOpen: (open: boolean) => void;
}

export default function Sidebar({ open, setOpen }: SidebarProps) {
  const pathname = usePathname();
  // const { canAccess, isLoading } = useAdminPermissions();

  const navItems = [
    {
      name: "Dashboard",
      href: "/admin/dashboard",
      icon: LayoutDashboard,
      permission: AdminPermission.MANAGE_DASHBOARD,
    },
    {
      name: "Jobs",
      href: "/admin/jobs",
      icon: Briefcase,
      permission: AdminPermission.MANAGE_JOBS,
    },
    {
      name: "Users",
      href: "/admin/users",
      icon: Users,
      permission: AdminPermission.MANAGE_USERS,
    },
    {
      name: "AI Resumes",
      href: "/admin/aicv",
      icon: FileText,
      permission: AdminPermission.MANAGE_AI_CV,
    },
    {
      name: "Applications",
      href: "/admin/applications",
      icon: Mail,
      permission: AdminPermission.MANAGE_APPLICATIONS,
    },
    {
      name: "Payments",
      href: "/admin/payments",
      icon: CreditCard,
      permission: AdminPermission.MANAGE_PAYMENTS,
    },
    {
      name: "Courses",
      href: "/admin/courses",
      icon: Book,
    },
    {
      name: "Manage Admins",
      href: "/admin/manage-admins",
      icon: UserCog,
      permission: AdminPermission.MANAGE_ADMIN_PERMISSIONS,
    },
  ];

  // Filter navigation items based on permissions
  const accessibleNavItems = navItems.filter(item => true);

  const profileItems = [
    {
      name: "Account",
      href: "/admin/account",
      icon: User,
      permission: AdminPermission.MANAGE_ACCOUNT,
    },
    {
      name: "Help Center",
      href: "/admin/help",
      icon: HelpCircle,
      permission: AdminPermission.MANAGE_HELP,
    },
  ];

  // Filter profile items based on permissions
  const accessibleProfileItems = profileItems.filter(item => true);

  return (
    <aside
      className={`bg-gradient-to-b from-slate-50 to-white border-r border-slate-200/60 w-72 sticky top-0 inset-y-0 left-0 z-50 transform h-screen shadow-sm ${open ? "translate-x-0" : "-translate-x-full"
        } transition-transform duration-300 ease-in-out md:translate-x-0 md:static md:inset-auto`}
    >
      <div className="flex flex-col h-full">
        {/* Logo Section */}
        <div className="p-6 border-b border-slate-200/60 bg-white/50 backdrop-blur-sm">
          <div className="flex items-center space-x-3">
            <div className="w-10 h-10 bg-gradient-to-br from-blue-600 to-blue-700 rounded-xl flex items-center justify-center shadow-lg">
              <span className="text-white font-bold text-lg">T</span>
            </div>
            <div>
              <h1 className="text-xl font-bold bg-gradient-to-r from-slate-800 to-slate-600 bg-clip-text text-transparent">
                TABASHIR
              </h1>
              <p className="text-xs text-slate-500 font-medium">Admin Panel</p>
            </div>
          </div>
        </div>

        {/* Navigation Section */}
        <nav className="flex-1 px-4 py-6 space-y-2 overflow-y-auto">
          <div className="mb-4">
            <h2 className="text-xs font-semibold text-slate-500 uppercase tracking-wider px-4 mb-3">
              Main Navigation
            </h2>
            <div className="space-y-1">
              {accessibleNavItems.map((item) => {
                const isActive = pathname.includes(item.href);

                return (
                  <Link
                    key={item.name}
                    href={item.href}
                    className={`group flex items-center px-4 py-3 rounded-xl text-sm font-medium transition-all duration-200 ${isActive
                      ? "bg-gradient-to-r from-blue-600 to-blue-700 text-white shadow-lg shadow-blue-500/25"
                      : "text-slate-700 hover:bg-slate-100 hover:text-slate-900"
                      }`}
                  >
                    <div className={`p-1.5 rounded-lg mr-3 transition-all duration-200 ${isActive
                      ? "bg-white/20"
                      : "bg-slate-100 group-hover:bg-slate-200"
                      }`}>
                      <item.icon
                        className={`h-4 w-4 ${isActive ? "text-white" : "text-slate-600"
                          }`}
                      />
                    </div>
                    <span className="flex-1">{item.name}</span>
                    {isActive && (
                      <ChevronRight className="h-4 w-4 text-white/80" />
                    )}
                  </Link>
                );
              })}
            </div>
          </div>

          {/* Profile Section */}
          {accessibleProfileItems.length > 0 && (
            <div className="pt-4 border-t border-slate-200/60">
              <h2 className="text-xs font-semibold text-slate-500 uppercase tracking-wider px-4 mb-3">
                Account
              </h2>
              <div className="space-y-1">
                {accessibleProfileItems.map((item) => {
                  const isActive = pathname === item.href;
                  return (
                    <Link
                      key={item.name}
                      href={item.href}
                      className={`group flex items-center px-4 py-3 rounded-xl text-sm font-medium transition-all duration-200 ${isActive
                        ? "bg-gradient-to-r from-blue-600 to-blue-700 text-white shadow-lg shadow-blue-500/25"
                        : "text-slate-700 hover:bg-slate-100 hover:text-slate-900"
                        }`}
                    >
                      <div className={`p-1.5 rounded-lg mr-3 transition-all duration-200 ${isActive
                        ? "bg-white/20"
                        : "bg-slate-100 group-hover:bg-slate-200"
                        }`}>
                        <item.icon
                          className={`h-4 w-4 ${isActive ? "text-white" : "text-slate-600"
                            }`}
                        />
                      </div>
                      <span className="flex-1">{item.name}</span>
                      {isActive && (
                        <ChevronRight className="h-4 w-4 text-white/80" />
                      )}
                    </Link>
                  );
                })}
              </div>
            </div>
          )}
        </nav>

        {/* Logout Section */}
        <div className="p-4 border-t border-slate-200/60 bg-white/50 backdrop-blur-sm">
          <button
            className="group flex items-center px-4 py-3 text-sm font-medium text-red-600 hover:bg-red-50 hover:text-red-700 rounded-xl w-full transition-all duration-200"
            onClick={() => {
              onLogout("/admin/login");
            }}
          >
            <div className="p-1.5 rounded-lg mr-3 bg-red-100 group-hover:bg-red-200 transition-all duration-200">
              <LogOut className="h-4 w-4" />
            </div>
            <span>Logout</span>
          </button>
        </div>
      </div>
    </aside>
  );
}
