"use client";

import { useState, useEffect } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { UploadDropzone } from "@/lib/uploadthing";
import TiptapEditor from "@/components/tiptap-editor";
import { createCourse, updateCourse, type CreateCourseData, type UpdateCourseData } from "@/actions/course";
import { toast } from "@/hooks/use-toast";
import { Loader2, X, Plus } from "lucide-react";
import Image from "next/image";
import { useTranslation } from "@/lib/use-translation";

const courseSchema = z.object({
  title: z.string().min(1, "Title is required"),
  subtitle: z.string().optional(),
  description: z.string().min(1, "Description is required"),
  imageUrl: z.string().min(1, "Course image is required"),
  price: z.number().min(0, "Price must be positive").optional(),
  isFree: z.boolean(),
  courseUrl: z.string().url("Please enter a valid URL"),
  studio: z.string().optional(),
  tags: z.array(z.string()),
  category: z.string().optional(),
});

type CourseFormData = z.infer<typeof courseSchema>;

interface CourseFormProps {
  initialData?: UpdateCourseData;
  onSuccess?: () => void;
  onCancel?: () => void;
}

const COURSE_CATEGORIES = [
  { value: "vue", label: "Vue.js" },
  { value: "react", label: "React" },
  { value: "ui", label: "UI/UX Design" },
  { value: "mobile", label: "Mobile Development" },
  { value: "backend", label: "Backend Development" },
  { value: "frontend", label: "Frontend Development" },
  { value: "fullstack", label: "Full Stack Development" },
  { value: "devops", label: "DevOps" },
  { value: "data", label: "Data Science" },
  { value: "ai", label: "AI/ML" },
];

const PREDEFINED_TAGS = ["BEST SELLER", "NEW", "POPULAR", "FEATURED"];

export default function CourseForm({ initialData, onSuccess, onCancel }: CourseFormProps) {
  const { t, isRTL } = useTranslation();
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [newTag, setNewTag] = useState("");
  const [customCategory, setCustomCategory] = useState("");
  const [isCustomCategory, setIsCustomCategory] = useState(false);

  const form = useForm<CourseFormData>({
    resolver: zodResolver(courseSchema),
    defaultValues: {
      title: initialData?.title || "",
      subtitle: initialData?.subtitle || "",
      description: initialData?.description || "",
      imageUrl: initialData?.imageUrl || "",
      price: initialData?.price || undefined,
      isFree: initialData?.isFree ?? false,
      courseUrl: initialData?.courseUrl || "",
      studio: initialData?.studio || "",
      tags: initialData?.tags || [],
      category: initialData?.category || "",
    },
  });

  const watchIsFree = form.watch("isFree");
  const watchTags = form.watch("tags");
  const watchImageUrl = form.watch("imageUrl");

  // Handle initial custom category state
  useEffect(() => {
    if (initialData?.category) {
      const isPreDefinedCategory = COURSE_CATEGORIES.some(cat => cat.value === initialData.category);
      setIsCustomCategory(!isPreDefinedCategory);
      if (!isPreDefinedCategory) {
        setCustomCategory(initialData.category);
      }
    }
  }, [initialData?.category]);

  const onSubmit = async (data: CourseFormData) => {
    try {
      setIsSubmitting(true);

      console.log(data);

      let result;
      if (initialData?.id) {
        result = await updateCourse({ ...data, id: initialData.id });
      } else {
        result = await createCourse(data);
      }

      if (result.success) {
        toast({
          title: "Success",
          description: `Course ${initialData ? 'updated' : 'created'} successfully`,
        });
        onSuccess?.();
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
        description: "An unexpected error occurred",
        variant: "destructive",
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  const addTag = () => {
    if (newTag.trim() && !watchTags.includes(newTag.trim())) {
      form.setValue("tags", [...watchTags, newTag.trim()]);
      setNewTag("");
    }
  };

  const removeTag = (tagToRemove: string) => {
    form.setValue("tags", watchTags.filter(tag => tag !== tagToRemove));
  };

  const addPredefinedTag = (tag: string) => {
    if (!watchTags.includes(tag)) {
      form.setValue("tags", [...watchTags, tag]);
    }
  };

  return (
    <div className={`max-w-4xl mx-auto p-6 ${isRTL ? 'text-right' : 'text-left'}`}>
      <Form {...form}>
        <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
          {/* Course Image Upload */}
          <div className="space-y-4">
            <Label className="text-sm font-medium">Course Image</Label>
            {watchImageUrl ? (
              <div className="relative w-full h-48 rounded-lg overflow-hidden border-2 border-dashed border-gray-300">
                <Image
                  src={watchImageUrl}
                  alt="Course preview"
                  fill
                  className="object-cover"
                />
                <Button
                  type="button"
                  variant="destructive"
                  size="sm"
                  className="absolute top-2 right-2"
                  onClick={() => form.setValue("imageUrl", "")}
                >
                  <X className="w-4 h-4" />
                </Button>
              </div>
            ) : (
              <div className="w-full">
                <UploadDropzone
                  endpoint="courseImageUploader"
                  appearance={{
                    container:
                      "flex flex-col items-center justify-center w-full h-48 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100",
                    button:
                      "bg-white text-black border border-gray-300 hover:bg-gray-100",
                    allowedContent: "text-gray-600",
                  }}
                  onClientUploadComplete={(res) => {
                    if (res?.[0]?.url) {
                      form.setValue("imageUrl", res[0].url);
                      toast({
                        title: "Success",
                        description: "Image uploaded successfully",
                      });
                    }
                  }}
                  onUploadError={(error: Error) => {
                    toast({
                      title: "Error",
                      description: `Upload failed: ${error.message}`,
                      variant: "destructive",
                    });
                  }}
                />
              </div>
            )}
            {form.formState.errors.imageUrl && (
              <p className="text-sm text-red-500">{form.formState.errors.imageUrl.message}</p>
            )}
          </div>

          {/* Title */}
          <FormField
            control={form.control}
            name="title"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Course Title *</FormLabel>
                <FormControl>
                  <Input placeholder="Enter course title" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />

          {/* Subtitle */}
          <FormField
            control={form.control}
            name="subtitle"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Course Subtitle</FormLabel>
                <FormControl>
                  <Input placeholder="Enter course subtitle" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />

          {/* Studio */}
          <FormField
            control={form.control}
            name="studio"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Studio/Provider</FormLabel>
                <FormControl>
                  <Input placeholder="e.g., Kleon Studio" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />

          {/* Category */}
          <FormField
            control={form.control}
            name="category"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Category</FormLabel>
                <div className="space-y-4">
                  <Select
                    onValueChange={(value) => {
                      if (value === "custom") {
                        setIsCustomCategory(true);
                        field.onChange("");
                      } else {
                        setIsCustomCategory(false);
                        field.onChange(value);
                      }
                    }}
                    defaultValue={field.value || "custom"}
                  >
                    <FormControl>
                      <SelectTrigger>
                        <SelectValue placeholder="Select a category" />
                      </SelectTrigger>
                    </FormControl>
                    <SelectContent>
                      <SelectItem value="custom">Add Custom Category</SelectItem>
                      {COURSE_CATEGORIES.map((category) => (
                        <SelectItem key={category.value} value={category.value}>
                          {category.label}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>

                  {isCustomCategory && (
                    <div className="flex gap-2">
                      <Input
                        placeholder="Enter custom category"
                        value={customCategory}
                        onChange={(e) => {
                          setCustomCategory(e.target.value);
                          field.onChange(e.target.value);
                        }}
                      />
                    </div>
                  )}
                </div>
                <FormMessage />
              </FormItem>
            )}
          />

          {/* Course URL */}
          <FormField
            control={form.control}
            name="courseUrl"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Course URL *</FormLabel>
                <FormControl>
                  <Input placeholder="https://example.com/course" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />

          {/* Description with Rich Text Editor */}
          <FormField
            control={form.control}
            name="description"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Course Description *</FormLabel>
                <FormControl>
                  <TiptapEditor field={field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />

          {/* Pricing */}
          <div className="space-y-4">
            <FormField
              control={form.control}
              name="isFree"
              render={({ field }) => (
                <FormItem className="flex flex-row items-center justify-between rounded-lg border p-4">
                  <div className="space-y-0.5">
                    <FormLabel className="text-base">Free Course</FormLabel>
                    <div className="text-sm text-muted-foreground">
                      Mark this course as free for all users
                    </div>
                  </div>
                  <FormControl>
                    <Switch
                      checked={field.value}
                      onCheckedChange={field.onChange}
                    />
                  </FormControl>
                </FormItem>
              )}
            />

            {!watchIsFree && (
              <FormField
                control={form.control}
                name="price"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Price (AED)</FormLabel>
                    <FormControl>
                      <Input
                        type="number"
                        step="0.01"
                        min="0"
                        placeholder="0.00"
                        {...field}
                        onChange={(e) => field.onChange(parseFloat(e.target.value) || undefined)}
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
            )}
          </div>

          {/* Tags */}
          <div className="space-y-4">
            <Label className="text-sm font-medium">Tags</Label>

            {/* Predefined Tags */}
            <div className="flex flex-wrap gap-2">
              {PREDEFINED_TAGS.map((tag) => (
                <Button
                  key={tag}
                  type="button"
                  variant={watchTags.includes(tag) ? "default" : "outline"}
                  size="sm"
                  onClick={() => addPredefinedTag(tag)}
                >
                  {tag}
                </Button>
              ))}
            </div>

            {/* Custom Tag Input */}
            <div className="flex gap-2">
              <Input
                placeholder="Add custom tag"
                value={newTag}
                onChange={(e) => setNewTag(e.target.value)}
                onKeyPress={(e) => {
                  if (e.key === "Enter") {
                    e.preventDefault();
                    addTag();
                  }
                }}
              />
              <Button type="button" onClick={addTag} size="sm">
                <Plus className="w-4 h-4" />
              </Button>
            </div>

            {/* Selected Tags */}
            {watchTags.length > 0 && (
              <div className="flex flex-wrap gap-2">
                {watchTags.map((tag, index) => (
                  <Badge key={index} variant="secondary" className="flex items-center gap-1">
                    {tag}
                    <Button
                      type="button"
                      variant="ghost"
                      size="sm"
                      className="h-auto p-0 text-xs"
                      onClick={() => removeTag(tag)}
                    >
                      <X className="w-3 h-3" />
                    </Button>
                  </Badge>
                ))}
              </div>
            )}
          </div>

          {/* Submit Buttons */}
          <div className={`flex gap-4 pt-6 ${isRTL ? 'justify-start' : 'justify-end'}`}>
            {onCancel && (
              <Button type="button" variant="outline" onClick={onCancel}>
                Cancel
              </Button>
            )}
            <Button type="submit" disabled={isSubmitting}>
              {isSubmitting && <Loader2 className="w-4 h-4 mr-2 animate-spin" />}
              {initialData ? "Update Course" : "Create Course"}
            </Button>
          </div>
        </form>
      </Form>
    </div>
  );
}


