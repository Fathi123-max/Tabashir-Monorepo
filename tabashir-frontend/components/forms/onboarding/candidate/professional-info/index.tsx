"use client";
import { useState } from "react";
import { X, Plus, Search, Check, ChevronsUpDown } from "lucide-react";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { Button } from "@/components/ui/button";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Command, CommandEmpty, CommandGroup, CommandInput, CommandItem } from "@/components/ui/command";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { cn } from "@/lib/utils";
import { useRouter } from "next/navigation";
import {
  candidateProfessionalInfoFormSchema,
  CandidateProfessionalInfoFormSchemaType,
} from "./schema";
import { onCandidateProfessionalInfoOnboarding } from "@/actions/auth";
import { toast } from "sonner";
import { useFormStatus } from "react-dom";

const JOB_POSITIONS = [
  // Technology & IT
  "Web Designer",
  "Product Manager",
  "UX Designer",
  "Frontend Developer",
  "Backend Developer",
  "Full Stack Developer",
  "Data Scientist",
  "Data Analyst",
  "Software Engineer",
  "DevOps Engineer",
  "Mobile App Developer",
  "UI/UX Designer",
  "System Administrator",
  "Network Engineer",
  "Cybersecurity Specialist",
  "Cloud Architect",
  "Database Administrator",
  "QA Engineer",
  "Technical Writer",
  "IT Support Specialist",

  // Business & Management
  "Business Analyst",
  "Project Manager",
  "Operations Manager",
  "General Manager",
  "Executive Assistant",
  "Business Development Manager",
  "Strategy Consultant",
  "Management Consultant",
  "Team Lead",
  "Department Head",

  // Marketing & Sales
  "Digital Marketing Specialist",
  "Social Media Manager",
  "Content Creator",
  "Marketing Manager",
  "Sales Representative",
  "Account Manager",
  "Brand Manager",
  "SEO Specialist",
  "Email Marketing Specialist",
  "Growth Hacker",
  "Sales Manager",
  "Customer Success Manager",

  // Finance & Accounting
  "Accountant",
  "Financial Analyst",
  "Finance Manager",
  "Investment Analyst",
  "Auditor",
  "Tax Specialist",
  "Credit Analyst",
  "Risk Analyst",
  "Treasury Analyst",
  "Controller",

  // Human Resources
  "HR Specialist",
  "Recruiter",
  "HR Manager",
  "Training Specialist",
  "Compensation Analyst",
  "Employee Relations Specialist",
  "HR Business Partner",
  "Talent Acquisition Specialist",

  // Customer Service
  "Customer Service Representative",
  "Call Center Agent",
  "Customer Support Specialist",
  "Help Desk Technician",
  "Client Relations Manager",

  // Healthcare
  "Registered Nurse",
  "Medical Assistant",
  "Healthcare Administrator",
  "Physical Therapist",
  "Pharmacist",
  "Medical Technician",
  "Healthcare Consultant",

  // Education
  "Teacher",
  "Professor",
  "Training Coordinator",
  "Curriculum Developer",
  "Educational Consultant",
  "Academic Advisor",

  // Engineering
  "Mechanical Engineer",
  "Civil Engineer",
  "Electrical Engineer",
  "Chemical Engineer",
  "Industrial Engineer",
  "Environmental Engineer",
  "Quality Engineer",
  "Process Engineer",

  // Creative & Design
  "Graphic Designer",
  "Creative Director",
  "Video Editor",
  "Photographer",
  "Content Writer",
  "Copywriter",
  "Art Director",
  "Interior Designer",

  // Operations & Logistics
  "Supply Chain Manager",
  "Logistics Coordinator",
  "Warehouse Manager",
  "Procurement Specialist",
  "Operations Analyst",
  "Production Manager",

  // Legal
  "Legal Assistant",
  "Paralegal",
  "Compliance Officer",
  "Contract Specialist",
  "Legal Counsel",

  // Others
  "Administrative Assistant",
  "Office Manager",
  "Receptionist",
  "Research Assistant",
  "Translator",
  "Virtual Assistant",
  "Consultant",
  "Freelancer",
  "Intern",
  "Entry Level"
];

const CandidateProfessionalInfoForm = () => {
  const { pending } = useFormStatus()
  const [isLoading, setIsloading] = useState(false);
  const router = useRouter();
  const [skills, setSkills] = useState<string[]>([]);
  const [currentSkill, setCurrentSkill] = useState("");
  const [isCustomJobType, setIsCustomJobType] = useState(false);
  const [customJobType, setCustomJobType] = useState("");

  const form = useForm<CandidateProfessionalInfoFormSchemaType>({
    resolver: zodResolver(candidateProfessionalInfoFormSchema),
    defaultValues: {
      jobType: "",
      skills: skills,
      experience: "",
      education: "",
      degree: "",
    },
  });

  const removeSkill = (skill: string) => {
    const newSkills = skills.filter((s) => s !== skill);
    setSkills(newSkills);
    form.setValue("skills", newSkills);
  };

  const addSkill = (skill: string) => {
    if (skill.trim() && !skills.includes(skill.trim())) {
      const newSkills = [...skills, skill.trim()];
      setSkills(newSkills);
      form.setValue("skills", newSkills);
      setCurrentSkill("");
    }
  };

  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === "Enter") {
      e.preventDefault();
      addSkill(currentSkill);
    }
  };

  async function onSubmit(values: CandidateProfessionalInfoFormSchemaType) {
    try {
      setIsloading(true);
      const response = await onCandidateProfessionalInfoOnboarding(values);

      if (response.error) {
        toast.error(response.message, {
          className: "bg-red-500 text-white",
        });
      }
      toast.success(response.message, {
        className: "bg-green-500 text-white",
      });
      router.push(response.redirectTo as string);
    } catch (error) {
      console.error("Error saving personal information:", error);
    } finally {
      setIsloading(false);
    }
  }
  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
        <FormField
          control={form.control}
          name="jobType"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">
                What kind of job are you looking for?
              </FormLabel>
              <FormControl>
                <div className="space-y-3">
                  {!isCustomJobType ? (
                    <Popover>
                      <PopoverTrigger asChild>
                        <Button
                          variant="outline"
                          role="combobox"
                          className="w-full justify-between text-gray-900"
                        >
                          {field.value || "Select job position..."}
                          <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
                        </Button>
                      </PopoverTrigger>
                      <PopoverContent className="w-full p-0">
                        <Command>
                          <CommandInput placeholder="Search job positions..." />
                          <CommandEmpty>
                            <div className="p-2 text-center">
                              <p className="text-sm text-gray-500 mb-2">No job position found.</p>
                              <Button
                                variant="outline"
                                size="sm"
                                onClick={() => {
                                  setIsCustomJobType(true);
                                  setCustomJobType("");
                                  field.onChange("");
                                }}
                              >
                                <Plus className="mr-2 h-4 w-4" />
                                Add Custom Position
                              </Button>
                            </div>
                          </CommandEmpty>
                          <CommandGroup className="max-h-64 overflow-auto">
                            {JOB_POSITIONS.map((position) => (
                              <CommandItem
                                key={position}
                                onSelect={() => {
                                  field.onChange(position);
                                }}
                              >
                                <Check
                                  className={cn(
                                    "mr-2 h-4 w-4",
                                    field.value === position ? "opacity-100" : "opacity-0"
                                  )}
                                />
                                {position}
                              </CommandItem>
                            ))}
                            <CommandItem
                              onSelect={() => {
                                setIsCustomJobType(true);
                                setCustomJobType("");
                                field.onChange("");
                              }}
                            >
                              <Plus className="mr-2 h-4 w-4" />
                              <span className="text-blue-600 font-medium">Add Custom Position</span>
                            </CommandItem>
                          </CommandGroup>
                        </Command>
                      </PopoverContent>
                    </Popover>
                  ) : (
                    <div className="relative">
                      <Input
                        placeholder="Enter your custom job position"
                        value={customJobType}
                        onChange={(e) => {
                          setCustomJobType(e.target.value);
                          field.onChange(e.target.value);
                        }}
                        className="text-gray-900 pr-20"
                        autoFocus
                      />
                      <Button
                        type="button"
                        variant="ghost"
                        size="sm"
                        onClick={() => {
                          setIsCustomJobType(false);
                          setCustomJobType("");
                          field.onChange("");
                        }}
                        className="absolute right-2 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
                      >
                        <X className="h-4 w-4" />
                      </Button>
                    </div>
                  )}

                  {!isCustomJobType && (
                    <div className="text-center">
                      <Button
                        type="button"
                        variant="ghost"
                        size="sm"
                        onClick={() => {
                          setIsCustomJobType(true);
                          setCustomJobType("");
                          field.onChange("");
                        }}
                        className="text-blue-600 hover:text-blue-700"
                      >
                        <Plus className="mr-2 h-4 w-4" />
                        Can't find your position? Add custom
                      </Button>
                    </div>
                  )}
                </div>
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="skills"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">
                Your top skills and tools
              </FormLabel>
              <div className="relative">
                <FormControl>
                  <Input
                    placeholder="Type a skill and press Enter"
                    value={currentSkill}
                    onChange={(e) => setCurrentSkill(e.target.value)}
                    onKeyDown={handleKeyDown}
                    className="text-gray-900 pr-20"
                  />
                </FormControl>
                <div className="absolute right-2 top-1/2 -translate-y-1/2 flex items-center gap-2">
                  <span className="text-xs text-gray-400 font-medium">
                    Press Enter ↵
                  </span>
                </div>
              </div>
              <div className="flex flex-wrap gap-2 mt-2">
                {skills.map((skill) => (
                  <div
                    key={skill}
                    className="flex items-center bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded"
                  >
                    {skill}
                    <button
                      type="button"
                      onClick={() => removeSkill(skill)}
                      className="ml-1 text-blue-600 hover:text-blue-800"
                    >
                      <X size={14} />
                    </button>
                  </div>
                ))}
              </div>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="experience"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">
                How much work experience do you have?
              </FormLabel>
              <Select onValueChange={field.onChange} defaultValue={field.value}>
                <FormControl>
                  <SelectTrigger className="text-gray-900">
                    <SelectValue placeholder="Select your Experience" />
                  </SelectTrigger>
                </FormControl>
                <SelectContent>
                  <SelectItem value="0-1">0-1 years</SelectItem>
                  <SelectItem value="1-3">1-3 years</SelectItem>
                  <SelectItem value="3-5">3-5 years</SelectItem>
                  <SelectItem value="5+">5+ years</SelectItem>
                </SelectContent>
              </Select>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="education"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">
                Highest level of education
              </FormLabel>
              <Select onValueChange={field.onChange} defaultValue={field.value}>
                <FormControl>
                  <SelectTrigger className="text-gray-900">
                    <SelectValue placeholder="Select education level" />
                  </SelectTrigger>
                </FormControl>
                <SelectContent>
                  <SelectItem value="highschool">High School</SelectItem>
                  <SelectItem value="associates">Associate's Degree</SelectItem>
                  <SelectItem value="bachelors">Bachelor's</SelectItem>
                  <SelectItem value="masters">Master's</SelectItem>
                  <SelectItem value="phd">PhD</SelectItem>
                </SelectContent>
              </Select>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="degree"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">Degree</FormLabel>
              <FormControl>
                <Input
                  placeholder="Enter your degree"
                  {...field}
                  className="text-gray-900"
                />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />


        <Button
          type="submit"
          className="w-full bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white hover:opacity-90"
          disabled={isLoading || pending}
        >
          {isLoading || pending ? "Please wait..." : "Submit"}
        </Button>
      </form>
    </Form>
  );
};

export default CandidateProfessionalInfoForm;
