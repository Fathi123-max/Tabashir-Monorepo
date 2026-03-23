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
            <Image
              src="/icons/google.svg"
              alt="Google logo"
              width={20}
              height={20}
              className="mr-2"
            />
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
