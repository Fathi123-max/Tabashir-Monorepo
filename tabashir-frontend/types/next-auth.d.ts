import  { DefaultSession, DefaultUser } from "next-auth";

// Extend the User interface to include id and role
declare module "next-auth" {
  interface Session {
    user: {
      id: string;
      userType: string;
    } & DefaultSession["user"];
  }

  interface User extends DefaultUser {
    id: string;
    userType: string;
  }
}