DO $$ 
BEGIN 
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name='CandidateProfile' 
        AND column_name='location'
    ) THEN 
        ALTER TABLE "CandidateProfile" ADD COLUMN "location" TEXT;
    END IF;
END $$;
