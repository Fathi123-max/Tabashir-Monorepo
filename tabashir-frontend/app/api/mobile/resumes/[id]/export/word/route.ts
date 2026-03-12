import { NextRequest, NextResponse } from "next/server";
import { authenticateCandidateRequest } from "@/lib/mobile-auth";
import { prisma } from "@/lib/prisma";
import { Document, Packer, Paragraph, TextRun, HeadingLevel } from "docx";

/**
 * POST /api/mobile/resumes/{id}/export/word
 * Export resume as Word document (.docx)
 */
export async function POST(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    // Authenticate user and get candidate info
    const authResult = await authenticateCandidateRequest(req);
    if (authResult instanceof NextResponse) {
      return authResult;
    }
    const { user } = authResult;

    // Check if resume exists and belongs to user
    const resume = await prisma.resume.findFirst({
      where: {
        id: params.id,
        candidateId: user.candidateId,
      },
      select: {
        id: true,
        filename: true,
        formatedContent: true,
      },
    });

    if (!resume) {
      return NextResponse.json(
        { error: "Resume not found" },
        { status: 404 }
      );
    }

    if (!resume.formatedContent) {
      return NextResponse.json(
        { error: "Resume content not available. Please format the resume first." },
        { status: 400 }
      );
    }

    // Parse the formatted content (assuming it's JSON with structured data)
    let resumeData;
    try {
      resumeData = JSON.parse(resume.formatedContent);
    } catch (parseError) {
      // If it's plain text, create a simple document
      const doc = new Document({
        sections: [
          {
            properties: {},
            children: [
              new Paragraph({
                text: resume.formatedContent,
                spacing: {
                  after: 200,
                },
              }),
            ],
          },
        ],
      });

      const buffer = await Packer.toBuffer(doc);
      const filename = resume.filename.replace(/\.pdf$/i, ".docx");

      return new NextResponse(buffer, {
        headers: {
          "Content-Type": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
          "Content-Disposition": `attachment; filename="${filename}"`,
        },
      });
    }

    // Create Word document from structured data
    const doc = new Document({
      sections: [
        {
          properties: {},
          children: [
            // Name/Title
            ...(resumeData.name
              ? [
                  new Paragraph({
                    text: resumeData.name,
                    heading: HeadingLevel.HEADING_1,
                    spacing: { after: 200 },
                  }),
                ]
              : []),

            // Contact Info
            ...(resumeData.email || resumeData.phone
              ? [
                  new Paragraph({
                    children: [
                      ...(resumeData.email
                        ? [new TextRun({ text: resumeData.email + " " })]
                        : []),
                      ...(resumeData.phone
                        ? [new TextRun({ text: "| " + resumeData.phone })]
                        : []),
                    ],
                    spacing: { after: 400 },
                  }),
                ]
              : []),

            // Summary
            ...(resumeData.summary
              ? [
                  new Paragraph({
                    text: "Professional Summary",
                    heading: HeadingLevel.HEADING_2,
                    spacing: { before: 200, after: 100 },
                  }),
                  new Paragraph({
                    text: resumeData.summary,
                    spacing: { after: 400 },
                  }),
                ]
              : []),

            // Experience
            ...(resumeData.experience && resumeData.experience.length > 0
              ? [
                  new Paragraph({
                    text: "Work Experience",
                    heading: HeadingLevel.HEADING_2,
                    spacing: { before: 200, after: 100 },
                  }),
                  ...resumeData.experience.flatMap((exp: any) => [
                    new Paragraph({
                      children: [
                        new TextRun({ text: exp.title || "", bold: true }),
                        new TextRun({ text: " at " + (exp.company || "") }),
                      ],
                      spacing: { after: 100 },
                    }),
                    new Paragraph({
                      text: exp.duration || "",
                      spacing: { after: 100 },
                    }),
                    new Paragraph({
                      text: exp.description || "",
                      spacing: { after: 300 },
                    }),
                  ]),
                ]
              : []),

            // Education
            ...(resumeData.education && resumeData.education.length > 0
              ? [
                  new Paragraph({
                    text: "Education",
                    heading: HeadingLevel.HEADING_2,
                    spacing: { before: 200, after: 100 },
                  }),
                  ...resumeData.education.flatMap((edu: any) => [
                    new Paragraph({
                      children: [
                        new TextRun({ text: edu.degree || "", bold: true }),
                        new TextRun({ text: " - " + (edu.institution || "") }),
                      ],
                      spacing: { after: 100 },
                    }),
                    new Paragraph({
                      text: edu.year || "",
                      spacing: { after: 300 },
                    }),
                  ]),
                ]
              : []),

            // Skills
            ...(resumeData.skills && resumeData.skills.length > 0
              ? [
                  new Paragraph({
                    text: "Skills",
                    heading: HeadingLevel.HEADING_2,
                    spacing: { before: 200, after: 100 },
                  }),
                  new Paragraph({
                    text: resumeData.skills.join(", "),
                    spacing: { after: 200 },
                  }),
                ]
              : []),
          ],
        },
      ],
    });

    // Generate the Word document buffer
    const buffer = await Packer.toBuffer(doc);
    const filename = resume.filename.replace(/\.pdf$/i, ".docx");

    return new NextResponse(buffer, {
      headers: {
        "Content-Type": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        "Content-Disposition": `attachment; filename="${filename}"`,
      },
    });
  } catch (error) {
    console.error("[EXPORT_WORD_ERROR]", error);
    return NextResponse.json(
      { error: "Failed to export Word document" },
      { status: 500 }
    );
  }
}
