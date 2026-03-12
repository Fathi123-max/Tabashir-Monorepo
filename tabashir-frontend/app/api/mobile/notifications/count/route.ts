import { NextResponse } from "next/server";
import { verifyAccess } from "@/app/utils/jwt";

function getAuthHeader(req: Request) {
  const h = req.headers.get("authorization") || "";
  const m = h.match(/^Bearer\s+(.+)$/i);
  return m?.[1];
}

export async function GET(req: Request) {
  try {
    const token = getAuthHeader(req);
    if (!token) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const { id } = verifyAccess(token);

    // For now, return a mock count
    // In a real implementation, you would query a notifications table
    // Example: const unreadCount = await prisma.notification.count({ where: { userId: id, read: false } });

    const unreadCount = Math.floor(Math.random() * 10); // Random count for demo

    return NextResponse.json({
      unreadCount,
      hasUnread: unreadCount > 0,
    });
  } catch (error) {
    console.error('Notification count error:', error);
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
}
