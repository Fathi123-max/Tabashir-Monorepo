import Image from "next/image"

interface MatchedJobCard {
  title: string
  company: string
  location: string
  salary: string
  gradient: string
  shadow: string
  logoUrl?: string
  image?: string
  tags?: string[]
  onApply?: () => void
}

export function MatchedJobCard({
  title,
  company,
  location,
  salary,
  gradient,
  shadow,
  logoUrl,
  image,
  tags = ["Onsite", "Internship"],
  onApply,
}: MatchedJobCard) {
  return (
    <div
      className="rounded-[29.63px] px-5 py-7 text-white flex flex-col justify-between relative overflow-hidden"
      style={{
        background: gradient,
        boxShadow: shadow,
      }}
    >
      <img src={image || "/placeholder.svg"} className="absolute left-0 bottom-0" />
      <div className="flex items-start justify-between relative z-10 mb-4">
        <div className="space-y-[6px]">
          <h3 className="font-medium text-md leading-none">{title.slice(0, 28) + (title.length > 28 ? "..." : "")}</h3>
          <div className="text-xs opacity-80">{company}</div>
        </div>

      </div>

      <div className="flex justify-between items-center relative z-10">
        <div className="flex gap-1 mt-2">
          {tags.map((tag, index) => (
            <span key={index} className="text-[10px] bg-white/20 px-2 py-0.5 rounded-full">
              {tag}
            </span>
          ))}
        </div>
        <button
          onClick={onApply}
          className="text-[11px] font-semibold bg-white py-[5px] leading-none px-[12px] text-[#5C5C5C] rounded-full text-center cursor-pointer transition-colors"
        >
          Apply
        </button>
      </div>

      <div className="flex justify-between items-center relative z-10 mt-1">
        <div className="text-xs">{salary.slice(0, 20) + (salary.length > 20 ? "..." : "")}</div>

        <div className="text-[10px] mt-1">{location.slice(0, 18) + (location.length > 18 ? "..." : "")}</div>
      </div>

    </div>
  )
}
