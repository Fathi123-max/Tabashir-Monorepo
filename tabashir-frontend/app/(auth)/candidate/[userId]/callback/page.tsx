
import React from 'react'
import { prisma } from '@/app/utils/db'
import { redirect } from 'next/navigation'
const CandidateCallback = async ({params}:{params: Promise<{userId:string}>  }) => {
  const paramsData = await params
  const userId =  paramsData.userId

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

  if(!candidaet){
    await prisma.candidate.create({
      data:{
        userId
      }
    })
    redirect(`/candidate/${userId}/personal-info`)
  }


  if(candidaet && !candidaet.profile?.onboardingCompleted){
    redirect(`/candidate/${userId}/personal-info`)
  }

  return <h1>Redirecting...</h1>
}

export default CandidateCallback
