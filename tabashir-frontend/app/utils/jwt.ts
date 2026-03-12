import jwt from "jsonwebtoken";

interface JWTPayload {
  id: string;
  email: string;
  userType: string;
  iat?: number;
  exp?: number;
}

/**
 * Sign an access token
 */
export function signAccessToken(payload: Omit<JWTPayload, "iat" | "exp">) {
  const secret = process.env.JWT_ACCESS_SECRET;
  if (!secret) {
    throw new Error("JWT_ACCESS_SECRET is not configured");
  }

  return jwt.sign(payload, secret, {
    expiresIn: "15m", // 15 minutes
  });
}

/**
 * Sign a refresh token
 */
export function signRefreshToken(payload: Omit<JWTPayload, "iat" | "exp">) {
  const secret = process.env.JWT_REFRESH_SECRET;
  if (!secret) {
    throw new Error("JWT_REFRESH_SECRET is not configured");
  }

  return jwt.sign(payload, secret, {
    expiresIn: "7d", // 7 days
  });
}

/**
 * Verify an access token
 */
export function verifyAccess(token: string): JWTPayload {
  const secret = process.env.JWT_ACCESS_SECRET;
  if (!secret) {
    throw new Error("JWT_ACCESS_SECRET is not configured");
  }

  try {
    const decoded = jwt.verify(token, secret) as JWTPayload;
    return decoded;
  } catch (error) {
    throw new Error("Invalid or expired access token");
  }
}

/**
 * Verify a refresh token
 */
export function verifyRefresh(token: string): JWTPayload {
  const secret = process.env.JWT_REFRESH_SECRET;
  if (!secret) {
    throw new Error("JWT_REFRESH_SECRET is not configured");
  }

  try {
    const decoded = jwt.verify(token, secret) as JWTPayload;
    return decoded;
  } catch (error) {
    throw new Error("Invalid or expired refresh token");
  }
}

/**
 * Extract token from Authorization header
 */
export function extractTokenFromHeader(authHeader: string | null): string | null {
  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return null;
  }
  return authHeader.replace("Bearer ", "");
}
