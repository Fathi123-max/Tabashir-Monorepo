import { create } from "zustand"
import { persist } from "zustand/middleware"

export type ResumeSection =
  | "personal-details"
  | "professional-summary"
  | "employment-history"
  | "education"
  | "skills"

interface ResumeStore {
  resumeId: string | null
  completedForms: Record<ResumeSection, boolean>
  isResumeGenerated: boolean
  isPaymentCompleted: boolean
  isSidebarVisible: boolean
  resumeScore: number
  editorMode: boolean

  setResumeId: (id: string) => void
  setFormCompleted: (section: ResumeSection) => void
  resetForms: () => void
  isFormCompleted: (section: ResumeSection) => boolean
  areAllFormsCompleted: () => boolean
  setResumeGenerated: (status: boolean) => void
  setPaymentCompleted: (status: boolean) => void
  getResumeScore: () => number
  setResumeScore: (score: number) => void
  setSidebarVisibility: (isVisible: boolean) => void
  setEditorMode: (mode: boolean) => void
}

export const useResumeStore = create<ResumeStore>()(
  persist(
    (set, get) => ({
      resumeId: null,
      completedForms: {
        "personal-details": false,
        "professional-summary": false,
        "employment-history": false,
        education: false,
        skills: false,
      },
      isResumeGenerated: false,
      isPaymentCompleted: false,
      isSidebarVisible: true,
      resumeScore: 0,
      editorMode: true,

      setResumeId: (id) => set({ resumeId: id }),

      setFormCompleted: (section) =>
        set((state) => ({
          completedForms: {
            ...state.completedForms,
            [section]: true,
          },
        })),

      resetForms: () =>
        set({
          completedForms: {
            "personal-details": false,
            "professional-summary": false,
            "employment-history": false,
            education: false,
            skills: false,
          },
          isResumeGenerated: false,
          isPaymentCompleted: false,
          resumeScore: 0,
        }),

      isFormCompleted: (section) => get().completedForms[section],

      areAllFormsCompleted: () => {
        const { completedForms } = get()
        return Object.values(completedForms).every(Boolean)
      },

      setResumeGenerated: (status) => set({ isResumeGenerated: status }),

      setPaymentCompleted: (status) => set({ isPaymentCompleted: status }),

      setResumeScore: (score) => set({ resumeScore: score }),

      getResumeScore: () => {
        const { resumeScore, completedForms, isResumeGenerated, isPaymentCompleted } = get()
        
        // If we have a stored score, use that
        if (resumeScore > 0) {
          return resumeScore
        }

        // Otherwise calculate it
        const totalSections = Object.keys(completedForms).length
        const completedSections = Object.values(completedForms).filter(Boolean).length
        const formCompletionPercentage = totalSections > 0 ? (completedSections / totalSections) * 60 : 0

        // Add 20% if resume is generated
        const generationScore = isResumeGenerated ? 20 : 0

        // Add 20% if payment is completed
        const paymentScore = isPaymentCompleted ? 20 : 0

        // Calculate total score
        return Math.round(formCompletionPercentage + generationScore + paymentScore)
      },

      setSidebarVisibility: (isVisible) => set({ isSidebarVisible: isVisible }),

      setEditorMode: (mode) => set({ editorMode: mode }),
    }),
    {
      name: "resume-store",
    },
  ),
)
