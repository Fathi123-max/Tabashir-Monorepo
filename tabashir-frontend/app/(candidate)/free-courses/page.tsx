"use client"

import { useState, useEffect } from "react";
import { Search, ExternalLink, Filter } from "lucide-react";
import Image from "next/image";
import Link from "next/link";
import { useTranslation } from "@/lib/use-translation";
import { getCourses } from "@/actions/course";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent } from "@/components/ui/card";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
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
}

export default function FreeCourses() {
  const { t, isRTL } = useTranslation();
  const [courses, setCourses] = useState<Course[]>([]);
  const [filteredCourses, setFilteredCourses] = useState<Course[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedCategory, setSelectedCategory] = useState<string>("all");

  const fetchCourses = async () => {
    try {
      setLoading(true);
      const result = await getCourses(true); // Only get active courses
      if (result.success) {
        setCourses(result.courses as Course[]);
        setFilteredCourses(result.courses as Course[]);
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

  // Filter courses based on search query and category
  useEffect(() => {
    let filtered = courses;

    // Filter by search query
    if (searchQuery.trim()) {
      filtered = filtered.filter(course =>
        course.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
        course.subtitle?.toLowerCase().includes(searchQuery.toLowerCase()) ||
        course.description.toLowerCase().includes(searchQuery.toLowerCase()) ||
        course.studio?.toLowerCase().includes(searchQuery.toLowerCase())
      );
    }

    // Filter by category
    if (selectedCategory !== "all") {
      filtered = filtered.filter(course => course.category === selectedCategory);
    }

    setFilteredCourses(filtered);
  }, [courses, searchQuery, selectedCategory]);

  // Get unique categories
  const categories = Array.from(new Set(courses.map(course => course.category).filter(Boolean)));

  // Strip HTML tags from description for display
  const stripHtml = (html: string) => {
    try {
      const parsed = JSON.parse(html);
      return extractTextFromTiptapJson(parsed);
    } catch {
      return html.replace(/<[^>]*>/g, '');
    }
  };

  const extractTextFromTiptapJson = (json: any): string => {
    if (!json || !json.content) return '';

    let text = '';
    json.content.forEach((node: any) => {
      if (node.type === 'paragraph' || node.type === 'heading') {
        if (node.content) {
          node.content.forEach((textNode: any) => {
            if (textNode.type === 'text') {
              text += textNode.text + ' ';
            }
          });
        }
      }
    });
    return text.trim();
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-gray-900"></div>
      </div>
    );
  }

  return (
    <div className={`w-full ${isRTL ? 'text-right' : 'text-left'}`}>
      {/* Search and Filter Section */}
      <div className="mb-8 space-y-4">
        <div className={`flex flex-col sm:flex-row gap-4 ${isRTL ? 'sm:flex-row-reverse' : ''}`}>
          {/* Search bar */}
          <div className="relative flex-1 max-w-md">
            <input
              type="text"
              placeholder={t("searchCourses")}
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className={`w-full h-10 ${isRTL ? 'pr-10 pl-4' : 'pl-10 pr-4'} text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent`}
            />
            <Search className={`absolute ${isRTL ? 'right-3' : 'left-3'} top-1/2 transform -translate-y-1/2 text-gray-400`} size={18} />
          </div>

          {/* Category Filter */}
          <div className="flex items-center gap-2">
            <Filter className="w-4 h-4 text-gray-500" />
            <Select value={selectedCategory} onValueChange={setSelectedCategory}>
              <SelectTrigger className="w-[180px]">
                <SelectValue placeholder={t("allCategories")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("allCategories")}</SelectItem>
                {categories.map((category) => (
                  <SelectItem key={category} value={category || ""}>
                    {category?.charAt(0).toUpperCase() || "" + category?.slice(1) || ""}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
        </div>
      </div>

      {/* Header Section */}
      <div className="mb-8">
        <h2 className="text-2xl font-bold mb-2 text-black">
          {t("recommendedVideos") || "Available Courses"}
        </h2>
        <p className="text-gray-600">
          {filteredCourses.length} {filteredCourses.length === 1 ? t("coursesAvailable") : t("coursesAvailablePlural")}
        </p>
      </div>

      {/* Course grid */}
      {filteredCourses.length === 0 ? (
        <Card className="p-12 text-center">
          <div className="text-gray-500">
            <h3 className="text-lg font-medium mb-2">
              {searchQuery || selectedCategory !== "all" ? t("noCoursesFound") : t("noCourses")}
            </h3>
            <p className="text-sm">
              {searchQuery || selectedCategory !== "all"
                ? t("tryAdjustingSearch")
                : t("checkBackLater")
              }
            </p>
          </div>
        </Card>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {filteredCourses.map((course) => (
            <Card key={course.id} className="rounded-lg overflow-hidden shadow-sm hover:shadow-lg transition-all duration-300 group">
              <div className="relative h-[200px] overflow-hidden">
                <Image
                  src={course.imageUrl || "/placeholder.svg"}
                  alt={course.title}
                  fill
                  className="object-cover group-hover:scale-105 transition-transform duration-300"
                  priority
                />

                {/* Course Link Button */}
                <Link
                  href={course.courseUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="absolute inset-0 bg-black bg-opacity-0 group-hover:bg-opacity-20 transition-all duration-300 flex items-center justify-center"
                >
                  <div className="bg-white bg-opacity-90 rounded-full p-3 opacity-0 group-hover:opacity-100 transition-all duration-300 transform scale-75 group-hover:scale-100">
                    <ExternalLink className="w-5 h-5 text-gray-800" />
                  </div>
                </Link>

                {/* Tags */}
                <div className={`absolute top-4 ${isRTL ? 'right-4' : 'left-4'}`}>
                  <div className="flex gap-1 flex-wrap">
                    {course.tags.map((tag, index) => (
                      <Badge
                        key={index}
                        variant={tag === "BEST SELLER" ? "default" : tag === "NEW" ? "destructive" : "secondary"}
                        className="text-xs font-bold"
                      >
                        {tag === "BEST SELLER" ? t("bestSeller") || "BEST SELLER" :
                          tag === "NEW" ? t("new") || "NEW" : tag}
                      </Badge>
                    ))}
                  </div>
                </div>

                {/* Price Badge */}
                <div className={`absolute top-4 ${isRTL ? 'left-4' : 'right-4'}`}>
                  {course.isFree ? (
                    <Badge className="bg-green-500 hover:bg-green-600 text-white font-bold">
                      FREE
                    </Badge>
                  ) : (
                    <Badge className="bg-blue-500 hover:bg-blue-600 text-white font-bold">
                      {course.price} AED
                    </Badge>
                  )}
                </div>
              </div>

              <CardContent className="p-5">
                <div className="space-y-3">
                  <div>
                    <h3 className="font-bold text-lg mb-1 text-black line-clamp-2 group-hover:text-blue-600 transition-colors">
                      {course.title}
                    </h3>
                    {course.subtitle && (
                      <h4 className="text-sm text-gray-600 line-clamp-1">
                        {course.subtitle}
                      </h4>
                    )}
                  </div>

                  {course.studio && (
                    <p className="text-xs text-gray-500 font-medium">
                      {t("by")} {course.studio}
                    </p>
                  )}

                  <p className="text-sm text-gray-700 line-clamp-3">
                    {stripHtml(course.description)}
                  </p>

                  {course.category && (
                    <div className="pt-2">
                      <Badge variant="outline" className="text-xs">
                        {course.category.charAt(0).toUpperCase() + course.category.slice(1)}
                      </Badge>
                    </div>
                  )}

                  {/* Action Button */}
                  <div className="pt-4">
                    <Button asChild className="w-full group-hover:bg-blue-600 transition-colors">
                      <Link
                        href={course.courseUrl}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="flex items-center justify-center gap-2"
                      >
                        <ExternalLink className="w-4 h-4" />
                        {t("startCourse")}
                      </Link>
                    </Button>
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
