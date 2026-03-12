"use client"

import { useTranslation } from "@/lib/use-translation";
import { SessionProvider, useSession } from "next-auth/react";
import { Button } from "@/components/ui/button";
import Link from "next/link";
import { User } from "lucide-react";
import { UserProfileHeader } from "./dashboard/_components/user-profile-header";
import SidebarLayout from "./dashboard/_components/sidebar-layout";
import { usePathname } from "next/navigation";
import { useEffect, useState } from "react";

interface UserData {
  aiJobApplyCount: number;
  jobCount: number;
}

export default function CandidateLayout({
  children,
  session,
}: {
  children: React.ReactNode,
  session: any
}) {
  const pathname = usePathname();
  const { isRTL } = useTranslation();
  const [userData, setUserData] = useState<UserData | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchUserData = async () => {
      try {
        const response = await fetch('/api/user/profile');
        if (response.ok) {
          const data = await response.json();
          setUserData(data.user);
        }
      } catch (error) {
        console.error('Error fetching user data:', error);
      } finally {
        setLoading(false);
      }
    };

    if (session?.user?.email) {
      fetchUserData();
    }
  }, [session?.user?.email]);

  return (
    <SessionProvider>
      <div className={`flex ${isRTL ? 'flex-row-reverse gap-10' : 'flex-row gap-4'} bg-[#F0F0F0] p-4 relative min-h-screen`}>
        <SidebarLayout />
        <div className="flex-1 flex flex-col">
          <main className="pl-0 lg:pl-4 lg:pt-0 flex-1">
            <div className={`max-w-7xl max-md:max-w-[90vw] mx-auto py-2 ${pathname.startsWith("/resume") ? 'mb-6' : ''}`}>
              <div className={`flex items-center mb-2 ${isRTL ? 'flex-row-reverse' : 'flex-row'} ${pathname.startsWith("/resume") ? 'max-md:flex-col justify-between' : 'justify-end'}`}>

                {pathname.startsWith("/resume") && <h1 className="text-4xl font-bold text-gray-900 mb-6">TABASHIR</h1>}
                <div className="flex items-center gap-[8px]">
                  {pathname.startsWith("/ai-job-apply") && (
                    <p className="flex items-center gap-3 bg-white pl-[7px] pr-4 py-2 rounded-full border text-gray-900 border-gray-200 text-sm font-medium">
                      {loading ? '...' : userData?.aiJobApplyCount || 0} AI Job Apply
                    </p>
                  )}
                  {pathname.startsWith("/jobs") && (
                    <p className="flex items-center gap-1 bg-white px-4 py-2 rounded-full border text-gray-900 border-gray-200 text-sm font-medium">
                      {loading ? '...' : userData?.jobCount || 0} <span className="text-gray-500">Apply</span>
                    </p>
                  )}
                  <Button variant="outline" asChild className="flex items-center gap-3 bg-white pl-[7px] pr-4 py-5 rounded-full border text-gray-900 border-gray-200">
                    <Link href="/account">
                      {session.user.image ? <img src={session.user.image} alt="logo" className="w-8 h-8 rounded-full border border-gray-200" /> : <User className="w-8 h-8" />}
                      <span className="text-[14px] font-medium">{session.user.name}</span>
                    </Link>
                  </Button>
                  <UserProfileHeader />
                </div>
              </div>
              {children}
            </div>
          </main>
        </div>
      </div>
    </SessionProvider>
  )
}