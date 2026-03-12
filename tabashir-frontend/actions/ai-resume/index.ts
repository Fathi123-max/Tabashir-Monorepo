"use server";

import { auth } from "@/app/utils/auth";
import { prisma } from "@/app/utils/db";
import { aiResumePersonalDetailsSchema, AiResumePersonalDetailsSchemaType } from "@/components/forms/ai-resume/personal-details/schema";
import { AiResumeStatus } from "@prisma/client";
import { revalidatePath } from "next/cache";
import { UTApi } from "uploadthing/server";

export async function onSetupResume() {
  const session = await auth();
  if (!session?.user?.id) {
    return { error: true, message: "Unauthenticated" };
  }

  console.log(session, "Session")

  if (session.user.userType !== "CANDIDATE") {
    return { error: true, message: "Unauthorized" };
  }

  const candidate = await prisma.candidate.findUnique({
    where: {
      userId: session.user.id,
    },
  });

  if (!candidate) {
    return { error: true, message: "Candidate not found" };
  }


  const resume = await prisma.aiResume.create({
    data: {
      candidateId: candidate.id,
      createdAt: new Date(),
      updatedAt: new Date(Date.now()),
    },
  });

  if (!resume) {
    return {
      error: true,
      message: "Failed to create resume",
      redirectTo: "/resume",
    };
  }

  return {
    error: false,
    message: "Resume created",
    data: resume,
    redirectTo: `/resume/new/${resume.id}/personal-details`,
  };
}


export async function onSavePersonalDetails(aiResumeId: string, data: AiResumePersonalDetailsSchemaType) {
  const session = await auth();
  if (!session?.user?.id) {
    return { error: true, message: "Unauthenticated" };
  }

  const candidate = await prisma.candidate.findUnique({
    where: {
      userId: session.user.id,
    },
  });

  if (!candidate) {
    return { error: true, message: "Candidate not found" };
  }
  
  
//  validate the data
  const validateData = aiResumePersonalDetailsSchema.parse(data);
  if (!validateData) {
    return { error: true, message: "Invalid data" };
  }

  
  
  const personalDetails = await prisma.aiResumePersonalDetails.upsert({
    where: {
      aiResumeId: aiResumeId,
    },
    update: {
      fullName: validateData.fullName,
      email: validateData.email,
      phone: validateData.phone,
      country: validateData.country,
      city: validateData.city,
      socialLinks: {
        create: validateData.socialLinks?.map((link) => ({
          label: link.label || "",
          url: link.url || "",
        })),
      },
    },
    create: {
      aiResumeId: aiResumeId,
      fullName: validateData.fullName,
      email: validateData.email,
      phone: validateData.phone,
      country: validateData.country,
      city: validateData.city,
      socialLinks: {
        create: validateData.socialLinks?.map((link) => ({
          label: link.label || "",
          url: link.url || "",
        })),
      },
    },
  });

  console.log(personalDetails, "Personal Details saved successfully!")

  if (!personalDetails) {
    return { error: true, message: "Failed to save personal details" };
  }

  // update the aiResutme progress
  const updatedResume = await prisma.aiResume.update({
    where: {
      id: aiResumeId,
    },
    data: { progress: 20 },
  });

  revalidatePath(`/resume/new`, "layout");
  return {
    error: false,
    message: "Personal details saved",
    data: personalDetails,
    redirectTo: `/resume/new/${aiResumeId}/professional-summary`,
  };
}

export async function onSaveProfessionalSummary(aiResumeId: string, data: {
  summary: string;
}) {
  const session = await auth();
  if (!session?.user?.id) {
    return { error: true, message: "Unauthenticated" };
  }

  const candidate = await prisma.candidate.findUnique({
    where: {
      userId: session.user.id,
    },
  });

  if (!candidate) {
    return { error: true, message: "Candidate not found" };
  }

  const professionalSummary = await prisma.aiProfessionalDetails.upsert({
    where: {
      aiResumeId: aiResumeId,
    },
    update: {
      summary: data.summary,
    },
    create: {
      aiResumeId: aiResumeId,
      summary: data.summary,
    },
  });

  if (!professionalSummary) {
    return { error: true, message: "Failed to save professional summary" };
  }

  revalidatePath(`/resume/new`, "layout");
  return {
    error: false,
    message: "Professional summary saved",
  };
}

export async function onSaveEmploymentHistory(aiResumeId: string, data: {
  jobs: {
    jobTitle: string;
    companyName: string;
    country: string;
    city: string;
    startDate: string;
    endDate?: string | undefined;
    isPresent: boolean;
  }[];
}) {
  const session = await auth();
  if (!session?.user?.id) {
    return { error: true, message: "Unauthenticated" };
  }

  const candidate = await prisma.candidate.findUnique({
    where: {
      userId: session.user.id,
    },
  });

  if (!candidate) {
    return { error: true, message: "Candidate not found" };
  }

  try {
    // First verify that the resume exists
    const resume = await prisma.aiResume.findUnique({
      where: {
        id: aiResumeId,
      },
    });

    if (!resume) {
      return { error: true, message: "Resume not found" };
    }

    // Delete existing employment history records for this resume
    await prisma.aiEmploymentHistory.deleteMany({
      where: {
        aiResumeId: aiResumeId,
      },
    });

    const employmentHistory = await prisma.aiEmploymentHistory.createMany({
      data: data.jobs.map((job) => ({
        aiResumeId: aiResumeId,
        company: job.companyName,
        position: job.jobTitle,
        country: job.country, 
        city: job.city,
        startDate: new Date(job.startDate),
        endDate: job.endDate ? new Date(job.endDate) : null,
        current: job.isPresent,
        description: "",
      })),
    });

    console.log(employmentHistory, "Employment history saved successfully!")

    if (!employmentHistory) {
      return { error: true, message: "Failed to save employment history" };
    }

    // Update the resume progress
    await prisma.aiResume.update({
      where: {
        id: aiResumeId,
      },
      data: { progress: 40 },
    });

    revalidatePath(`/resume/new`, "layout");
    return {
      error: false,
      message: "Employment history saved",
    };
  } catch (error) {
    console.error("Error saving employment history:", error);
    return { error: true, message: "Failed to save employment history" };
  }
}

export async function onSaveEducation(aiResumeId: string, data: {
  education: {
    school: string;
    degree: string;
    startDate: string;
    endDate: string;
    city: string;
    description?: string | undefined;
    gpa?: number | null;
  }[];
}) {
  const session = await auth();
  if (!session?.user?.id) {
    return { error: true, message: "Unauthenticated" };
  }

  const candidate = await prisma.candidate.findUnique({
    where: {
      userId: session.user.id,
    },
  });

  if (!candidate) {
    return { error: true, message: "Candidate not found" };
  }

  try {
    // First verify that the resume exists
    const resume = await prisma.aiResume.findUnique({
      where: {
        id: aiResumeId,
      },
    });

    if (!resume) {
      return { error: true, message: "Resume not found" };
    }

    // Delete existing education records for this resume
    await prisma.aiEducation.deleteMany({
      where: {
        aiResumeId: aiResumeId,
      },
    });

    const education = await prisma.aiEducation.createMany({
      data: data.education.map((education) => ({
        aiResumeId: aiResumeId,
        institution: education.school,
        degree: education.degree,
        field: "",
        city: education.city,
        startDate: new Date(education.startDate), 
        endDate: education.endDate ? new Date(education.endDate) : null,
        current: false,
        gpa: education.gpa || null, // Use GPA from form data or null if not provided
        achievements: education.description ? education.description.split(",") : [],
      })),
    });

    console.log(education, "Education saved successfully!")

    if (!education) {
      return { error: true, message: "Failed to save education" };
    }

    // Update the resume progress
    await prisma.aiResume.update({
      where: {
        id: aiResumeId,
      },
      data: { progress: 60 },
    });

    revalidatePath(`/resume/new`, "layout");
    return {
      error: false,
      message: "Education saved",
    };
  } catch (error) {
    console.error("Error saving education:", error);
    return { error: true, message: "Failed to save education" };
  }
}

export async function onSaveSkills(aiResumeId: string, data: {
  skills: {
    name: string;
    level: "BEGINNER" | "INTERMEDIATE" | "ADVANCED" | "EXPERT";
    category: string;
  }[];
}) {
  const session = await auth();
  if (!session?.user?.id) {
    return { error: true, message: "Unauthenticated" };
  }

  const candidate = await prisma.candidate.findUnique({
    where: {
      userId: session.user.id,
    },
  });

  if (!candidate) {
    return { error: true, message: "Candidate not found" };
  }

  try {
    // First verify that the resume exists
    const resume = await prisma.aiResume.findUnique({
      where: {
        id: aiResumeId,
      },
    });

    if (!resume) {
      return { error: true, message: "Resume not found" };
    }

    // Delete existing skills records for this resume
    await prisma.aiSkill.deleteMany({
      where: {
        aiResumeId: aiResumeId,
      },
    });

    const skills = await prisma.aiSkill.createMany({
      data: data.skills.map((skill) => ({
        aiResumeId: aiResumeId,
        name: skill.name,
        level: skill.level as "BEGINNER" | "INTERMEDIATE" | "ADVANCED" | "EXPERT",
        category: skill.category,
      })),
    });

    console.log(skills, "Skills saved successfully!")

    if (!skills) {
      return { error: true, message: "Failed to save skills" };
    }

    // Update the resume progress
    await prisma.aiResume.update({
      where: {
        id: aiResumeId,
      },
      data: { progress: 80 },
    });

    revalidatePath(`/resume/new`, "layout");
    return {
      error: false,
      message: "Skills saved",
    };
  } catch (error) {
    console.error("Error saving skills:", error);
    return { error: true, message: "Failed to save skills" };
  }
}

export async function getCV(resumeId: string) {
  const session = await auth();
  if (!session?.user?.id) {
    return { error: true, message: "Unauthenticated" };
  }

  const candidate = await prisma.candidate.findUnique({
    where: {
      userId: session.user.id,
    },
  });
  
  if (!candidate) {
    return { error: true, message: "Candidate not found" };
  }

  const resume = await prisma.aiResume.findUnique({
    where: { id: resumeId },
  });

  if (!resume) {
    return { error: true, message: "Resume not found" };
  }

  const cvPersonalDetails = await prisma.aiResumePersonalDetails.findUnique({
    where: { aiResumeId: resumeId },
  });

  const cvProfessionalSummary = await prisma.aiProfessionalDetails.findUnique({
    where: { aiResumeId: resumeId },
  });

  const cvEmploymentHistory = await prisma.aiEmploymentHistory.findMany({
    where: { aiResumeId: resumeId },
  });

  const cvEducation = await prisma.aiEducation.findMany({
    where: { aiResumeId: resumeId },
  });

  const cvSkills = await prisma.aiSkill.findMany({
    where: { aiResumeId: resumeId },
  });

  return {
    error: false,
    message: "CV generated successfully!",
    data: {
      resume,
      cvPersonalDetails,
      cvProfessionalSummary,
      cvEmploymentHistory,
      cvEducation,
      cvSkills,
    },
  };
}

export async function getResumeScore(resumeId: string) {
  const session = await auth();

  if (!session?.user?.id) {
    return { error: true, message: "Unauthenticated" };
  }

  const candidate = await prisma.candidate.findUnique({
    where: {
      userId: session.user.id,
    },
  });

  if (!candidate) {
    return { error: true, message: "Candidate not found" };
  }

  const resume = await prisma.aiResume.findUnique({
    where: {
      id: resumeId,
    },
    select: {
      id: true,
      paymentAmount: true,
      paymentStatus: true,
      paymentDate: true
    },
  });



  if (!resume) {
    return { error: true, message: "Resume not found" };
  }
  
  let score = 0;

  const personalDetails = await prisma.aiResumePersonalDetails.findUnique({
    where: {
      aiResumeId: resumeId,
    },
  });

  console.log(personalDetails, "Personal Details")

  if (personalDetails) {
    score += 20;
  }

  const professionalSummary = await prisma.aiProfessionalDetails.findUnique({
    where: {
      aiResumeId: resumeId,
    },
  });

  console.log(professionalSummary, "Professional Summary")

  if (professionalSummary) {
    score += 20;
  }

  const employmentHistory = await prisma.aiEmploymentHistory.findMany({
    where: {
      aiResumeId: resumeId,
    },
  }); 

  console.log(employmentHistory, "Employment History")

  if (employmentHistory.length > 0) {
    score += 20;
  }

  const education = await prisma.aiEducation.findMany({
    where: {
      aiResumeId: resumeId,
    },
  });

  console.log(education, "Education")

  if (education.length > 0) {
    score += 20;
  }

  const skills = await prisma.aiSkill.findMany({
    where: {
      aiResumeId: resumeId,
    },
  });

  console.log(skills, "Skills")

  if (skills.length > 0) {
    score += 20;
  }
  
  return {
    error: false,
    message: "Resume score calculated successfully!",
    score: score,
    data: {
      personalDetails: personalDetails ? true : false,
      professionalSummary: professionalSummary ? true : false,
      employmentHistory: employmentHistory.length > 0 ? true : false,
      education: education.length > 0 ? true : false,
      skills: skills.length > 0 ? true : false,
      payment: resume.paymentStatus,
    }
  };
  
}

export async function getResumePaymentStatus(resumeId: string) {
  const session = await auth();

  if (!session?.user?.id) {
    return { error: true, message: "Unauthenticated" };
  }

  const candidate = await prisma.candidate.findUnique({
    where: {
      userId: session.user.id,
    },
  });

  if (!candidate) {
    return { error: true, message: "Candidate not found" };
  }
  
  const resume = await prisma.aiResume.findUnique({
    where: {
      id: resumeId,
    },
    select: {
      paymentStatus: true,
      paymentAmount: true,
      paymentDate: true,
    },
  });

  return {
    error: false,
    message: "Resume payment status fetched successfully!",
    data: resume,
  };
}

export async function getResumeGeneratedStatus(resumeId: string) {
  const session = await auth();

  if (!session?.user?.id) {
    return { error: true, message: "Unauthenticated" };
  }

  const candidate = await prisma.candidate.findUnique({
    where: {
      userId: session.user.id,
    },
  });
  
  if (!candidate) {
    return { error: true, message: "Candidate not found" };
  }

  const resume = await prisma.aiResume.findUnique({
    where: {
      id: resumeId,
    },
    select: {
      formatedUrl: true,
    },
  });

  return {
    error: false,
    message: "Resume generated status fetched successfully!",
    data: resume,
  };
}

export async function changeResumeStatus(resumeId: string, status: AiResumeStatus) {
  const session = await auth();

  if (!session?.user?.id) {
    return { error: true, message: "Unauthenticated" };
  }
  
  const candidate = await prisma.candidate.findUnique({
    where: {
      userId: session.user.id,
    },
  });

  if (!candidate) {
    return { error: true, message: "Candidate not found" };
  }

  const resume = await prisma.aiResume.update({
    where: {
      id: resumeId,
    },
    data: {
      status: status,
    },
  });
  
  if (!resume) {
    return { error: true, message: "Failed to change resume status" };
  }

  return {
    error: false,
    message: "Resume status changed successfully!",
  };
}

export async function getAiJobApplyStatus() {
  const session = await auth();

  if (!session?.user?.id) {
    return { error: true, message: "Unauthenticated" };
  }

  const dbUser = await prisma.user.findUnique({
    where: {
      id: session.user.id,
    },
    select: {
      jobCount: true,
      aiJobApplyCount: true,
    },
  });

  if (!dbUser) {
    return { error: true, message: "User not found" };
  }

  return {
    error: false,
    message: "Ai job apply status fetched successfully!",
    data: {
      jobCount: dbUser.jobCount,
      aiJobApplyCount: dbUser.aiJobApplyCount,
    },
  };
  
}

export async function submitAiJobApply(jobCount: boolean, aiJobApplyCount: boolean) {
  const session = await auth();

  if (!session?.user?.id) {
    return { error: true, message: "Unauthenticated" };
  }

  const dbUser = await prisma.user.findUnique({
    where: {
      id: session.user.id,
    },
    select: {
      jobCount: true,
      aiJobApplyCount: true,
    },
  });

  if (!dbUser) {
    return { error: true, message: "User not found" };
  }

  if (jobCount && dbUser.jobCount === 0) {
    return { error: true, message: "You have already applied for a job" };
  }

  if (aiJobApplyCount && dbUser.aiJobApplyCount === 0) {
    return { error: true, message: "You have already applied for a job" };
  }

  const updatedUser = await prisma.user.update({
    where: {
      id: session.user.id,
    },
    data: {
      aiJobApplyCount: aiJobApplyCount ? dbUser.aiJobApplyCount - 1 : dbUser.aiJobApplyCount,
    },
  });

  if (!updatedUser) {
    return { error: true, message: "Failed to update user" };
  }

  return {
    error: false,
    message: "User updated successfully!",
  };
}

export async function submitJobApply(userId: string) {
  const session = await auth();

  if (!session?.user?.id) {
    return { error: true, message: "Unauthenticated" };
  }

  const dbUser = await prisma.user.findUnique({
    where: {
      id: userId,
    },
  });

  if (!dbUser) {
    return { error: true, message: "User not found" };
  }

  const updatedUser = await prisma.user.update({
    where: {
      id: userId,
    },
    data: {
      jobCount: dbUser.jobCount - 1,
    },
  });
  
  if (!updatedUser) {
    return { error: true, message: "Failed to update user" };
  }

  return {
    error: false,
    message: "User updated successfully!",
  };
}

export async function getAiResumeFormatedContent(resumeId: string) {
  const session = await auth();

  if (!session?.user?.id) {
    return { error: true, message: "Unauthenticated" };
  }

  const candidate = await prisma.candidate.findUnique({
    where: {
      userId: session.user.id,
    },
  });

  if (!candidate) {
    return { error: true, message: "Candidate not found" };
  }

  const resume = await prisma.aiResume.findUnique({
    where: {
      id: resumeId,
    },
    select: {
      formatedContent: true,
      formatedUrl: true,
      status: true,
    },
  });

  if (!resume) {
    return { error: true, message: "Resume not found" };
  }

  const hasValidFormatedContent = resume.formatedContent && resume.formatedContent.trim() !== "";
  const hasGeneratedUrl = resume.formatedUrl && resume.formatedUrl.trim() !== "";

  return {
    error: false,
    message: "Formatted content fetched successfully!",
    data: {
      formatedContent: resume.formatedContent,
      formatedUrl: resume.formatedUrl,
      status: resume.status,
      hasExistingContent: hasValidFormatedContent,
      hasGeneratedResume: hasGeneratedUrl,
    },
  };
}

export async function uploadCVFile(file: File, resumeId: string) {
  try {
    const session = await auth();

    if (!session?.user?.id) {
      return {
        error: true,
        message: "Unauthorized access",
      }
    }

    const candidate = await prisma.candidate.findUnique({
      where: {
        userId: session.user.id,
      },
    })

    if (!candidate) {
      return {
        error: true,
        message: "Candidate profile not found",
      }
    }

    const utapi = new UTApi();
    const uploadedFiles = await utapi.uploadFiles([file]);
    const uploadedFile = uploadedFiles[0];

    if (!uploadedFile || !uploadedFile.data?.ufsUrl) {
      return {
        error: true,
        message: "Failed to upload file to UploadThing",
      }
    }

    // Update the AI resume record with the formatted URL
    const updateResult = await prisma.aiResume.update({
      where: { id: resumeId },
      data: {
        formatedUrl: uploadedFile.data.ufsUrl,
        originalUrl: uploadedFile.data.ufsUrl,
        progress: 100 // Mark as complete
      },
    });

    return {
      error: false,
      message: "CV file uploaded successfully",
      data: updateResult,
    }
    
  } catch (error) {
    console.error("[UPLOAD_CV_FILE_ERROR]", error)
    return {
      error: true,
      message: "Failed to upload CV file",
    }
  }
}
