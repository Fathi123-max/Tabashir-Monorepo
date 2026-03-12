
import Image from "next/image";
import CandidatePersonalInfoForm from "@/components/forms/onboarding/candidate/personal-info";
import { auth } from "@/app/utils/auth";

export default async function PersonalInfoPage() {
  const session = await auth()
  const user = session?.user
  return (
    <div className="grid lg:grid-cols-2 min-h-screen w-full">
      <div className="flex flex-col justify-center px-8 py-12 sm:px-16 max-w-full w-full">
        <div className="mb-8">
          <h1 className="text-2xl font-bold text-gray-900">Step 1</h1>
          <p className="mt-2 text-sm text-gray-600">
            Enter your information to make you job searching process easy
          </p>
        </div>

        <CandidatePersonalInfoForm profilePicture={user?.image as string} />
      </div>

      <div className="hidden lg:flex flex-col items-center justify-center w-full bg-[#E6F0FA]">
        <div className="max-w-lg px-8 text-center">
          <h2 className="text-3xl text-black font-bold text-center mb-2">
            TABASHIR
          </h2>
          <h3 className="text-4xl font-bold text-[#002B6B] mb-4">
            Personal Information
          </h3>
          <p className="text-lg mb-8 text-black">
            Please share your personal information so that we could get the best
            job recommendation for you.
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
