"use server"

import { auth } from "@/app/utils/auth"
import { prisma } from "@/app/utils/db"
import { uploadFile, deleteFile, downloadFile, generateFilename } from "@/lib/uploadthing-service";
import OpenAI from "openai";
import { extractText, getDocumentProxy } from 'unpdf';
import { revalidatePath } from "next/cache";
import { toast } from "sonner";
import { AiResumeStatus } from "@prisma/client";

interface Resume {
  id: string;
  filename: string;
  createdAt: Date;
  updatedAt: Date;
  candidateId: string;
  originalUrl: string;
  formatedUrl: string | null;
  formatedContent: string | null;
}

interface ResumeUploadData {
  filename: string
  originalUrl: string
  formatedUrl?: string
  formatedContent?: string
}

export async function onUploadResume(file: File): Promise<{ error: boolean; message: string; originalFile?: { filename: string; originalUrl: string; id: string }; newResume?: Resume }> {
  if (!file || file.type !== "application/pdf") {
    return {
      error: true,
      message: "Only PDF files are allowed",
    };
  }

  try {
    // Generate unique filename
    const fileName = generateFilename("resume", "pdf");

    // Upload file to UploadThing
    const uploadResult = await uploadFile(file, {
      allowedTypes: ["application/pdf"],
      maxSizeInMB: 2,
      filename: fileName,
    });

    const originalFileDetails = {
      filename: uploadResult.data.name || fileName,
      originalUrl: uploadResult.data.url,
    };

    // Save the initial upload without AI processing
    const saveResult = await onCandidateResumeUpload({
      filename: originalFileDetails.filename,
      originalUrl: originalFileDetails.originalUrl,
    });

    if (saveResult.error || !saveResult.data) {
      return {
        error: true,
        message: saveResult.message || "Failed to save resume data",
        originalFile: {
          ...originalFileDetails,
          id: "" // Provide empty string as fallback
        }
      };
    }

    revalidatePath("/resume")
    // Return success immediately after upload with the resume ID and details
    return {
      error: false,
      message: "File uploaded successfully",
      originalFile: {
        ...originalFileDetails,
        id: saveResult.data.id
      },
      newResume: saveResult.data
    };

  } catch (error) {
    console.error("[PDF_UPLOAD_ERROR]", error);
    return {
      error: true,
      message: error instanceof Error ? error.message : "Failed to upload PDF file",
    };
  }
}

export async function onCandidateResumeUpload(data: ResumeUploadData) {
  try {
    const session = await auth()

    if (!session?.user?.id) {
      return {
        error: true,
        message: "Unauthorized access",
      }
    }

    // Get candidate ID from user ID
    const candidate = await prisma.candidate.findUnique({
      where: {
        userId: session.user.id,
      },
      select: {
        id: true,
      },
    })

    if (!candidate) {
      return {
        error: true,
        message: "Candidate profile not found",
      }
    }

    // Create resume record
    const resume = await prisma.resume.create({
      data: {
        candidateId: candidate.id,
        filename: data.filename,
        originalUrl: data.originalUrl,
        formatedUrl: data.formatedUrl,
        formatedContent: data.formatedContent,
      },
    })

    return {
      error: false,
      message: "Resume uploaded successfully",
      data: resume,
    }
  } catch (error) {
    console.error("[RESUME_UPLOAD_ERROR]", error)
    return {
      error: true,
      message: "Failed to upload resume",
    }
  }
}

// New server action to process resume text with AI
export async function processResumeWithAI(rawText: string): Promise<{ error: boolean; message: string; data?: string }> {
  try {
    // Initialize OpenAI client
    const openai = new OpenAI({
      apiKey: process.env.OPENAI_API_KEY,
    });

    // Define the prompt for the AI
    const systemPrompt = `Your job is to rewrite and transform CVs. You will be passed raw text of a CV, your main responsibility is reformulating CVs to maintain the integrity of the original content while making strategic enhancements based on the following requests and return transformed raw text. When adapting Work Experience, Leadership Experience and Projects sections, ensure each contains a minimum of 3 bullet points if there are 3 or more experiences listed. If there are fewer experiences, expand each to at most 5 bullet points to make the CV appear more comprehensive. Your adaptations should prioritize keywords and skills that enhance job market success, emphasizing areas likely to capture an employer's interest. Specifically, for the Skills and Additional Training, mention any skills that are implicitly mentioned, and explicitly state them if they are relevant and can add to the strength of the CV.

    Maintain sections like Career Objective, Education, Work Experience, Leadership Experience, Projects ,Skills and Additional Training and Languages, carefully avoiding the addition of unrequested sections. Your goal is to achieve zero error in formatting and content adaptation, showcasing the user's achievements and skills effectively. Request more information if details is insufficient and ensure the CV is professional and aligned with the template. Your communication should remain formal, focused on precision and adherence to the provided template.

    If you see any leadership-worthy details as you're transforming, mention this under LEADERSHIP EXPERIENCE with the position of leadership, company of leadership, the date, location, and between 3 and 5 details about it. Look for keywords such as "president", "head", "lead", "captain", "manager", "director", "chief", "coordinator", "supervisor", "organizer", "founder", "chair", "representative".

    If you see any project-worthy details as you're transforming, mention this under PROJECTS with the title of the project, the position held, the date, location, and between 3 and 5 details about it. Look for keywords such as "project", "developed", "created", "built", "designed", "implemented", "launched", "initiated", "established", "organized", "managed".

    Remember, feel free to be creative and make the CV as professional as possible.

    You must correct any grammatical, spelling, spacing and capitalization mistakes in small details. For example for location, if the raw text says ALAIN or ABUDHABI, you must change this to Al Ain, Abu Dhabi, and so on and so forth. For larger details, if the raw text is unprofessional, upgrade it to a more presentable and professional format.
    
    Return ONLY the transformed raw text of the CV, formatted clearly by section. Do not include any conversational text or explanations before or after the transformed CV text.`

    const completion = await openai.chat.completions.create({
      model: "gpt-4o", // Or "gpt-3.5-turbo"
      messages: [
        { role: "system", content: systemPrompt },
        { role: "user", content: rawText },
      ],
      temperature: 0.7, // Adjust temperature as needed for creativity vs consistency
    });

    const transformedText = completion.choices[0]?.message?.content;

    if (!transformedText) {
      return {
        error: true,
        message: "Failed to get a valid response from the AI model.",
      };
    }

    return {
      error: false,
      message: "Resume processed successfully",
      data: transformedText,
    };

  } catch (error) {
    console.error("[AI_RESUME_PROCESSING_ERROR]", error);
    return {
      error: true,
      message: error instanceof Error ? error.message : "Failed to process resume with AI",
    };
  }
}

// New server action to update resume with formatted content
export async function updateResumeWithFormattedContent(resumeId: string, formatedContent: string) {
  try {
    const session = await auth()

    if (!session?.user?.id) {
      return {
        error: true,
        message: "Unauthorized access",
      }
    }

    // Update resume record
    const resume = await prisma.resume.update({
      where: { id: resumeId },
      data: { formatedContent },
    })

    return {
      error: false,
      message: "Resume updated successfully",
      data: resume,
    }
  } catch (error) {
    console.error("[RESUME_UPDATE_ERROR]", error)
    return {
      error: true,
      message: "Failed to update resume",
    }
  }
}

// Modified function to process the resume with AI after upload
export async function processResumeWithAIAfterUpload(resumeId: string): Promise<{ error: boolean; message: string; transformedText?: string }> {
  try {
    // Get the resume from the database
    const resume = await prisma.resume.findUnique({
      where: { id: resumeId },
      select: { originalUrl: true }
    });

    if (!resume) {
      return {
        error: true,
        message: "Resume not found",
      };
    }

    // Download the file from UploadThing
    const downloadResult = await downloadFile(resume.originalUrl);

    if (!downloadResult.success || !downloadResult.blob) {
      return {
        error: true,
        message: downloadResult.error || "Failed to download resume file",
      };
    }

    // Convert blob to buffer for unpdf
    const arrayBuffer = await downloadResult.blob.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);

    // Extract text from the PDF using unpdf
    const pdf = await getDocumentProxy(new Uint8Array(buffer));
    const { text: rawText } = await extractText(pdf, { mergePages: true });

    // Process text with AI
    const aiResult = await processResumeWithAI(rawText);
    console.log("api_result: ", aiResult);

    if (aiResult.error || !aiResult.data) {
      return aiResult;
    }

    // Update the resume with the transformed text using the new update function
    await updateResumeWithFormattedContent(resumeId, aiResult.data);

    return {
      error: false,
      message: "Resume processed successfully",
      transformedText: aiResult.data,
    };

  } catch (error) {
    console.error("[PDF_PROCESSING_ERROR]", error);
    return {
      error: true,
      message: error instanceof Error ? error.message : "Failed to process PDF file",
    };
  }
}

// Get all resumes for the current user
export async function getUserResumes() {
  try {
    const session = await auth()

    if (!session?.user?.id) {
      return {
        error: true,
        message: "Unauthorized access",
      }
    }

    // Get candidate ID from user ID
    const candidate = await prisma.candidate.findUnique({
      where: {
        userId: session.user.id,
      },
      select: {
        id: true,
      },
    })

    if (!candidate) {
      return {
        error: true,
        message: "Candidate profile not found",
      }
    }

    // Get all resumes for the candidate
    const resumes = await prisma.resume.findMany({
      where: {
        candidateId: candidate.id,
      },
      orderBy: {
        createdAt: 'desc',
      },
    })

    return {
      error: false,
      message: "Resumes fetched successfully",
      data: resumes,
    }
  } catch (error) {
    console.error("[GET_RESUMES_ERROR]", error)
    return {
      error: true,
      message: "Failed to fetch resumes",
    }
  }
}

// Delete a resume
export async function deleteResume(resumeId: string) {
  try {
    const session = await auth()

    if (!session?.user?.id) {
      return {
        error: true,
        message: "Unauthorized access",
      }
    }

    // Get candidate ID from user ID
    const candidate = await prisma.candidate.findUnique({
      where: {
        userId: session.user.id,
      },
      select: {
        id: true,
      },
    })

    if (!candidate) {
      return {
        error: true,
        message: "Candidate profile not found",
      }
    }

    // Verify the resume belongs to the candidate and get its URL
    const resume = await prisma.resume.findFirst({
      where: {
        id: resumeId,
        candidateId: candidate.id,
      },
      select: { // Select the originalUrl before deleting
        id: true,
        originalUrl: true,
      }
    })

    if (!resume) {
      return {
        error: true,
        message: "Resume not found or unauthorized",
      }
    }

    // Delete the file from UploadThing
    try {
      const deleteResult = await deleteFile(resume.originalUrl);
      if (deleteResult.success) {
        console.log(`Deleted file from UploadThing for resume ${resumeId}`);
      } else {
        console.warn(`Failed to delete file from UploadThing for resume ${resumeId}`);
      }
    } catch (uploadthingError) {
      console.error("[UPLOADTHING_DELETE_ERROR]", uploadthingError);
      // Decide how to handle failure to delete from UploadThing.
      // For now, we'll log the error but still delete the database record
      // to prevent orphaned records if UploadThing deletion fails.
      // Depending on requirements, you might return an error here instead.
    }

    // Delete the resume record from the database
    await prisma.resume.delete({
      where: {
        id: resumeId,
      },
    })

    revalidatePath("/resume")

    return {
      error: false,
      message: "Resume deleted successfully",
    }
  } catch (error) {
    console.error("[DELETE_RESUME_ERROR]", error)
    return {
      error: true,
      message: "Failed to delete resume",
    }
  }
}

// Download resume
export async function downloadResume(resumeId: string) {
  try {
    const session = await auth()

    if (!session?.user?.id) {
      return {
        error: true,
        message: "Unauthorized access",
      }
    }

    // Get candidate ID from user ID
    const candidate = await prisma.candidate.findUnique({
      where: {
        userId: session.user.id,
      },
      select: {
        id: true,
      },
    })

    if (!candidate) {
      return {
        error: true,
        message: "Candidate profile not found",
      }
    }

    // Get the resume
    const resume = await prisma.resume.findFirst({
      where: {
        id: resumeId,
        candidateId: candidate.id,
      },
    })

    if (!resume) {
      return {
        error: true,
        message: "Resume not found or unauthorized",
      }
    }

    return {
      error: false,
      message: "Resume fetched successfully",
      data: {
        url: resume.formatedUrl || resume.originalUrl,
        filename: resume.filename,
      },
    }
  } catch (error) {
    console.error("[DOWNLOAD_RESUME_ERROR]", error)
    return {
      error: true,
      message: "Failed to fetch resume",
    }
  }
}

export async function checkUserHasResume() {
  try {
    const session = await auth()

    if (!session?.user?.id) {
      return {
        error: true,
        message: "Unauthorized access",
        hasResume: false
      }
    }

    // Get candidate ID from user ID
    const candidate = await prisma.candidate.findUnique({
      where: {
        userId: session.user.id,
      },
      select: {
        id: true,
      },
    })

    if (!candidate) {
      return {
        error: true,
        message: "Candidate profile not found",
        hasResume: false
      }
    }

    // Check if candidate has any resumes
    const resumeCount = await prisma.resume.count({
      where: {
        candidateId: candidate.id,
      },
    })

    return {
      error: false,
      hasResume: resumeCount > 0,
    }
  } catch (error) {
    console.error("[CHECK_HAS_RESUME_ERROR]", error)
    return {
      error: true,
      message: "Failed to check resume status",
      hasResume: false
    }
  }
} 

export async function uploadAIResume(file: File, resumeId: string) {
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

    // Generate filename
    const fileName = generateFilename("ai-resume", "pdf");

    // Upload file to UploadThing
    const uploadResult = await uploadFile(file, {
      allowedTypes: ["application/pdf"],
      maxSizeInMB: 2,
      filename: fileName,
    });

    // Update the resume record with the formatted URL
    const updateResult = await prisma.aiResume.update({
      where: { id: resumeId },
      data: {
        formatedUrl: uploadResult.data.url,
        originalUrl: uploadResult.data.url,
        progress: 100 // Mark as complete
      },
    });

    const aiResumePersonalDetails = await prisma.aiResumePersonalDetails.findUnique({
      where: { id: resumeId },
      select: {
        fullName: true,
      }
    });

    const aiResume = await prisma.resume.create({
      data: {
        candidateId: candidate.id,
        formatedUrl: uploadResult.data.url,
        originalUrl: uploadResult.data.url,
        filename: aiResumePersonalDetails?.fullName || fileName,
      },
    })

    return {
      error: false,
      message: "AI resume uploaded successfully",
      data: aiResume,
    }

  } catch (error) {
    console.error("[UPLOAD_AI_RESUME_ERROR]", error)
    return {
      error: true,
      message: "Failed to upload AI resume",
    }
  }
}

export async function updateAiResumeRawData(resumeId: string, formatedContent: string) {
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
      select: {
        id: true,
      },
    })

    if (!candidate) {
      return {
        error: true,
        message: "Candidate profile not found",
      }
    }

    const aiResume = await prisma.aiResume.update({
      where: { id: resumeId },
      data:{
        formatedContent: formatedContent,
      },
    })

    console.log("aiResume: ", aiResume);

    return {
      error: false,
      message: "AI resume updated successfully",
      data: aiResume,
    }
  } catch (error) {
    console.error("[UPDATE_AI_RESUME_ERROR]", error)
    return {
      error: true,
      message: "Failed to update AI resume",
    }
  }
}

export async function getAiResumeFiles() {
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
      select: {
        id: true,
      },
    })

    if (!candidate) {
      return {
        error: true,
        message: "Candidate profile not found",
      }
    }

    const aiResume = await prisma.aiResume.findMany({
      where: {
        candidateId: candidate.id,
        formatedUrl: {
          not: null
        }
      },
      orderBy: {
        createdAt: 'desc',
      },
    })

    return {
      error: false,
      message: "AI resume files fetched successfully",
      data: aiResume, 
    }
  } catch (error) {
    console.error("[GET_AI_RESUME_FILES_ERROR]", error)
    return {
      error: true,
      message: "Failed to fetch AI resume files",
    }
  }
}

export async function changeAiResumeStatus(resumeId: string, status : AiResumeStatus) {
  try {
    const session = await auth();

    if (!session?.user?.id) {
      return {
        error: true,
        message: "Unauthorized access",
      }
    }

    const aiResume = await prisma.aiResume.update({
      where: { id: resumeId },
      data: {
        status: status,
      },
    })

    return {
      error: false,
      message: "AI resume status changed successfully",
      data: aiResume,
    }
  } catch (error) {
    console.error("[CHANGE_AI_RESUME_STATUS_ERROR]", error)
    return {
      error: true,
      message: "Failed to change AI resume status",
    }
  }
}
