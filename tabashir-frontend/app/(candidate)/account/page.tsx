"use client"

import { useState, useEffect } from "react"
import { Pencil, Check, X, Eye, EyeOff } from "lucide-react"
import { Badge } from "@/components/ui/badge"
import { Card, CardHeader, CardContent } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { getUserProfile, updateUserProfile, updatePassword } from "./actions"
import { toast } from "sonner"
import { useTranslation } from "@/lib/use-translation"

const GENDER_OPTIONS = [
  { value: "male", label: "male" },
  { value: "female", label: "female" },
  { value: "other", label: "other" },
]

const EXPERIENCE_OPTIONS = [
  { value: "0-1", label: "zeroToOne" },
  { value: "1-3", label: "oneToThree" },
  { value: "3-5", label: "threeToFive" },
  { value: "5-10", label: "fiveToTen" },
  { value: "10+", label: "tenPlus" },
]

const EDUCATION_OPTIONS = [
  { value: "high_school", label: "highSchool" },
  { value: "bachelors", label: "bachelors" },
  { value: "masters", label: "masters" },
  { value: "phd", label: "phd" },
  { value: "other", label: "other" },
]

export default function AccountPage() {
  const [userData, setUserData] = useState<any>(null)
  const [loading, setLoading] = useState(true)
  const [skills, setSkills] = useState<string[]>([])
  const [newSkill, setNewSkill] = useState("")
  const [editingField, setEditingField] = useState<string | null>(null)
  const [editValue, setEditValue] = useState("")
  const [showPassword, setShowPassword] = useState(false)
  const [newPassword, setNewPassword] = useState("")
  const [confirmPassword, setConfirmPassword] = useState("")
  const [isChangingPassword, setIsChangingPassword] = useState(false)
  const { t, isRTL } = useTranslation()

  useEffect(() => {
    const fetchUserData = async () => {
      try {
        const data = await getUserProfile()
        setUserData(data)
        if (data?.candidate?.profile?.skills) {
          const skillsString = Array.isArray(data.candidate.profile.skills)
            ? data.candidate.profile.skills.join(', ')
            : data.candidate.profile.skills
          setSkills(
            skillsString
              .split(',')
              .map((skill: string) => skill.trim())
              .filter(Boolean),
          )
        }
      } catch (error) {
        console.error('Error fetching user data:', error)
        toast.error(t('error'), {
          description: t('somethingWentWrong')
        })
      } finally {
        setLoading(false)
      }
    }

    fetchUserData()
  }, [t])

  const handleEdit = (field: string, currentValue: string) => {
    setEditingField(field)
    setEditValue(currentValue || "")
  }

  const handleSave = async (field: string) => {
    try {
      const updateData = { [field]: editValue }

      if (field === 'skills') {
        updateData.skills = skills.join(', ')
      }

      const result = await updateUserProfile(updateData)

      if (result.success) {
        setUserData({ ...userData, [field]: editValue })
        setEditingField(null)
        toast.success(t('success'), {
          description: t('profileUpdated')
        })
      } else {
        toast.error(t('error'), {
          description: result.message || t('somethingWentWrong')
        })
      }
    } catch (error) {
      console.error('Error updating profile:', error)
      toast.error(t('error'), {
        description: t('somethingWentWrong')
      })
    }
  }

  const handleCancel = () => {
    setEditingField(null)
    setEditValue("")
  }

  const addSkill = () => {
    if (newSkill.trim() && !skills.includes(newSkill.trim())) {
      const updatedSkills = [...skills, newSkill.trim()]
      setSkills(updatedSkills)
      setNewSkill("")
    }
  }

  const removeSkill = (skillToRemove: string) => {
    setSkills(skills.filter(skill => skill !== skillToRemove))
  }

  const handlePasswordChange = async () => {
    if (newPassword !== confirmPassword) {
      toast.error(t('error'), {
        description: t('passwordsDoNotMatch')
      })
      return
    }

    if (newPassword.length < 8) {
      toast.error(t('error'), {
        description: t('passwordTooShort')
      })
      return
    }

    setIsChangingPassword(true)

    try {
      const result = await updatePassword({ newPassword })

      if (result.success) {
        toast.success(t('success'), {
          description: t('passwordUpdated')
        })
        setNewPassword("")
        setConfirmPassword("")
        setShowPassword(false)
      } else {
        toast.error(t('error'), {
          description: result.message || t('somethingWentWrong')
        })
      }
    } catch (error) {
      console.error('Error updating password:', error)
      toast.error(t('error'), {
        description: t('somethingWentWrong')
      })
    } finally {
      setIsChangingPassword(false)
    }
  }

  const renderEditableField = (label: string, field: string, type = "text", options?: Array<{ value: string, label: string }>) => {
    const currentValue = userData?.[field] || ""
    const isEditing = editingField === field

    return (
      <div className={`space-y-2 ${isRTL ? 'text-right' : ''}`}>
        <label className="text-sm font-medium text-gray-700">{t(label)}</label>
        <div className={`flex items-center gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
          {isEditing ? (
            <>
              {options ? (
                <Select value={editValue} onValueChange={setEditValue}>
                  <SelectTrigger className="flex-1">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    {options.map((option) => (
                      <SelectItem key={option.value} value={option.value}>
                        {t(option.label)}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              ) : (
                <Input
                  type={type}
                  value={editValue}
                  onChange={(e) => setEditValue(e.target.value)}
                  className={`flex-1 ${isRTL ? 'text-right' : ''}`}
                />
              )}
              <button
                onClick={() => handleSave(field)}
                className="p-2 text-green-600 hover:bg-green-50 rounded"
              >
                <Check className="h-4 w-4" />
              </button>
              <button
                onClick={handleCancel}
                className="p-2 text-gray-500 hover:bg-gray-50 rounded"
              >
                <X className="h-4 w-4" />
              </button>
            </>
          ) : (
            <>
              <span className="flex-1 py-2">
                {options ?
                  t(options.find(opt => opt.value === currentValue)?.label || 'other') :
                  (currentValue || t('notSpecified'))
                }
              </span>
              <button
                onClick={() => handleEdit(field, currentValue)}
                className="p-2 text-blue-600 hover:bg-blue-50 rounded"
              >
                <Pencil className="h-4 w-4" />
              </button>
            </>
          )}
        </div>
      </div>
    )
  }

  if (loading) {
    return (
      <div className={`bg-white rounded-lg p-6 min-h-[calc(100vh-35px)] flex items-center justify-center ${isRTL ? 'text-right' : ''}`}>
        <p>{t('loading')}</p>
      </div>
    )
  }

  return (
    <div className={`bg-white rounded-lg p-6 min-h-[calc(100vh-35px)] space-y-6 ${isRTL ? 'text-right' : ''}`}>
      <h1 className="text-2xl font-bold text-gray-900">{t('account')}</h1>

      {/* Personal Details Section */}
      <Card>
        <CardHeader>
          <h2 className="text-lg font-semibold">{t('personalDetails')}</h2>
        </CardHeader>
        <CardContent className="space-y-4">
          {renderEditableField('firstName', 'firstName')}
          {renderEditableField('lastName', 'lastName')}
          {renderEditableField('email', 'email', 'email')}
          {renderEditableField('phone', 'phone', 'tel')}
          {renderEditableField('gender', 'gender', 'text', GENDER_OPTIONS)}
        </CardContent>
      </Card>

      {/* Contact Information */}
      <Card>
        <CardHeader>
          <h2 className="text-lg font-semibold">{t('contactInformation')}</h2>
        </CardHeader>
        <CardContent className="space-y-4">
          {renderEditableField('address', 'address')}
          {renderEditableField('city', 'city')}
          {renderEditableField('country', 'country')}
        </CardContent>
      </Card>

      {/* Professional Information */}
      <Card>
        <CardHeader>
          <h2 className="text-lg font-semibold">{t('professionalInformation')}</h2>
        </CardHeader>
        <CardContent className="space-y-4">
          {renderEditableField('experienceLevel', 'experience', 'text', EXPERIENCE_OPTIONS)}
          {renderEditableField('educationLevel', 'education', 'text', EDUCATION_OPTIONS)}

          {/* Skills Section */}
          <div className={`space-y-2 ${isRTL ? 'text-right' : ''}`}>
            <label className="text-sm font-medium text-gray-700">{t('skills')}</label>
            <div className={`flex gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
              <Input
                value={newSkill}
                onChange={(e) => setNewSkill(e.target.value)}
                placeholder={t('addSkill')}
                className={`flex-1 ${isRTL ? 'text-right' : ''}`}
                onKeyPress={(e) => e.key === 'Enter' && addSkill()}
              />
              <button
                onClick={addSkill}
                className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
              >
                {t('add')}
              </button>
            </div>
            <div className={`flex flex-wrap gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
              {skills.map((skill) => (
                <Badge
                  key={skill}
                  variant="secondary"
                  className="cursor-pointer hover:bg-red-100"
                  onClick={() => removeSkill(skill)}
                >
                  {skill} ×
                </Badge>
              ))}
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Password Change Section */}
      <Card>
        <CardHeader>
          <h2 className="text-lg font-semibold">{t('changePassword')}</h2>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className={`space-y-2 ${isRTL ? 'text-right' : ''}`}>
            <label className="text-sm font-medium text-gray-700">{t('newPassword')}</label>
            <div className="relative">
              <Input
                type={showPassword ? "text" : "password"}
                value={newPassword}
                onChange={(e) => setNewPassword(e.target.value)}
                placeholder={t('enterNewPassword')}
                className={isRTL ? 'text-right pr-10' : 'pr-10'}
              />
              <button
                type="button"
                onClick={() => setShowPassword(!showPassword)}
                className={`absolute ${isRTL ? 'left-0' : 'right-0'} top-0 h-full px-3 py-2 text-gray-400 hover:text-gray-600`}
              >
                {showPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
              </button>
            </div>
          </div>

          <div className={`space-y-2 ${isRTL ? 'text-right' : ''}`}>
            <label className="text-sm font-medium text-gray-700">{t('confirmNewPassword')}</label>
            <Input
              type={showPassword ? "text" : "password"}
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              placeholder={t('confirmNewPassword')}
              className={isRTL ? 'text-right' : ''}
            />
          </div>

          <button
            onClick={handlePasswordChange}
            disabled={isChangingPassword || !newPassword || !confirmPassword}
            className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {isChangingPassword ? t('updating') : t('updatePassword')}
          </button>
        </CardContent>
      </Card>
    </div>
  )
}
