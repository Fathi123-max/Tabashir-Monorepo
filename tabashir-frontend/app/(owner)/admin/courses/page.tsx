"use client";

import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Switch } from "@/components/ui/switch";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent, AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle, AlertDialogTrigger } from "@/components/ui/alert-dialog";
import { Plus, Edit, Trash2, Eye, EyeOff, ExternalLink } from "lucide-react";
import Image from "next/image";
import Link from "next/link";
import { getCourses, deleteCourse, toggleCourseStatus } from "@/actions/course";
import CourseForm from "@/components/forms/course/course-form";
import { toast } from "@/hooks/use-toast";


interface Course {
  id: string;
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
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
  createdBy: {
    name: string | null;
    email: string | null;
  };
}

export default function CoursesPage() {
  const [courses, setCourses] = useState<Course[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedCourse, setSelectedCourse] = useState<Course | null>(null);
  const [showCreateDialog, setShowCreateDialog] = useState(false);
  const [showEditDialog, setShowEditDialog] = useState(false);

  const fetchCourses = async () => {
    try {
      setLoading(true);
      const result = await getCourses();
      if (result.success) {
        setCourses(result.courses as Course[]);
      } else {
        toast({
          title: "Error",
          description: result.error,
          variant: "destructive",
        });
      }
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to fetch courses",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchCourses();
  }, []);

  const handleToggleStatus = async (courseId: string, isActive: boolean) => {
    const result = await toggleCourseStatus(courseId, isActive);
    if (result.success) {
      toast({
        title: "Success",
        description: `Course ${isActive ? 'activated' : 'deactivated'} successfully`,
      });
      fetchCourses();
    } else {
      toast({
        title: "Error",
        description: result.error,
        variant: "destructive",
      });
    }
  };

  const handleDelete = async (courseId: string) => {
    const result = await deleteCourse(courseId);
    if (result.success) {
      toast({
        title: "Success",
        description: "Course deleted successfully",
      });
      fetchCourses();
    } else {
      toast({
        title: "Error",
        description: result.error,
        variant: "destructive",
      });
    }
  };

  const handleFormSuccess = () => {
    setShowCreateDialog(false);
    setShowEditDialog(false);
    setSelectedCourse(null);
    fetchCourses();
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-gray-900"></div>
      </div>
    );
  }

  return (
    <div className="w-full p-6">
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Course Management</h1>
          <p className="text-gray-600 mt-1">Manage and organize your courses</p>
        </div>

        <Dialog open={showCreateDialog} onOpenChange={setShowCreateDialog}>
          <DialogTrigger asChild>
            <Button className="flex items-center gap-2">
              <Plus className="w-4 h-4" />
              Add New Course
            </Button>
          </DialogTrigger>
          <DialogContent className="max-w-4xl max-h-[90vh] overflow-y-auto">
            <DialogHeader>
              <DialogTitle>Create New Course</DialogTitle>
            </DialogHeader>
            <CourseForm
              onSuccess={handleFormSuccess}
              onCancel={() => setShowCreateDialog(false)}
            />
          </DialogContent>
        </Dialog>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total Courses</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{courses.length}</div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Active Courses</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-green-600">
              {courses.filter(c => c.isActive).length}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Free Courses</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-blue-600">
              {courses.filter(c => c.isFree).length}
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Courses Grid */}
      {courses.length === 0 ? (
        <Card className="p-8 text-center">
          <div className="text-gray-500">
            <h3 className="text-lg font-medium mb-2">No courses yet</h3>
            <p className="text-sm">Create your first course to get started.</p>
          </div>
        </Card>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {courses.map((course) => (
            <Card key={course.id} className="overflow-hidden hover:shadow-lg transition-shadow">
              <div className="relative h-48 overflow-hidden">
                <Image
                  src={course.imageUrl}
                  alt={course.title}
                  fill
                  className="object-cover"
                />
                <div className="absolute top-4 left-4">
                  <div className="flex gap-1 flex-wrap">
                    {course.tags.map((tag, index) => (
                      <Badge
                        key={index}
                        variant={tag === "BEST SELLER" ? "default" : "secondary"}
                        className="text-xs"
                      >
                        {tag}
                      </Badge>
                    ))}
                  </div>
                </div>
                <div className="absolute top-4 right-4">
                  <Switch
                    checked={course.isActive}
                    onCheckedChange={(checked) => handleToggleStatus(course.id, checked)}
                    className="data-[state=checked]:bg-green-500"
                  />
                </div>
              </div>

              <CardContent className="p-4">
                <div className="space-y-2">
                  <h3 className="font-bold text-lg line-clamp-2">{course.title}</h3>
                  {course.subtitle && (
                    <p className="text-sm text-gray-600 line-clamp-1">{course.subtitle}</p>
                  )}
                  {course.studio && (
                    <p className="text-xs text-gray-500">& {course.studio}</p>
                  )}

                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-2">
                      {course.isFree ? (
                        <Badge variant="outline" className="text-green-600 border-green-600">
                          Free
                        </Badge>
                      ) : (
                        <Badge variant="outline" className="text-blue-600 border-blue-600">
                          {course.price} AED
                        </Badge>
                      )}
                      {course.category && (
                        <Badge variant="outline" className="text-xs">
                          {course.category}
                        </Badge>
                      )}
                    </div>

                    <div className="flex items-center gap-1">
                      {course.isActive ? (
                        <Eye className="w-4 h-4 text-green-500" />
                      ) : (
                        <EyeOff className="w-4 h-4 text-gray-400" />
                      )}
                    </div>
                  </div>

                  <div className="text-xs text-gray-500">
                    Created by {course.createdBy.name || course.createdBy.email}
                  </div>
                </div>

                <div className="flex items-center justify-between mt-4 pt-4 border-t">
                  <Link
                    href={course.courseUrl}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="flex items-center gap-1 text-sm text-blue-600 hover:text-blue-800"
                  >
                    <ExternalLink className="w-4 h-4" />
                    View Course
                  </Link>

                  <div className="flex items-center gap-2">
                    <Dialog open={showEditDialog && selectedCourse?.id === course.id} onOpenChange={(open) => {
                      setShowEditDialog(open);
                      if (!open) setSelectedCourse(null);
                    }}>
                      <DialogTrigger asChild>
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => setSelectedCourse(course)}
                        >
                          <Edit className="w-4 h-4" />
                        </Button>
                      </DialogTrigger>
                      <DialogContent className="max-w-4xl max-h-[90vh] overflow-y-auto">
                        <DialogHeader>
                          <DialogTitle>Edit Course</DialogTitle>
                        </DialogHeader>
                        {selectedCourse && (
                          <CourseForm
                            initialData={selectedCourse}
                            onSuccess={handleFormSuccess}
                            onCancel={() => {
                              setShowEditDialog(false);
                              setSelectedCourse(null);
                            }}
                          />
                        )}
                      </DialogContent>
                    </Dialog>

                    <AlertDialog>
                      <AlertDialogTrigger asChild>
                        <Button variant="outline" size="sm" className="text-red-600 hover:text-red-700">
                          <Trash2 className="w-4 h-4" />
                        </Button>
                      </AlertDialogTrigger>
                      <AlertDialogContent>
                        <AlertDialogHeader>
                          <AlertDialogTitle>Delete Course</AlertDialogTitle>
                          <AlertDialogDescription>
                            Are you sure you want to delete "{course.title}"? This action cannot be undone.
                          </AlertDialogDescription>
                        </AlertDialogHeader>
                        <AlertDialogFooter>
                          <AlertDialogCancel>Cancel</AlertDialogCancel>
                          <AlertDialogAction
                            onClick={() => handleDelete(course.id)}
                            className="bg-red-600 hover:bg-red-700"
                          >
                            Delete
                          </AlertDialogAction>
                        </AlertDialogFooter>
                      </AlertDialogContent>
                    </AlertDialog>
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      )}
    </div>
  );
}