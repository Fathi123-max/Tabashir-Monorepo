import { NextRequest, NextResponse } from 'next/server';
import jwt from 'jsonwebtoken';
import { prisma } from '@/lib/prisma';
import crypto from 'crypto';

export async function POST(request: NextRequest) {
  try {
    const { identityToken } = await request.json();

    if (!identityToken) {
      return NextResponse.json(
        { error: 'Missing identityToken' },
        { status: 400 }
      );
    }

    try {
      // Decode Apple ID token (base64)
      // Apple ID token structure: header.payload.signature
      const tokenParts = identityToken.split('.');
      if (tokenParts.length !== 3) {
        throw new Error('Invalid token format');
      }

      // Decode payload (user info is here)
      const payload = JSON.parse(
        Buffer.from(tokenParts[1], 'base64').toString()
      );

      const email = payload.email;
      const appleId = payload.sub;
      const isEmailVerified = payload.email_verified === 'true';

      // Find or create user based on email
      let user = await prisma.user.findUnique({
        where: { email },
      });

      // If user doesn't exist, create a new one
      if (!user) {
        user = await prisma.user.create({
          data: {
            email,
            name: payload.fullName || 'Apple User',
            emailVerified: isEmailVerified ? new Date() : null,
            userType: 'CANDIDATE',
            // Generate a unique referral code
            referralCode: crypto.randomBytes(8).toString('hex'),
          },
        });

        // Create Candidate profile
        await prisma.candidate.create({
          data: {
            userId: user.id,
          },
        });
      }

      // Create or update Account record
      await prisma.account.upsert({
        where: {
          provider_providerAccountId: {
            provider: 'apple',
            providerAccountId: appleId,
          },
        },
        update: {
          userId: user.id,
          access_token: identityToken,
          id_token: identityToken,
        },
        create: {
          userId: user.id,
          type: 'oauth',
          provider: 'apple',
          providerAccountId: appleId,
          access_token: identityToken,
          id_token: identityToken,
        },
      });

      // Generate app JWT access token (using JWT_ACCESS_SECRET for compatibility with verifyAccess)
      const accessToken = jwt.sign(
        {
          id: user.id, // Use the actual user ID from database
          email: user.email,
          userType: user.userType || 'CANDIDATE',
          provider: 'apple',
          isEmailVerified,
        },
        process.env.JWT_ACCESS_SECRET || process.env.JWT_SECRET || 'your-secret-key',
        { expiresIn: '15m' } // Match access token expiration
      );

      // Generate refresh token
      const refreshToken = jwt.sign(
        {
          id: user.id,
          email: user.email,
          userType: user.userType || 'CANDIDATE',
          provider: 'apple',
        },
        process.env.JWT_REFRESH_SECRET || process.env.JWT_ACCESS_SECRET || process.env.JWT_SECRET || 'your-secret-key',
        { expiresIn: '7d' }
      );

      return NextResponse.json({
        success: true,
        token: accessToken,
        refreshToken: refreshToken,
        user: {
          id: user.id,
          email: user.email,
          name: user.name,
          userType: user.userType,
          provider: 'apple',
          createdAt: user.createdAt,
        },
        accessToken: accessToken,
      });

    } catch (tokenError) {
      console.error('Token decode error:', tokenError);
      return NextResponse.json(
        { error: 'Invalid Apple ID token' },
        { status: 401 }
      );
    }

  } catch (error) {
    console.error('Apple sign-in error:', error);
    return NextResponse.json(
      { error: 'Apple sign-in failed' },
      { status: 500 }
    );
  }
}
