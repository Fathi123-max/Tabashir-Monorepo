"use client"

import { useState, useEffect } from "react"
import { ChevronDown, DivideCircleIcon } from "lucide-react"
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from "recharts"
import { useTranslation } from "@/lib/use-translation"

interface SkillTrendsChartProps {
  jobTitle: string
  skills: string[]
}

interface ApiResponse {
  success: boolean
  data: {
    month: string
    count: number
  }[]
}

interface ChartData {
  name: string
  value: number
}

export function SkillTrendsChart({ jobTitle, skills }: SkillTrendsChartProps) {
  const [selectedSkill, setSelectedSkill] = useState(jobTitle)
  const [chartData, setChartData] = useState<ChartData[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const { t, isRTL } = useTranslation()
  const token = process.env.NEXT_PUBLIC_API_TOKEN;
  const formatMonthName = (monthString: string): string => {
    const date = new Date(monthString + "-01")
    return date.toLocaleDateString('en-US', { month: 'short' })
  }

  const fetchData = async (keyword: string) => {
    try {
      setLoading(true)
      setError(null)

      const response = await fetch(`https://backend.tabashir.ae/api/v1/resume/jobs/monthly-count?keyword=${encodeURIComponent(keyword)}`, {
        headers: {
          "X-API-TOKEN": `${token}`,
        },
      })

      if (!response.ok) {
        throw new Error('Failed to fetch data')
      }

      const apiData: ApiResponse = await response.json()

      if (apiData.success && apiData.data) {
        const transformedData: ChartData[] = apiData.data.map(item => ({
          name: formatMonthName(item.month),
          value: item.count
        }))
        setChartData(transformedData)
      } else {
        throw new Error('Invalid API response')
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred')
      console.error('Error fetching skill trends data:', err)
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    if (jobTitle) {
      fetchData(jobTitle)
    }
  }, [jobTitle])

  useEffect(() => {
    if (selectedSkill) {
      fetchData(selectedSkill)
    }
  }, [selectedSkill])

  return (
    <div className={isRTL ? 'text-right' : ''}>
      <div className={`flex justify-between items-center mb-6 ${isRTL ? 'flex-row-reverse' : ''}`}>
        <h2 className="text-xl font-medium text-gray-800">{t('skillTrends')}</h2>
        <select
          name=""
          id=""
          className={`border rounded-md px-3 py-1.5 text-sm cursor-pointer bg-white appearance-none pr-8 ${isRTL ? 'text-right' : ''}`}
          onChange={(e) => setSelectedSkill(e.target.value)}
        >
          {skills.map((skill) => (
            <option key={skill} value={skill}>{skill}</option>
          ))}
        </select>
      </div>

      <div className="h-64">
        {loading ? (
          <div className="flex items-center justify-center h-full">
            <div className="text-gray-500">{t('loading')}</div>
          </div>
        ) : error ? (
          <div className="flex items-center justify-center h-full">
            <div className="text-red-500">{t('error')}: {error}</div>
          </div>
        ) : (
          <ResponsiveContainer width="100%" height="100%">
            <LineChart data={chartData}>
              <CartesianGrid strokeDasharray="3 3" vertical={false} />
              <XAxis dataKey="name" axisLine={false} tickLine={false} tick={{ fontSize: 12 }} />
              <YAxis
                axisLine={false}
                tickLine={false}
                tick={{ fontSize: 12 }}
                domain={[0, 'dataMax']}
              />
              <Tooltip />
              <Line
                type="monotone"
                dataKey="value"
                stroke="#4285F4"
                strokeWidth={2}
                dot={{ r: 4, fill: "#4285F4" }}
                activeDot={{ r: 6 }}
              />
            </LineChart>
          </ResponsiveContainer>
        )}
      </div>
    </div>
  )
}
