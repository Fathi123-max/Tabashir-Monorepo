-- Migration: Add missing columns to CandidateProfile
-- Aligns with Prisma schema: location String?, linkedin String?

DO $$ 
BEGIN 
    -- Add location
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name='CandidateProfile' 
        AND column_name='location'
    ) THEN 
        ALTER TABLE "CandidateProfile" ADD COLUMN "location" TEXT;
    END IF;

    -- Add linkedin
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name='CandidateProfile' 
        AND column_name='linkedin'
    ) THEN 
        ALTER TABLE "CandidateProfile" ADD COLUMN "linkedin" TEXT;
    END IF;
END $$;
