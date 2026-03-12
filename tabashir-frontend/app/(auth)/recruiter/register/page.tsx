import Image from "next/image";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import RecruiterRegistrationForm from "@/components/forms/registration/recruiter";

export default function RecruiterRegistration() {
  return (
    <div className="grid lg:grid-cols-2 min-h-screen w-full">
      <div className="flex flex-col justify-center px-8 py-12 sm:px-3 mx-auto w-[500px] max-w-full max-sm:w-full">
        <div className="mb-8">
          <h1 className="text-2xl font-bold text-gray-900">Join as a Recruiter</h1>
          <p className="mt-2 text-sm text-gray-600">
            Create your company account to start posting jobs and finding the best talent
          </p>
        </div>

        <RecruiterRegistrationForm />

        <div className="mt-6 text-center text-sm">
          <span className="text-gray-500">Already have an account? </span>
          <Link
            href="/recruiter/login"
            className="text-[#002B6B] font-medium hover:underline"
          >
            Log in
          </Link>
        </div>
      </div>

      <div className="hidden lg:flex flex-col items-center justify-center w-full bg-[#E6F0FA]">
        <div className="max-w-lg px-8 text-center">
          <h2 className="text-3xl font-bold text-center mb-2 text-black">TABASHIR</h2>
          <h3 className="text-4xl font-bold text-[#002B6B] mb-4">Recruiter Signup</h3>
          <p className="text-lg mb-8 text-black">
            Join our platform to find and hire the best talent for your company
          </p>

          <Image
            src="https://hebbkx1anhila5yf.public.blob.vercel-storage.com/candidate_login_image-sPDvrtKbYeiNB32TJrUNmswgRxGoHN.svg"
            alt="Recruiter illustration"
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