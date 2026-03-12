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
            className="mt-6 w-full flex items-center justify-center py-2 px-4 bg-[#E6F0FA]  text-lg font-medium text-gray-700 hover:bg-opacity-80"
          >
            <svg width="256" height="262" viewBox="0 0 256 262" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid"><path d="M255.878 133.451c0-10.734-.871-18.567-2.756-26.69H130.55v48.448h71.947c-1.45 12.04-9.283 30.172-26.69 42.356l-.244 1.622 38.755 30.023 2.685.268c24.659-22.774 38.875-56.282 38.875-96.027" fill="#4285F4" /><path d="M130.55 261.1c35.248 0 64.839-11.605 86.453-31.622l-41.196-31.913c-11.024 7.688-25.82 13.055-45.257 13.055-34.523 0-63.824-22.773-74.269-54.25l-1.531.13-40.298 31.187-.527 1.465C35.393 231.798 79.49 261.1 130.55 261.1" fill="#34A853" /><path d="M56.281 156.37c-2.756-8.123-4.351-16.827-4.351-25.82 0-8.994 1.595-17.697 4.206-25.82l-.073-1.73L15.26 71.312l-1.335.635C5.077 89.644 0 109.517 0 130.55s5.077 40.905 13.925 58.602l42.356-32.782" fill="#FBBC05" /><path d="M130.55 50.479c24.514 0 41.05 10.589 50.479 19.438l36.844-35.974C195.245 12.91 165.798 0 130.55 0 79.49 0 35.393 29.301 13.925 71.947l42.211 32.783c10.59-31.477 39.891-54.251 74.414-54.251" fill="#EB4335" /></svg>

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
