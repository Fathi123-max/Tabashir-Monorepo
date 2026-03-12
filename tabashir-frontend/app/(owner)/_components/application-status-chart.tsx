"use client"

import { PieChart, Pie, Cell, ResponsiveContainer } from "recharts"

interface ChartData {
  name: string
  value: number
  color: string
}

interface ApplicationStatusChartProps {
  data: ChartData[]
}

export default function ApplicationStatusChart({ data }: ApplicationStatusChartProps) {
  return (
    <div className="flex flex-col md:flex-row items-center">
      <div className="w-full md:w-1/2 h-64">
        <ResponsiveContainer width="100%" height="100%">
          <PieChart>
            <Pie
              data={data}
              cx="50%"
              cy="50%"
              innerRadius={60}
              outerRadius={80}
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
      <div className="w-full md:w-1/2">
        {data.map((entry, index) => (
          <div key={index} className="flex items-center justify-between mb-2">
            <div className="flex items-center">
              <div className="w-2 h-2 rounded-full mr-2" style={{ backgroundColor: entry.color }}></div>
              <span className="text-sm text-gray-700">{entry.name}</span>
            </div>
            <span className="font-medium text-gray-900">{entry.value}</span>
          </div>
        ))}
      </div>
    </div>
  )
}
