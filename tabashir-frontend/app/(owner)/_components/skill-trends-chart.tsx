"use client"

import { XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Area, AreaChart } from "recharts"

const data = [
  { name: "Jan", value: 2000 },
  { name: "Feb", value: 3000 },
  { name: "Mar", value: 2500 },
  { name: "Apr", value: 4000 },
  { name: "May", value: 3000 },
  { name: "Jun", value: 3500 },
  { name: "Jul", value: 4000 },
  { name: "Aug", value: 3500 },
  { name: "Sep", value: 4500 },
  { name: "Oct", value: 4000 },
  { name: "Nov", value: 5000 },
  { name: "Dec", value: 4500 },
]

export default function SkillTrendsChart() {
  return (
    <div className="h-64">
      <div className="flex justify-between items-center mb-4">
        <div>
          <p className="text-sm text-gray-500">Frequency</p>
        </div>
      </div>
      <ResponsiveContainer width="100%" height="80%">
        <AreaChart
          data={data}
          margin={{
            top: 5,
            right: 30,
            left: 20,
            bottom: 5,
          }}
        >
          <defs>
            <linearGradient id="colorValue" x1="0" y1="0" x2="0" y2="1">
              <stop offset="5%" stopColor="#3B82F6" stopOpacity={0.3} />
              <stop offset="95%" stopColor="#3B82F6" stopOpacity={0} />
            </linearGradient>
          </defs>
          <CartesianGrid strokeDasharray="3 3" vertical={false} />
          <XAxis dataKey="name" axisLine={false} tickLine={false} />
          <YAxis axisLine={false} tickLine={false} />
          <Tooltip />
          <Area
            type="monotone"
            dataKey="value"
            stroke="#3B82F6"
            fillOpacity={1}
            fill="url(#colorValue)"
            dot={{ stroke: "#3B82F6", strokeWidth: 2, r: 4, fill: "#fff" }}
          />
        </AreaChart>
      </ResponsiveContainer>
      <div className="text-center text-sm text-gray-500">
        <p>Months</p>
      </div>
    </div>
  )
}
