import { NextResponse } from "next/server";
import { prisma } from "@/app/utils/db";
import { compare } from "bcryptjs";
import { signAccessToken, signRefreshToken } from "@/app/utils/jwt";

export async function POST(req: Request) {
  try {
    const { email, password } = await req.json();
    if (!email || !password) {
      return NextResponse.json({ error: "Email & password required" }, { status: 400 });
    }

    const user = await prisma.user.findUnique({
      where: { email },
      select: { id: true, email: true, name: true, password: true, userType: true },
    });
    if (!user || !user.password) {
      return NextResponse.json({ error: "Invalid credentials" }, { status: 401 });
    }

    if (!user.email) {
    return NextResponse.json({ error: "Account has no email" }, { status: 409 });
  }
    const ok = await compare(password, user.password);
    if (!ok) return NextResponse.json({ error: "Invalid credentials" }, { status: 401 });

    const payload = {
      id: user.id,
      email: user.email,
      userType: user.userType?.toString() ?? "",
    };
    const accessToken = signAccessToken(payload);
    const refreshToken = signRefreshToken(payload);

    console.log('[LOGIN] Generated tokens for user:', user.email);
    console.log('[LOGIN] Access token length:', accessToken.length);
    console.log('[LOGIN] Refresh token length:', refreshToken.length);

    return NextResponse.json({
      user: { id: user.id, name: user.name, email: user.email, userType: user.userType },
      accessToken,
      refreshToken,
    });
  } catch {
    return NextResponse.json({ error: "Server error" }, { status: 500 });
  }
}
