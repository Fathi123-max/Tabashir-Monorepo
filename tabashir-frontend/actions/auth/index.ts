"use server"

import { loginFormSchema } from "@/app/utils/schemas";
import { z } from "zod";
import { signIn, signOut } from "@/app/utils/auth";
import { redirect } from "next/dist/server/api-utils";
import { registrationFormSchema, RegistrationFormSchemaType } from "@/components/forms/registration/candidate/schema";
import { recruiterRegistrationFormSchema, RecruiterRegistrationFormSchemaType } from "@/components/forms/registration/recruiter/schema";
import nodemailer from "nodemailer";
import crypto from "crypto";
import { prisma } from '@/app/utils/db'
import bcrypt from "bcrypt";
import { auth } from "@/app/utils/auth";
import { candidatePersonalInfoFormSchema, CandidatePersonalInfoFormSchemaType } from "@/components/forms/onboarding/candidate/personal-info/schema";
import { candidateProfessionalInfoFormSchema, CandidateProfessionalInfoFormSchemaType } from "@/components/forms/onboarding/candidate/professional-info/schema";

// Create a more robust transporter with better error handling
function createEmailTransporter() {
  try {
    if (!process.env.SMTP_SERVER || !process.env.SMTP_PORT || !process.env.EMAIL_ADDRESS || !process.env.EMAIL_PASSWORD) {
      console.error("Missing email configuration environment variables");
      return null;
    }

    return nodemailer.createTransport({
      host: process.env.SMTP_SERVER,
      port: Number(process.env.SMTP_PORT),
      secure: true,
      auth: {
        user: process.env.EMAIL_ADDRESS,
        pass: process.env.EMAIL_PASSWORD,
      },
      pool: false, // Disable connection pooling for serverless
      maxConnections: 1,
      maxMessages: 1,
    } as nodemailer.TransportOptions);
  } catch (error) {
    console.error("Failed to create email transporter:", error);
    return null;
  }
}

export async function onLogin(data: z.infer<typeof loginFormSchema>) {
  const validate = loginFormSchema.parse(data)
  if (!validate) {
    return { error: true, message: "Invalid input data" }
  }

  const { email, password } = validate;

  const isUserExist = await prisma.user.findUnique({
    where: {
      email
    }
  })
  if (!isUserExist || !isUserExist.password || !isUserExist.email) {
    return {
      error: true,
      message: "User not found"
    }
  }

  // Check if email is verified for credential-based users
  if (!isUserExist.emailVerified) {
    return {
      error: true,
      message: "Please verify your email address before logging in. Check your inbox for the verification link.",
      needsVerification: true,
      email: isUserExist.email
    }
  }

  try {
    await signIn("credentials", {
      email: isUserExist.email,
      password: password,
      redirect: false,
    })
    const redirectTo = isUserExist.userType === "ADMIN" ? "/admin/dashboard" : isUserExist.userType === "CANDIDATE" ? "/dashboard" : isUserExist.userType === "RECURITER" ? "/recruiter/dashboard" : ""
    return {
      error: false,
      message: "Successfully logged in!",
      redirectTo
    }
  } catch (error) {
    // Check if this is a redirect error
    console.error("Error: ", error)
    return { error: true, message: "Authentication failed" }
  }
}

export async function onLogout(redirectTo: string) {
  await signOut({
    redirectTo
  })
}

export async function updateOnboardingStatus(candidateId: string, isCompleted: boolean) {
  try {
    await prisma.candidateProfile.update({
      where: { candidateId },
      data: { onboardingCompleted: isCompleted }
    })

    return {
      error: false,
      redirectTo: "/dashboard"
    }
  } catch (error) {
    console.error("Error updating onboarding status:", error)
    return {
      error: true,
      message: "Failed to update onboarding status"
    }
  }
}

export async function onCandidateRegistration(data: RegistrationFormSchemaType) {
  const validate = registrationFormSchema.parse(data)
  if (!validate) {
    return {
      error: true,
      message: "Invalid data"
    }
  }

  const { email, username, password } = validate
  try {
    let isUserExist = await prisma.user.findUnique({
      where: {
        email
      }
    })

    if(!isUserExist){
      isUserExist = await prisma.user.findUnique({
        where: {
          email: username
        }
      })
    }

    if (isUserExist) {
      return {
        error: true,
        message: "User already exist"
      }
    }

    const hashedPassword = await bcrypt.hash(password, 12)

    const newUser = await prisma.user.create({
      data: {
        email: email,
        name: username,
        password: hashedPassword,
        userType: "CANDIDATE",
        // Don't set emailVerified - will be set when user clicks verification link
      },
    })

    if (!newUser) {
      return {
        error: true,
        message: "Failed to create new user!"
      }
    }

    // Send verification email instead of signing in immediately
    try {
      const verificationResult = await sendVerificationEmail(email)
      
      if (verificationResult.error) {
        console.error("Failed to send verification email:", verificationResult.message)
        // Don't delete user, just continue without email verification for now
        return {
          error: false,
          message: "Registration successful! However, we couldn't send the verification email. You can request a new one from the login page.",
          redirectTo: `/candidate/login`
        }
      }
    } catch (emailError) {
      console.error("Email sending error:", emailError)
      // Continue without email verification
      return {
        error: false,
        message: "Registration successful! However, we couldn't send the verification email. You can request a new one from the login page.",
        redirectTo: `/candidate/login`
      }
    }

    return {
      error: false,
      message: "Registration successful! Please check your email to verify your account before logging in.",
      redirectTo: `/candidate/login`
    }
  } catch (error: any) {
    console.error(error)
    return {
      error: true,
      message: error.message
    }
  }
}

export async function onRecruiterRegistration(data: RecruiterRegistrationFormSchemaType) {
  const validate = recruiterRegistrationFormSchema.parse(data)
  if (!validate) {
    return {
      error: true,
      message: "Invalid data"
    }
  }

  const { email, companyName, contactPersonName, phone, password } = validate
  try {
    const isUserExist = await prisma.user.findUnique({
      where: {
        email
      }
    })

    if (isUserExist) {
      return {
        error: true,
        message: "User already exists"
      }
    }

    const hashedPassword = await bcrypt.hash(password, 12)

    const newUser = await prisma.user.create({
      data: {
        email: email,
        name: contactPersonName,
        password: hashedPassword,
        userType: "RECURITER",
        emailVerified: new Date(), // Auto-verify recruiter accounts for now
      },
    })

    if (!newUser) {
      return {
        error: true,
        message: "Failed to create new user!"
      }
    }

    // Create recruiter profile
    const recruiterProfile = await prisma.recruiter.create({
      data: {
        userId: newUser.id,
        companyName,
        contactPersonName,
        phone,
      }
    })

    if (!recruiterProfile) {
      // If recruiter profile creation fails, delete the user
      await prisma.user.delete({
        where: { id: newUser.id }
      })
      return {
        error: true,
        message: "Failed to create recruiter profile!"
      }
    }

    return {
      error: false,
      message: "Registration successful! You can now log in to your account.",
      redirectTo: `/recruiter/login`
    }
  } catch (error: any) {
    console.error(error)
    return {
      error: true,
      message: error.message
    }
  }
}

export async function onCandidatePersonalInfoOnboarding(data: CandidatePersonalInfoFormSchemaType) {
  try {
    const session = await auth()

    if (!session?.user?.id) {
      throw new Error("Unauthenticated")
    }

    const validate = candidatePersonalInfoFormSchema.parse(data)

    const { phone, nationality, gender, languages, age, profilePicture, referralCode } = validate

    // Update user's referral code if provided
    if (referralCode) {
      await prisma.user.update({
        where: {
          id: session.user.id,
        },
        data: {
          referralCode,
        },
      });
    }

    // First check if candidate exists
    const existingCandidate = await prisma.candidate.findUnique({
      where: {
        userId: session.user.id,
      },
      include: {
        profile: true
      }
    })

    let candidate;
    if (existingCandidate) {
      // Update existing candidate
      candidate = await prisma.candidate.update({
        where: {
          userId: session.user.id,
        },
        data: {
          profile: {
            upsert: {
              create: {
                phone,
                nationality,
                gender,
                languages,
                age: parseInt(age),
                profilePicture,
                onboardingCompleted: false,
              },
              update: {
                phone,
                nationality,
                gender,
                languages,
                age: parseInt(age),
                profilePicture,
                onboardingCompleted: false,
              }
            }
          }
        },
        include: {
          profile: true
        }
      })
    } else {
      // Create new candidate with profile
      candidate = await prisma.candidate.create({
        data: {
          userId: session.user.id,
          profile: {
            create: {
              phone,
              nationality,
              gender,
              languages,
              age: parseInt(age),
              profilePicture,
              onboardingCompleted: false,
            }
          }
        },
        include: {
          profile: true
        }
      })
    }

    if (!candidate) {
      return {
        error: true,
        message: "Failed to update personal information"
      }
    }

    return {
      error: false,
      message: "Personal information updated successfully",
      redirectTo: `/candidate/${session.user.id}/professional-info`
    }
  } catch (error: any) {
    console.error("[PROFESSIONAL_INFO_POST]", error)
    return {
      error: true,
      message: error.message
    }
  }
}

export async function onCandidateProfessionalInfoOnboarding(data: CandidateProfessionalInfoFormSchemaType) {
  try {
    const session = await auth()

    if (!session?.user?.id) {
      throw new Error("Unauthenticated")
    }

    const validate = candidateProfessionalInfoFormSchema.parse(data)

    const { degree, education, experience, jobType, skills } = validate

    // First check if candidate exists
    const existingCandidate = await prisma.candidate.findUnique({
      where: {
        userId: session.user.id,
      },
      include: {
        profile: true
      }
    })

    let candidate;
    if (existingCandidate) {
      // Update existing candidate
      candidate = await prisma.candidate.update({
        where: {
          userId: session.user.id,
        },
        data: {
          profile: {
            upsert: {
              create: {
                degree,
                education,
                experience,
                jobType,
                skills,
                onboardingCompleted: true
              },
              update: {
                degree,
                education,
                experience,
                jobType,
                skills,
                onboardingCompleted: true
              }
            }
          }
        },
        include: {
          profile: true
        }
      })
    } else {
      // Create new candidate with profile
      candidate = await prisma.candidate.create({
        data: {
          userId: session.user.id,
          profile: {
            create: {
              degree,
              education,
              experience,
              jobType,
              skills,
              onboardingCompleted: true
            }
          }
        },
        include: {
          profile: true
        }
      })
    }

    if (!candidate) {
      return {
        error: true,
        message: "Failed to update professional information"
      }
    }

    return {
      error: false,
      message: "Professional information updated successfully",
      redirectTo: `/dashboard`
    }
  } catch (error: any) {
    console.error("[PROFESSIONAL_INFO_POST]", error)
    return {
      error: true,
      message: error.message
    }
  }
}

export async function onGetUserProfile() {
  const session = await auth();
  const userId = session?.user.id;
  const user = await prisma.user.findUnique({
    where: {
      id: userId,
    },
    select: {
      name: true,
      image: true,
      email:true,
      userType:true,
      candidate: {
        select: {
          profile: {
            select: {
              profilePicture: true,
              jobType: true
            }
          }
        }
      },
    }
  });
  if(!user || !user.candidate) return null

  return {
    name:user.name as string,
    email:user.email as string,
    userType:user.userType as string,
    profilePicture: user.image || user?.candidate?.profile?.profilePicture as string,
    jobType: user?.candidate?.profile?.jobType as string,
  }
}

export async function getUsersSkills() {
  const session = await auth();
  const userId = session?.user.id;
  const user = await prisma.user.findUnique({
    where: {
      id: userId,
    },
    select: {
      candidate: {
        select: {
          profile: {
            select: {
              skills: true
            }
          }
        }
      }
    }
  });
  if(!user || !user.candidate) return null
  return user.candidate.profile?.skills || [];
}

export async function sendVerificationEmail(email: string) {
  try {
    const user = await prisma.user.findUnique({
      where: { email },
    });

    if (!user) {
      return {
        error: true,
        message: "User not found",
      };
    }

    if (user.emailVerified) {
      return {
        error: true,
        message: "Email is already verified",
      };
    }

    // Generate verification token
    const token = crypto.randomBytes(32).toString("hex");
    const expires = new Date(Date.now() + 24 * 60 * 60 * 1000); // 24 hours

    // Store verification token
    await prisma.verificationToken.create({
      data: {
        identifier: email,
        token,
        expires,
      },
    });

    // Create verification URL
    const verificationUrl = `${process.env.NEXT_PUBLIC_APP_URL}/api/auth/verify-email?token=${token}`;

    // Send verification email
    const transporter = createEmailTransporter();
    if (!transporter) {
      throw new Error("Email service is not available");
    }

    await transporter.sendMail({
      from: process.env.EMAIL_ADDRESS,
      to: email,
      subject: "Verify Your Email Address",
      html: `
        <div style="max-width: 600px; margin: 0 auto; padding: 20px; font-family: Arial, sans-serif;">
          <h2 style="color: #042052; text-align: center;">Welcome to Tabashir HR Consulting!</h2>
          <p>Thank you for registering with us. To complete your registration, please verify your email address.</p>
          <div style="text-align: center; margin: 30px 0;">
            <a href="${verificationUrl}" style="background: linear-gradient(to right, #042052, #0D57E1); color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; display: inline-block;">
              Verify Email Address
            </a>
          </div>
          <p>Or copy and paste this link in your browser:</p>
          <p style="word-break: break-all; color: #666;">${verificationUrl}</p>
          <p>This link will expire in 24 hours.</p>
          <p>If you didn't create an account with us, please ignore this email.</p>
          <hr style="margin: 30px 0; border: none; border-top: 1px solid #eee;">
          <p style="color: #666; font-size: 12px; text-align: center;">© 2024 Tabashir HR Consulting. All rights reserved.</p>
        </div>
      `,
    });

    return {
      error: false,
      message: "Verification email sent successfully",
    };
  } catch (error) {
    console.error("Send verification email error:", error);
    return {
      error: true,
      message: "Failed to send verification email. Please try again later.",
    };
  }
}

export async function resendVerificationEmail(email: string) {
  try {
    const user = await prisma.user.findUnique({
      where: { email },
    });

    if (!user) {
      return {
        error: true,
        message: "User not found",
      };
    }

    if (user.emailVerified) {
      return {
        error: true,
        message: "Email is already verified",
      };
    }

    // Delete any existing verification tokens for this email
    await prisma.verificationToken.deleteMany({
      where: { identifier: email },
    });

    // Send new verification email
    return await sendVerificationEmail(email);
  } catch (error) {
    console.error("Resend verification email error:", error);
    return {
      error: true,
      message: "Failed to resend verification email. Please try again later.",
    };
  }
}

export async function verifyEmail(token: string) {
  try {
    // Find valid verification token
    const verificationToken = await prisma.verificationToken.findFirst({
      where: {
        token,
        expires: {
          gt: new Date(),
        },
      },
    });

    if (!verificationToken) {
      return {
        error: true,
        message: "Invalid or expired verification token",
      };
    }

    // Find user and update email verification status
    const user = await prisma.user.findUnique({
      where: { email: verificationToken.identifier },
    });

    if (!user) {
      return {
        error: true,
        message: "User not found",
      };
    }

    // Update user's email verification status
    await prisma.user.update({
      where: { id: user.id },
      data: {
        emailVerified: new Date(),
      },
    });

    // Delete the verification token
    await prisma.verificationToken.delete({
      where: {
        identifier_token: {
          identifier: verificationToken.identifier,
          token: verificationToken.token,
        },
      },
    });

    return {
      error: false,
      message: "Email verified successfully! You can now log in.",
    };
  } catch (error) {
    console.error("Verify email error:", error);
    return {
      error: true,
      message: "Failed to verify email. Please try again later.",
    };
  }
}

export async function onForgotPassword(email: string) {
  try {
    // Check if user exists
    const user = await prisma.user.findUnique({
      where: { email },
    });

    if (!user) {
      return {
        error: true,
        message: "No account found with this email address",
      };
    }

    // Generate reset token
    const resetToken = crypto.randomBytes(32).toString("hex");
    const resetTokenExpiry = new Date(Date.now() + 3600000); // 1 hour from now

    // Save reset token to database
    await prisma.user.update({
      where: { email },
      data: {
        resetToken,
        resetTokenExpiry,
      },
    });

    // Create reset URL
    const resetUrl = `${process.env.NEXT_PUBLIC_APP_URL}/reset-password?token=${resetToken}`;

    // Send email
    const transporter = createEmailTransporter();
    if (!transporter) {
      throw new Error("Email service is not available");
    }

    await transporter.sendMail({
      from: process.env.EMAIL_ADDRESS,
      to: email,
      subject: "Password Reset Request",
      html: `
        <p>You requested a password reset</p>
        <p>Click this <a href="${resetUrl}">link</a> to reset your password.</p>
        <p>This link will expire in 1 hour.</p>
        <p>If you didn't request this, please ignore this email.</p>
      `,
    });

    return {
      error: false,
      message: "Password reset link sent to your email",
    };
  } catch (error) {
    console.error("Forgot password error:", error);
    return {
      error: true,
      message: "Something went wrong. Please try again later.",
    };
  }
}

export async function onResetPassword(token: string, newPassword: string) {
  try {
    // Find user with valid reset token
    const user = await prisma.user.findFirst({
      where: {
        resetToken: token,
        resetTokenExpiry: {
          gt: new Date(),
        },
      },
    });

    if (!user) {
      return {
        error: true,
        message: "Invalid or expired reset token",
      };
    }

    // Hash new password
    const hashedPassword = await bcrypt.hash(newPassword, 10);

    // Update user's password and clear reset token
    await prisma.user.update({
      where: { id: user.id },
      data: {
        password: hashedPassword,
        resetToken: null,
        resetTokenExpiry: null,
      },
    });

    return {
      error: false,
      message: "Password has been reset successfully",
    };
  } catch (error) {
    console.error("Reset password error:", error);
    return {
      error: true,
      message: "Something went wrong. Please try again later.",
    };
  }
} 