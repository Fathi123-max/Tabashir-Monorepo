interface StepNavigationProps {
  currentStep: number
}

export default function StepNavigation({ currentStep }: StepNavigationProps) {
  const steps = [
    { id: 1, name: "About" },
    { id: 2, name: "Details" },
    { id: 3, name: "Application" },
    { id: 4, name: "Preview" },
  ]

  return (
    <div className="flex flex-col space-y-1">
      {steps.map((step) => (
        <div
          key={step.id}
          className={`flex items-center p-4 border-l-2 ${
            currentStep === step.id ? "border-blue-500" : currentStep > step.id ? "border-green-500" : "border-gray-200"
          }`}
        >
          <div
            className={`flex items-center justify-center w-6 h-6 rounded-full mr-3 ${
              currentStep === step.id
                ? "blue-gradient text-white"
                : currentStep > step.id
                  ? "bg-green-500 text-white"
                  : "bg-gray-200 text-gray-700"
            }`}
          >
            {step.id}
          </div>
          <span className={`text-sm ${currentStep === step.id ? "font-medium text-blue-900" : "text-gray-700"}`}>
            {step.name}
          </span>
        </div>
      ))}
    </div>
  )
}
