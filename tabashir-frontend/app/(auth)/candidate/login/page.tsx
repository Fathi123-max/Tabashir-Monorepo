import Image from "next/image";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Suspense } from "react";

import CandidateLoginForm from "@/components/forms/loging";
import { signIn } from "@/app/utils/auth";

// Loading component for Suspense fallback
function LoginFormSkeleton() {
  return (
    <div className="space-y-6">
      <div className="space-y-2">
        <div className="h-4 bg-gray-200 rounded w-16 animate-pulse"></div>
        <div className="h-10 bg-gray-200 rounded animate-pulse"></div>
      </div>
      <div className="space-y-2">
        <div className="h-4 bg-gray-200 rounded w-20 animate-pulse"></div>
        <div className="h-10 bg-gray-200 rounded animate-pulse"></div>
      </div>
      <div className="flex gap-4">
        <div className="h-10 bg-gray-200 rounded flex-1 animate-pulse"></div>
        <div className="h-10 bg-gray-200 rounded flex-1 animate-pulse"></div>
      </div>
    </div>
  );
}

export default async function CandidateLogin({
  searchParams,
}: {
  searchParams?: Promise<{ redirect?: string }>;
}) {
  const params = await searchParams;
  const redirectParam = params?.redirect;

  return (
    <div className="grid lg:grid-cols-2 min-h-screen w-full">
      <div className="flex flex-col justify-center px-8 py-12 sm:px-3 mx-auto w-[500px] max-w-full max-sm:w-full">
        <div className="mb-8">
          <h1 className="text-2xl font-bold text-gray-900">Welcome Back :)</h1>
          <p className="mt-2 text-sm text-gray-600">
            Enter your login info to get you back on your job hunt
          </p>
        </div>

        <Suspense fallback={<LoginFormSkeleton />}>
          <CandidateLoginForm />
        </Suspense>

        <div className="mt-6 text-center text-sm">
          <span className="text-gray-500">Don't have an account? </span>
          <Link
            href="/candidate/registration"
            className="text-blue-600 font-medium hover:underline"
          >
            Sign up
          </Link>
        </div>

        <div className="mt-6 flex items-center">
          <div className="flex-grow h-px bg-gray-300"></div>
          <span className="px-4 text-sm text-gray-500">Or</span>
          <div className="flex-grow h-px bg-gray-300"></div>
        </div>

        <form action={async (formData: FormData) => {
          "use server";
          const redirect = formData.get("redirect") as string | null;
          const callbackUrl = redirect
            ? `/candidate/social/callback?redirect=${encodeURIComponent(redirect)}`
            : "/candidate/social/callback";
          await signIn("google", {
            redirectTo: callbackUrl
          });
        }}>
          {redirectParam && (
            <input type="hidden" name="redirect" value={redirectParam} />
          )}
          <Button
            type="submit"
            variant="outline"
            className="mt-6 w-full flex items-center justify-center py-2 px-4 bg-[#E6F0FA] text-lg font-medium text-gray-700 hover:bg-opacity-80"
          >
            <Image
              src="/icons/google.svg"
              alt="Google logo"
              width={24}
              height={24}
              className="mr-3"
            />
            Google
          </Button>
        </form>
      </div>

      <div className="hidden lg:flex flex-col items-center justify-center w-full bg-[#E6F0FA]">
        <div className="max-w-lg px-8 text-center">
          <h2 className="text-3xl font-bold text-center mb-2 text-black ">
            TABASHIR
          </h2>
          <h3 className="text-4xl font-bold text-[#002B6B] mb-4">Login</h3>
          <p className="text-lg mb-8 text-black">
            Getting you on back for your job searching process
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
