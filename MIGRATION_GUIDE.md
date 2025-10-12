# Database Migration Guide

## 📋 Overview

This guide will help you verify and apply the required database migrations for Relingo.

---

## Step 1: Verify Which Migrations Are Applied

### Option A: Quick Visual Check in Supabase Dashboard

1. Go to your **Supabase Dashboard**
2. Navigate to **Database** → **Tables**
3. Check if these tables exist:
   - ✅ `user_preferences`
   - ✅ `daily_xp_log`
   - ✅ `user_achievements`
4. Click on the `lessons` table
5. Check if these columns exist:
   - ✅ `title_key` (text)
   - ✅ `description_key` (text)

**If all tables and columns exist:** ✅ Migrations are already applied! You're done!

**If any are missing:** Continue to Step 2

---

### Option B: SQL Verification Query

1. Go to **Supabase Dashboard** → **SQL Editor**
2. Click **New Query**
3. Paste this verification query:

```sql
-- Check if tables exist
SELECT 
  CASE WHEN EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' 
    AND table_name = 'user_preferences'
  ) THEN '✅ user_preferences exists'
  ELSE '❌ user_preferences missing' END AS table_1,
  
  CASE WHEN EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' 
    AND table_name = 'daily_xp_log'
  ) THEN '✅ daily_xp_log exists'
  ELSE '❌ daily_xp_log missing' END AS table_2,
  
  CASE WHEN EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' 
    AND table_name = 'user_achievements'
  ) THEN '✅ user_achievements exists'
  ELSE '❌ user_achievements missing' END AS table_3;

-- Check if lesson columns exist
SELECT 
  CASE WHEN EXISTS (
    SELECT FROM information_schema.columns 
    WHERE table_name = 'lessons' 
    AND column_name = 'title_key'
  ) THEN '✅ title_key column exists'
  ELSE '❌ title_key column missing' END AS column_1,
  
  CASE WHEN EXISTS (
    SELECT FROM information_schema.columns 
    WHERE table_name = 'lessons' 
    AND column_name = 'description_key'
  ) THEN '✅ description_key column exists'
  ELSE '❌ description_key column missing' END AS column_2;
```

4. Click **Run** (or press `Ctrl+Enter` / `Cmd+Enter`)
5. Review the results:
   - ✅ = Already exists (good!)
   - ❌ = Missing (needs to be applied)

---

## Step 2: Apply Missing Migrations

### Migration 0010 - User Preferences and Tracking

**If the tables `user_preferences`, `daily_xp_log`, or `user_achievements` are missing:**

1. Go to **Supabase Dashboard** → **SQL Editor**
2. Click **New Query**
3. Copy the entire content of `supabase/migrations/0010_user_preferences_and_tracking.sql`
4. Paste it into the SQL Editor
5. Click **Run**
6. Wait for "Success" message
7. Check the **Results** panel for any errors

**Expected Result:** "Success. No rows returned"

---

### Migration 0012 - Lesson Translation Keys

**If the columns `title_key` or `description_key` are missing from the lessons table:**

1. Go to **Supabase Dashboard** → **SQL Editor**
2. Click **New Query**
3. Copy the entire content of `supabase/migrations/0012_add_lesson_translation_keys.sql`
4. Paste it into the SQL Editor
5. Click **Run**
6. Wait for "Success" message

**Expected Result:** "Success. No rows returned" or "ALTER TABLE" success message

---

## Step 3: Verify Migration Success

After applying the migrations, run the verification query from **Option B** again to confirm everything is set up correctly.

All checks should now show ✅!

---

## What Each Migration Does

### Migration 0010 - User Preferences and Tracking

**Creates:**
- `user_preferences` - Stores user settings (notifications, dark mode, language)
- `daily_xp_log` - Tracks daily XP for progress charts
- `user_achievements` - Records achievements and milestones

**Enables:**
- Settings page persistence
- Progress chart with real data
- Streak calendar functionality
- Export data feature
- Future achievements system

**Security:**
- Row Level Security (RLS) policies
- Users can only access their own data
- Automatic user preference creation on signup

---

### Migration 0012 - Lesson Translation Keys

**Creates:**
- `title_key` column in lessons table
- `description_key` column in lessons table

**Updates:**
- All existing lessons with i18n translation keys
- Enables proper multi-language support for lesson titles/descriptions

**Enables:**
- Dynamic lesson title translation
- Dynamic lesson description translation
- Better i18n support across all languages

---

## Troubleshooting

### Error: "relation already exists"
**Solution:** This means the migration was already partially applied. This is usually fine - the migration uses `IF NOT EXISTS` clauses.

### Error: "column already exists"
**Solution:** The column is already there. You can skip this part of the migration.

### Error: "permission denied"
**Solution:** Make sure you're running the query in the correct Supabase project and have admin access.

### Error: "syntax error"
**Solution:** 
- Make sure you copied the entire migration file
- Check that no characters were corrupted during copy/paste
- Try copying from the raw file in your code editor

---

## After Migrations Are Applied

### Test These Features:

1. **Settings Page**
   - Go to Profile → Settings (gear icon)
   - Toggle dark mode → should persist after refresh
   - Change language → UI should update
   - Toggle notifications → should save

2. **Progress Chart**
   - Complete a quiz/lesson
   - Go to Profile page
   - Check the weekly XP chart → should show today's XP

3. **Streak Calendar**
   - Complete a quiz/lesson
   - Go to Profile page
   - Check the calendar → today should be marked with a flame

4. **Export Data**
   - Go to Settings → Privacy section
   - Click "Eksporter data" → "Utfør"
   - JSON file should download with your data

---

## Database Backup (Recommended)

Before applying migrations to a production database, it's good practice to create a backup:

1. Go to **Supabase Dashboard** → **Database**
2. Click **Backups** (if available in your plan)
3. Or export important data manually

---

## Quick Reference

### File Locations
- Migration 0010: `supabase/migrations/0010_user_preferences_and_tracking.sql`
- Migration 0012: `supabase/migrations/0012_add_lesson_translation_keys.sql`

### Order of Operations
1. ✅ Verify current state (Step 1)
2. ✅ Apply Migration 0010 (if needed)
3. ✅ Apply Migration 0012 (if needed)
4. ✅ Verify success (Step 3)
5. ✅ Test features

---

## Need Help?

If you encounter issues:
1. Check the Supabase logs: Dashboard → Logs
2. Verify your Supabase project URL in `.env`
3. Make sure you're signed in as project owner
4. Try running migrations one statement at a time

---

**Last Updated:** October 12, 2025

Good luck! 🚀

