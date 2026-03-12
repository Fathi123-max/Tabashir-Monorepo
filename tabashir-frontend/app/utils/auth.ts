import NextAuth from "next-auth";
import GitHub from "next-auth/providers/github";
import { PrismaAdapter } from "@auth/prisma-adapter";
import { prisma } from "./db";
import Credentials from "next-auth/providers/credentials";
import Google from "next-auth/providers/google";
import { compare } from "bcryptjs";
import { UserType, User } from "@prisma/client";

type UserWithRelations = User & {
  candidate: any | null;
  Owner: any | null;
  Recruiter: any | null;
};

export const { handlers, signIn, signOut, auth } = NextAuth({
  adapter: PrismaAdapter(prisma),
  providers: [
    Google,
    Credentials({
      credentials: {
        email: { label: "Username" },
        password: { label: "Password", type: "password" },
      },
      async authorize(credentials) {
        if (!credentials?.email || typeof credentials.email !== "string") {
          return null;
        }

        const user = (await prisma.user.findUnique({
          where: { email: credentials.email },
          include: {
            candidate: true,
            Owner: true,
            Recruiter: true,
          },
        })) as UserWithRelations | null;
        console.log("User: ", user);
        if (!user) {
          return null;
        }

        // Check if email is verified for credential-based users
        if (!user.emailVerified) {
          console.log("Email not verified for user:", user.email);
          return null;
        }

        // If user is a candidate, verify password
        if (
          !credentials.password ||
          typeof credentials.password !== "string" ||
          !user.password
        ) {
          return null;
        }

        const isPasswordValid = await compare(
          credentials.password,
          user.password
        );

        console.log("Pasword matched: ", isPasswordValid)
        if (!isPasswordValid) {
          return null;
        }

        return {
          id: user.id,
          email: user.email,
          name: user.name,
          userType: user.userType || UserType.CANDIDATE,
          image: user.image || "",
        };
      },
    }),
  ],
  callbacks: {
    async signIn({ user, account, profile }) {
      // For OAuth providers (like Google), automatically verify email
      if (account?.provider === "google" && user.email) {
        try {
          await prisma.user.update({
            where: { email: user.email },
            data: { 
              emailVerified: new Date(),
              // Set default userType if not set
              userType: (user.userType as UserType) || UserType.CANDIDATE
            },
          });
        } catch (error) {
          console.error("Error updating user verification status:", error);
        }
      }
      return true;
    },
    async jwt({ token, user, account }) {
      if (user) {
        token.id = user.id; // Add id
        token.userType = user.userType; // Add role
      }
      
      // For Google OAuth, ensure user type is set
      if (account?.provider === "google" && token.email) {
        try {
          const dbUser = await prisma.user.findUnique({
            where: { email: token.email },
            select: { userType: true }
          });
          if (dbUser) {
            token.userType = dbUser.userType || UserType.CANDIDATE;
          }
        } catch (error) {
          console.error("Error fetching user type:", error);
        }
      }
      
      return token;
    },
    async session({ session, token }) {
      if (session.user) {
        session.user.id = token.id as string; // Attach id
        session.user.userType = token.userType as string; // Attach role
      }
      return session;
    },
  },
  session: {
    strategy: "jwt",
  },
  secret: process.env.NEXTAUTH_SECRET,
  pages: {
    signIn: "/candidate/login", // Redirect to login page for auth errors
  },
});
