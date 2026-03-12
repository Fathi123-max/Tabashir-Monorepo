import type React from "react";
import OwnerLayoutContent from "./layout-content";
import { auth } from "../utils/auth";
import { redirect } from "next/navigation";
import { SessionProvider } from "next-auth/react";

export default async function OwnerLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const session = await auth();
  console.log("Session form candidata layout: ", session);
  if (!session?.user || session.user.userType !== "ADMIN") {
    redirect("/admin/login");
  }
  return (
    <SessionProvider>
      <div className="flex bg-[#F0F0F0] text-gray-900">
        <OwnerLayoutContent>{children}</OwnerLayoutContent>
      </div>
    </SessionProvider>
  );
}
