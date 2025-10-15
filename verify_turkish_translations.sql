-- Verify Turkish translations exist in the database
-- Run this in Supabase SQL Editor

-- 1. Check if prompt_tr column exists
SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'questions' 
AND column_name = 'prompt_tr';

-- 2. Count questions with Turkish translations
SELECT 
  COUNT(*) as total_questions,
  COUNT(prompt_tr) as has_turkish_prompt,
  COUNT(meta_tr) as has_turkish_meta
FROM public.questions;

-- 3. Show first 5 questions with their Turkish status
SELECT 
  id,
  LEFT(prompt, 40) as norwegian,
  LEFT(prompt_tr, 40) as turkish,
  CASE 
    WHEN prompt_tr IS NULL THEN '❌ MISSING'
    WHEN prompt_tr = '' THEN '❌ EMPTY'
    ELSE '✅ OK'
  END as status
FROM public.questions
ORDER BY order_index
LIMIT 10;

-- 4. Find questions WITHOUT Turkish translations
SELECT 
  COUNT(*) as missing_turkish_count
FROM public.questions
WHERE prompt_tr IS NULL OR prompt_tr = '';

