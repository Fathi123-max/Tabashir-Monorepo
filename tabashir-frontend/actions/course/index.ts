"use server";

import { auth } from "@/app/utils/auth";
import { prisma } from "@/lib/prisma";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

export interface CreateCourseData {
  title: string;
  subtitle?: string;
  description: string;
  imageUrl: string;
  price?: number;
  isFree: boolean;
  courseUrl: string;
  studio?: string;
  tags: string[];
  category?: string;
}

export interface UpdateCourseData extends CreateCourseData {
  id: string;
}

export async function createCourse(data: CreateCourseData) {
  try {
    const session = await auth();
    
    if (!session?.user?.id) {
      throw new Error("Unauthorized");
    }

    // Check if user has admin permissions
    const user = await prisma.user.findUnique({
      where: { id: session.user.id },
      include: { adminPermissions: true }
    });

    if (!user || (user.userType !== "ADMIN" && user.adminRole !== "SUPER_ADMIN")) {
      throw new Error("Insufficient permissions");
    }

    const course = await prisma.course.create({
      data: {
        title: data.title,
        subtitle: data.subtitle,
        description: data.description,
        imageUrl: data.imageUrl,
        price: data.isFree ? null : data.price,
        isFree: data.isFree,
        courseUrl: data.courseUrl,
        studio: data.studio,
        tags: data.tags,
        category: data.category,
        createdById: session.user.id,
      },
    });

    revalidatePath("/admin/courses");
    revalidatePath("/free-courses");
    
    return { success: true, course };
  } catch (error) {
    console.error("Error creating course:", error);
    return { 
      success: false, 
      error: error instanceof Error ? error.message : "Failed to create course" 
    };
  }
}

export async function updateCourse(data: UpdateCourseData) {
  try {
    const session = await auth();
    
    if (!session?.user?.id) {
      throw new Error("Unauthorized");
    }

    // Check if user has admin permissions
    const user = await prisma.user.findUnique({
      where: { id: session.user.id },
      include: { adminPermissions: true }
    });

    if (!user || (user.userType !== "ADMIN" && user.adminRole !== "SUPER_ADMIN")) {
      throw new Error("Insufficient permissions");
    }

    const course = await prisma.course.update({
      where: { id: data.id },
      data: {
        title: data.title,
        subtitle: data.subtitle,
        description: data.description,
        imageUrl: data.imageUrl,
        price: data.isFree ? null : data.price,
        isFree: data.isFree,
        courseUrl: data.courseUrl,
        studio: data.studio,
        tags: data.tags,
        category: data.category,
      },
    });

    revalidatePath("/admin/courses");
    revalidatePath("/free-courses");
    
    return { success: true, course };
  } catch (error) {
    console.error("Error updating course:", error);
    return { 
      success: false, 
      error: error instanceof Error ? error.message : "Failed to update course" 
    };
  }
}

export async function deleteCourse(id: string) {
  try {
    const session = await auth();
    
    if (!session?.user?.id) {
      throw new Error("Unauthorized");
    }

    // Check if user has admin permissions
    const user = await prisma.user.findUnique({
      where: { id: session.user.id },
      include: { adminPermissions: true }
    });

    if (!user || (user.userType !== "ADMIN" && user.adminRole !== "SUPER_ADMIN")) {
      throw new Error("Insufficient permissions");
    }

    await prisma.course.delete({
      where: { id },
    });

    revalidatePath("/admin/courses");
    revalidatePath("/free-courses");
    
    return { success: true };
  } catch (error) {
    console.error("Error deleting course:", error);
    return { 
      success: false, 
      error: error instanceof Error ? error.message : "Failed to delete course" 
    };
  }
}

export async function toggleCourseStatus(id: string, isActive: boolean) {
  try {
    const session = await auth();
    
    if (!session?.user?.id) {
      throw new Error("Unauthorized");
    }

    // Check if user has admin permissions
    const user = await prisma.user.findUnique({
      where: { id: session.user.id },
      include: { adminPermissions: true }
    });

    if (!user || (user.userType !== "ADMIN" && user.adminRole !== "SUPER_ADMIN")) {
      throw new Error("Insufficient permissions");
    }

    const course = await prisma.course.update({
      where: { id },
      data: { isActive },
    });

    revalidatePath("/admin/courses");
    revalidatePath("/free-courses");
    
    return { success: true, course };
  } catch (error) {
    console.error("Error toggling course status:", error);
    return { 
      success: false, 
      error: error instanceof Error ? error.message : "Failed to toggle course status" 
    };
  }
}

export async function getCourses(activeOnly: boolean = false) {
  try {
    const courses = await prisma.course.findMany({
      where: activeOnly ? { isActive: true } : {},
      include: {
        createdBy: {
          select: {
            name: true,
            email: true,
          },
        },
      },
      orderBy: {
        createdAt: "desc",
      },
    });

    return { success: true, courses };
  } catch (error) {
    console.error("Error fetching courses:", error);
    return { 
      success: false, 
      error: error instanceof Error ? error.message : "Failed to fetch courses",
      courses: []
    };
  }
}

export async function getCourse(id: string) {
  try {
    const course = await prisma.course.findUnique({
      where: { id },
      include: {
        createdBy: {
          select: {
            name: true,
            email: true,
          },
        },
      },
    });

    if (!course) {
      throw new Error("Course not found");
    }

    return { success: true, course };
  } catch (error) {
    console.error("Error fetching course:", error);
    return { 
      success: false, 
      error: error instanceof Error ? error.message : "Failed to fetch course" 
    };
  }
}


