-- Migration: Add Arabic translation columns to jobs table
-- Date: 2024-01-15

-- Add Arabic columns for translatable fields
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS job_title_ar TEXT;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS job_description_ar TEXT;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS academic_qualification_ar TEXT;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS experience_ar TEXT;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS languages_ar TEXT;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS salary_ar TEXT;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS working_hours_ar TEXT;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS working_days_ar TEXT;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS company_name_ar TEXT;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS vacancy_city_ar TEXT;

-- Add translation status tracking
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS translation_status VARCHAR(20) DEFAULT 'pending';
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS translation_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Create index for translation status for faster queries
CREATE INDEX IF NOT EXISTS idx_jobs_translation_status ON jobs(translation_status);

-- Add comments for documentation
COMMENT ON COLUMN jobs.job_title_ar IS 'Arabic translation of job title';
COMMENT ON COLUMN jobs.job_description_ar IS 'Arabic translation of job description';
COMMENT ON COLUMN jobs.academic_qualification_ar IS 'Arabic translation of academic qualification';
COMMENT ON COLUMN jobs.experience_ar IS 'Arabic translation of experience requirements';
COMMENT ON COLUMN jobs.languages_ar IS 'Arabic translation of language requirements';
COMMENT ON COLUMN jobs.salary_ar IS 'Arabic translation of salary information';
COMMENT ON COLUMN jobs.working_hours_ar IS 'Arabic translation of working hours';
COMMENT ON COLUMN jobs.working_days_ar IS 'Arabic translation of working days';
COMMENT ON COLUMN jobs.company_name_ar IS 'Arabic translation of company name';
COMMENT ON COLUMN jobs.vacancy_city_ar IS 'Arabic translation of vacancy city';
COMMENT ON COLUMN jobs.translation_status IS 'Translation status: pending, completed, failed';
COMMENT ON COLUMN jobs.translation_updated_at IS 'Timestamp when translation was last updated';
