"use client";

import { useState } from "react";
import { usePathname } from "next/navigation";
import { Menu, X } from "lucide-react";
import { Sidebar } from "./sidebar";
import { useTranslation } from "@/lib/use-translation";

export default function SidebarLayout() {
  const pathname = usePathname();
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const { t, isRTL } = useTranslation();

  if (pathname.startsWith("/resume/new")) return null;

  const toggleMobileMenu = () => {
    setIsMobileMenuOpen(!isMobileMenuOpen);
  };

  const closeMobileMenu = () => {
    setIsMobileMenuOpen(false);
  };

  return (
    <>
      {/* Mobile Menu Button */}
      <button
        onClick={toggleMobileMenu}
        className={`lg:hidden fixed top-4 z-50 p-2 bg-white rounded-md shadow-md border ${isRTL ? 'right-4' : 'left-4'}`}
        aria-label={t('toggleMenu')}
      >
        {isMobileMenuOpen ? (
          <X className="h-6 w-6 text-gray-600" />
        ) : (
          <Menu className="h-6 w-6 text-gray-600" />
        )}
      </button>


      {/* Desktop Sidebar */}
      <div className="hidden lg:block sticky top-[16px] h-[calc(100vh-35px)]">
        <Sidebar />
      </div>

      {/* Mobile Sidebar Overlay */}
      {isMobileMenuOpen && (
        <div className="lg:hidden fixed inset-0 z-40">
          {/* Backdrop */}
          <div
            className="fixed inset-0 bg-black bg-opacity-50"
            onClick={toggleMobileMenu}
          />

          {/* Sidebar */}
          <div className={`fixed top-0 h-full w-[280px] bg-white shadow-lg transform transition-transform duration-300 ease-in-out translate-x-0 ${isRTL ? 'right-0' : 'left-0'}`}>
            <div className="pt-16 h-full"> {/* Add padding to account for close button */}
              <Sidebar onNavigate={closeMobileMenu} />
            </div>
          </div>
        </div>
      )}
    </>
  );
}
