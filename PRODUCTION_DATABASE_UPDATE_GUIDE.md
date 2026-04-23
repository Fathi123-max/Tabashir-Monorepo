# 🚀 Guide: Updating the Tabashir Production Database

This guide explains how to add two missing fields (**Location** and **LinkedIn**) to the production database safely.

### ⏱️ Time Required
Less than 2 minutes. This change is **safe**: it will not delete or modify any existing data.

---

### Step 1: Copy the Update Script
Copy the entire block of code below exactly as it is:

```sql
-- TABASHIR DATABASE UPDATE
-- Adds 'location' and 'linkedin' fields to the CandidateProfile table

DO $$ 
BEGIN 
    -- 1. Add 'location' if it doesn't exist
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name='CandidateProfile' AND column_name='location'
    ) THEN 
        ALTER TABLE "CandidateProfile" ADD COLUMN "location" TEXT;
    END IF;

    -- 2. Add 'linkedin' if it doesn't exist
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name='CandidateProfile' AND column_name='linkedin'
    ) THEN 
        ALTER TABLE "CandidateProfile" ADD COLUMN "linkedin" TEXT;
    END IF;
END $$;
```

---

### Step 2: Run the Script
1.  Log in to your **Neon.tech Console**.
2.  Select the **Tabashir** project.
3.  Click on **"SQL Editor"** in the left-hand menu.
4.  **Paste** the code you copied above into the editor.
5.  Click the **"Run"** button.

---

### Step 3: Success!
You should see a message saying "Query returned successfully." 

**Note:** If you run this script more than once, it will simply do nothing (it checks for the columns first), so it is 100% safe.

---
*Created on 2026-04-23 to fix Mobile Login issues.*
