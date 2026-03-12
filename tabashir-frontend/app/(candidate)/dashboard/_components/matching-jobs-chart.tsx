"use client"

import { PieChart, Pie, Cell, ResponsiveContainer } from "recharts"
import { useTranslation } from "@/lib/use-translation"

export function MatchingJobsChart() {
  const { t, isRTL } = useTranslation()

  const data = [
    { name: t("onsite"), value: 372, color: "#FF6384" },
    { name: t("hybrid"), value: 250, color: "#36A2EB" },
    { name: t("remote"), value: 64, color: "#4BC0C0" },
    { name: t("flexible"), value: 50, color: "#FFCE56" },
  ]

  const total = data.reduce((sum, item) => sum + item.value, 0)

  return (
    <div className="relative flex flex-col">
      {/* Blurred Content */}
      <div className="filter blur-sm">
        <div className={`flex justify-between items-center mb-4 ${isRTL ? 'flex-row-reverse' : ''}`}>
          <h2 className="text-xl font-medium text-gray-700">{t('totalMatchingJobs')}</h2>
          <div className="text-2xl font-bold">{total}</div>
        </div>

        <div className={`flex items-center text-black ${isRTL ? 'flex-row-reverse' : ''}`}>
          <div className="h-48 w-48">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={data}
                  cx="50%"
                  cy="50%"
                  innerRadius={40}
                  outerRadius={60}
                  paddingAngle={2}
                  dataKey="value"
                  startAngle={90}
                  endAngle={-270}
                >
                  {data.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.color} />
                  ))}
                </Pie>
              </PieChart>
            </ResponsiveContainer>
          </div>

          <div className={`${isRTL ? 'mr-4' : 'ml-4'} space-y-2`}>
            {data.map((item) => (
              <div key={item.name} className={`flex items-center gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
                <div className={`flex items-center gap-1.5 ${isRTL ? 'flex-row-reverse' : ''}`}>
                  <div className="w-2 h-2 rounded-full" style={{ backgroundColor: item.color }} />
                  <div className="text-sm text-gray-600">{item.name}</div>
                </div>
                <div className={`text-sm font-medium ${isRTL ? 'mr-auto' : 'ml-auto'}`}>{item.value}</div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Coming Soon Overlay */}
      <div className="absolute inset-0 bg-black/20 backdrop-blur-sm flex items-center justify-center rounded-lg pointer-events-none">
        <div className="bg-gradient-to-r from-blue-500 to-purple-600 text-white px-6 py-3 rounded-full shadow-lg">
          <span className="text-sm font-semibold">🚀 {t('comingSoon')}</span>
        </div>
      </div>
    </div>
  )
}
