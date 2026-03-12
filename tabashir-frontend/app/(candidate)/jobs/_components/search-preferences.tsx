"use client"

import { useState } from "react"
import { ChevronDown, Search } from "lucide-react"
import { useTranslation } from "@/lib/use-translation"

interface SearchPreferencesProps {
  location: string
  jobType: string
  salaryMin: string
  salaryMax: string
  experience: string
  attendance: string
  onFilterChange: (filters: {
    location?: string
    jobType?: string
    salaryMin?: string
    salaryMax?: string
    experience?: string
    attendance?: string
    sort?: string
  }) => void
}

export function SearchPreferences({
  location,
  jobType,
  salaryMin,
  salaryMax,
  experience,
  attendance,
  onFilterChange
}: SearchPreferencesProps) {
  const { t, isRTL } = useTranslation()

  const LOCATIONS = [
    { key: "Dubai, UAE", label: t("Dubai, UAE") },
    { key: "Abu Dhabi, UAE", label: t("Abu Dhabi, UAE") },
    { key: "Sharjah, UAE", label: t("Sharjah, UAE") },
    { key: "Ras Al Khaimah, UAE", label: t("Ras Al Khaimah, UAE") },
    { key: "Fujairah, UAE", label: t("Fujairah, UAE") },
    { key: "Ajman, UAE", label: t("Ajman, UAE") },
    { key: "Umm Al Quwain, UAE", label: t("Umm Al Quwain, UAE") },
    { key: "Al Ain, UAE", label: t("Al Ain, UAE") }
  ]
  const JOB_TYPES = [
    { key: "fulltime", label: t("fullTime") },
    { key: "parttime", label: t("partTime") },
    { key: "contract", label: t("contract") },
    { key: "freelance", label: t("freelance") }
  ]
  const ATTENDANCE_TYPES = [
    { key: "hybrid", label: t("hybrid") },
    { key: "onsite", label: t("onsite") },
    { key: "remote", label: t("remote") }
  ]

  // For the salary slider, keep local state for UI, but sync with parent on change
  const [salaryRange, setSalaryRange] = useState([
    Number(salaryMin) || 12000,
    Number(salaryMax) || 50000
  ])

  // Handle salary slider change
  const handleSalaryChange = (e: React.ChangeEvent<HTMLInputElement>, idx: 0 | 1) => {
    const newRange = [...salaryRange] as [number, number]
    newRange[idx] = Number(e.target.value)
    setSalaryRange(newRange)
    onFilterChange(idx === 0 ? { salaryMin: e.target.value } : { salaryMax: e.target.value })
  }

  return (
    <div className={`space-y-6 px-5 py-6 ${isRTL ? 'text-right' : ''}`}>
      <div>
        <h2 className={`text-base font-semibold mb-1 flex items-center gap-2 text-gray-900 ${isRTL ? 'flex-row-reverse' : ''}`}>
          <Search size={18} />
          {t("searchPreferences")}
        </h2>
        <p className="text-xs text-gray-500">{t("filterJobsChoice")}</p>
      </div>

      {/* Location */}
      <div>
        <div className={`flex items-center gap-2 mb-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
          <div className="w-5 h-5 rounded-full border border-gray-300 flex items-center justify-center">
            <span className="text-xs">📍</span>
          </div>
          <label className="text-sm font-medium text-gray-700">{t("location")}</label>
        </div>
        <div className="relative">
          <select
            className={`w-full p-2 border border-gray-300 rounded-md pr-8 text-sm appearance-none text-gray-700 ${isRTL ? 'text-right' : ''}`}
            value={location}
            onChange={e => onFilterChange({ location: e.target.value })}
          >
            <option value="">{t("selectLocation")}</option>
            {LOCATIONS.map(loc => (
              <option key={loc.key} value={loc.key}>{loc.label}</option>
            ))}
          </select>
          <ChevronDown className={`absolute ${isRTL ? 'left-2' : 'right-2'} top-1/2 -translate-y-1/2 text-gray-500 pointer-events-none`} size={16} />
        </div>
      </div>

      {/* Job Type */}
      <div>
        <div className={`flex items-center gap-2 mb-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
          <div className="w-5 h-5 rounded-full border border-gray-300 flex items-center justify-center">
            <span className="text-xs">💼</span>
          </div>
          <label className="text-sm font-medium text-gray-700">{t("jobType")}</label>
        </div>
        <div className="relative">
          <select
            className={`w-full p-2 border border-gray-300 rounded-md pr-8 text-sm appearance-none text-gray-700 ${isRTL ? 'text-right' : ''}`}
            value={jobType}
            onChange={e => onFilterChange({ jobType: e.target.value })}
          >
            <option value="">{t("selectJobType")}</option>
            {JOB_TYPES.map(type => (
              <option key={type.key} value={type.label}>{type.label}</option>
            ))}
          </select>
          <ChevronDown className={`absolute ${isRTL ? 'left-2' : 'right-2'} top-1/2 -translate-y-1/2 text-gray-500 pointer-events-none`} size={16} />
        </div>
      </div>

      {/* Experience Level */}
      <div>
        <div className={`flex items-center gap-2 mb-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
          <div className="w-5 h-5 rounded-full border border-gray-300 flex items-center justify-center">
            <span className="text-xs">📈</span>
          </div>
          <label className="text-sm font-medium text-gray-700">{t("experienceLevel")}</label>
        </div>
        <input
          type="text"
          placeholder={t("yearsExperience")}
          className={`w-full p-2 border border-gray-300 rounded-md text-sm text-gray-700 ${isRTL ? 'text-right' : ''}`}
          value={experience}
          onChange={e => onFilterChange({ experience: e.target.value })}
        />
      </div>

      {/* Attendance */}
      <div>
        <div className={`flex items-center gap-2 mb-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
          <div className="w-5 h-5 rounded-full border border-gray-300 flex items-center justify-center">
            <span className="text-xs">🏢</span>
          </div>
          <label className="text-sm font-medium text-gray-700">{t("attendance")}</label>
        </div>
        <div className={`flex gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
          {ATTENDANCE_TYPES.map(type => (
            <button
              key={type.key}
              className={`px-3 py-1 text-xs rounded-full border transition-colors ${attendance === type.label ? "bg-blue-500 text-white border-blue-500" : "bg-gray-200 text-gray-700 border-gray-200"}`}
              onClick={e => {
                e.preventDefault();
                onFilterChange({ attendance: attendance === type.label ? "" : type.label })
              }}
              type="button"
            >
              {type.label}
            </button>
          ))}
        </div>
      </div>

      {/* Salary */}
      <div>
        <div className={`flex items-center gap-2 mb-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
          <div className="w-5 h-5 rounded-full border border-gray-300 flex items-center justify-center">
            <span className="text-xs">💰</span>
          </div>
          <label className="text-sm font-medium text-gray-700">{t("salary")}</label>
        </div>
        <div className={`flex items-center justify-between mb-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
          <div className="text-xs font-semibold text-blue-700 bg-blue-100 px-3 py-1 rounded-full">
            {t("aed")} {salaryRange[1].toLocaleString()}
          </div>
        </div>
        <div className={`flex items-center gap-2 mb-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
          <input
            type="range"
            min={100}
            max={50000}
            step={1000}
            value={salaryRange[0]}
            onChange={e => handleSalaryChange(e, 0)}
            className="w-full accent-blue-500"
          />
          <input
            type="range"
            min={100}
            max={50000}
            step={1000}
            value={salaryRange[1]}
            onChange={e => handleSalaryChange(e, 1)}
            className="w-full accent-blue-500"
          />
        </div>
        <div className={`flex justify-between ${isRTL ? 'flex-row-reverse' : ''}`}>
          <div className="border border-gray-300 rounded-md px-2 py-1 text-sm w-[45%] text-gray-700 bg-white">
            {t("aed")} {salaryRange[0].toLocaleString()}
          </div>
          <div className="border border-gray-300 rounded-md px-2 py-1 text-sm w-[45%] text-gray-700 bg-white">
            {t("aed")} {salaryRange[1].toLocaleString()}
          </div>
        </div>
      </div>
    </div>
  )
}
