"use client";
import React, { useState } from "react";
import Sidebar from "./sidebar";
import Header from "./header";

const RecruiterLayoutContent = ({ children }: { children: React.ReactNode }) => {
  const [sidebarOpen, setSidebarOpen] = useState(true);
  return (
    <>
      <Sidebar open={sidebarOpen} setOpen={setSidebarOpen} />
      <div className="flex flex-col flex-1 overflow-hidden">
        <Header sidebarOpen={sidebarOpen} setSidebarOpen={setSidebarOpen} />
        <main className="flex-1 overflow-y-auto">{children}</main>
      </div>
    </>
  );
};

export default RecruiterLayoutContent; 