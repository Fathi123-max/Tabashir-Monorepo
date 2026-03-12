import { NextResponse } from "next/server";
import { verifyRefresh, signAccessToken } from "@/app/utils/jwt";

export async function POST(req: Request) {
  try {
    const { refreshToken } = await req.json();
    console.log('[REFRESH] Request received, refreshToken length:', refreshToken?.length || 0);

    if (!refreshToken) {
      console.log('[REFRESH] ERROR: Missing refreshToken in request body');
      return NextResponse.json({ error: "Missing token" }, { status: 400 });
    }

    try {
      const payload = verifyRefresh(refreshToken);
      console.log('[REFRESH] Token verified successfully for user:', payload.email);

      // Remove iat and exp fields from payload before signing new token
      // jwt.verify() returns the decoded payload which includes exp/iat
      // But signAccessToken expects a payload without exp/iat
      const { iat, exp, ...cleanPayload } = payload;

      const accessToken = signAccessToken(cleanPayload);
      console.log('[REFRESH] New access token generated successfully');
      return NextResponse.json({ accessToken });
    } catch (jwtError) {
      console.log('[REFRESH] JWT verification failed:', jwtError);
      return NextResponse.json({ error: "Invalid or expired refresh token" }, { status: 401 });
    }
  } catch (parseError) {
    console.log('[REFRESH] Request parsing failed:', parseError);
    return NextResponse.json({ error: "Invalid request format" }, { status: 400 });
  }
}
