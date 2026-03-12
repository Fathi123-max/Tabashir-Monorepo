import Image from "next/image";
import Link from "next/link";
import { Button } from "@/components/ui/button";

import RegistrationForm from "@/components/forms/registration/candidate";
import { signIn } from "@/app/utils/auth";

export default function CandidateRegistration() {
  return (
    <div className="grid lg:grid-cols-2 min-h-screen w-full">
      <div className="flex flex-col justify-center px-8 py-12 sm:px-3 mx-auto w-[500px] max-w-full max-sm:w-full">

        <RegistrationForm />

        <div className="mt-6 flex items-center">
          <div className="flex-grow h-px bg-gray-300"></div>
          <span className="px-4 text-sm text-gray-500">Or</span>
          <div className="flex-grow h-px bg-gray-300"></div>
        </div>

        <form
          action={async () => {
            "use server";
            await signIn("google", {
              redirectTo: "/candidate/social/callback"
            });
          }}
        >
          <Button
            type="submit"
            variant="outline"
            className="mt-6 w-full flex items-center justify-center py-2 px-4 bg-[#E6F0FA] text-sm font-medium text-gray-700 hover:bg-opacity-80"
          >
            <svg className="h-5 w-5 mr-2" viewBox="0 0 24 24">
              <path
                d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
                fill="#4285F4"
              />
              <path
                d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
                fill="#34A853"
              />
              <path
                d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"
                fill="#FBBC05"
              />
              <path
                d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
                fill="#EA4335"
              />
              <path d="M1 1h22v22H1z" fill="none" />
            </svg>
            Google
          </Button>
        </form>
      </div>

      <div className="hidden lg:flex flex-col items-center justify-center w-full bg-[#E6F0FA]">
        <div className="max-w-lg px-8 text-center">
          <h2 className="text-3xl font-bold text-center mb-2 text-black">TABASHIR</h2>
          <h3 className="text-4xl font-bold text-[#002B6B] mb-4">Signup</h3>
          <p className="text-lg mb-8 text-black ">
            Getting you on board for your job searching process
          </p>

          <Image
            src="https://hebbkx1anhila5yf.public.blob.vercel-storage.com/candidate_login_image-sPDvrtKbYeiNB32TJrUNmswgRxGoHN.svg"
            alt="Job search illustration"
            width={500}
            height={400}
            priority
            className="mx-auto"
          />
        </div>
      </div>
    </div>
  );
}
