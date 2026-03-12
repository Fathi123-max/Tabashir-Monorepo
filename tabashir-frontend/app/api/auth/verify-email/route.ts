import { NextRequest, NextResponse } from "next/server";
import { verifyEmail } from "@/actions/auth";

export async function GET(request: NextRequest) {
  try {
    const searchParams = request.nextUrl.searchParams;
    const token = searchParams.get("token");

    if (!token) {
      return NextResponse.redirect(
        new URL("/candidate/login?error=missing-token", request.url)
      );
    }

    const result = await verifyEmail(token);

    if (result.error) {
      return NextResponse.redirect(
        new URL(`/candidate/login?error=${encodeURIComponent(result.message)}`, request.url)
      );
    }

    return NextResponse.redirect(
      new URL(`/candidate/login?success=${encodeURIComponent(result.message)}`, request.url)
    );
  } catch (error) {
    console.error("Email verification error:", error);
    return NextResponse.redirect(
      new URL("/candidate/login?error=verification-failed", request.url)
    );
  }
} 