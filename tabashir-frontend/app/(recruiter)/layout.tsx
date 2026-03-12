import type React from "react";
import RecruiterLayoutContent from "./_components/layout-content";
import { auth } from "../utils/auth";
import { redirect } from "next/navigation";
import { SessionProvider } from "next-auth/react";

export default async function RecruiterLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const session = await auth();

  if (!session?.user || session.user.userType !== "RECURITER") {
    redirect("/recruiter/login");
  }

  return (
    <SessionProvider>
      <div className="flex h-screen bg-[#F0F0F0] text-gray-900">
        <RecruiterLayoutContent>{children}</RecruiterLayoutContent>
      </div>
    </SessionProvider>
  );
} 