
import React from 'react'
import { prisma } from '@/app/utils/db'
import { redirect } from 'next/navigation'
import { auth } from '@/app/utils/auth'

const CandidateSocialCallback = async ({
  searchParams,
}: {
  searchParams?: Promise<{ redirect?: string }>;
}) => {
  const session = await auth()
  const userId =  session?.user.id

  const candidaet = await prisma.candidate.findUnique({
    where:{
      userId
    },
    include:{
      profile:{
        select:{
          onboardingCompleted:true
        }
      }
    }
  })

  // Get redirect parameter from searchParams
  const params = await searchParams;
  const redirectParam = params?.redirect;

  if(!candidaet){
   
    await prisma.candidate.create({
      data:{
        userId:userId as string
      }
    })
    await prisma.user.update({
      where:{
        id:userId
      },
      data:{
        userType:"CANDIDATE"
      }
    })
   return redirect(`/candidate/${userId}/personal-info`)
  }


  if(candidaet && !candidaet.profile?.onboardingCompleted){
   return redirect(`/candidate/${userId}/personal-info`)
  }

  if(candidaet && candidaet.profile?.onboardingCompleted === true){
    // Use redirect parameter if available, otherwise default to dashboard
    const finalRedirect = redirectParam 
      ? decodeURIComponent(redirectParam)
      : "/dashboard";
    return redirect(finalRedirect)
  }

  return <h1>Redirecting...</h1>
}

export default CandidateSocialCallback
