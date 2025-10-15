-- Check if multilingual columns exist and if they have data
-- Run this in Supabase SQL Editor to verify your setup

-- 1. Check if columns exist
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'questions' 
AND column_name IN ('prompt', 'prompt_en', 'prompt_tr', 'meta', 'meta_en', 'meta_tr')
ORDER BY column_name;

-- 2. Check how many questions have translations
SELECT 
  COUNT(*) as total_questions,
  COUNT(prompt_en) as has_english,
  COUNT(prompt_tr) as has_turkish,
  ROUND(COUNT(prompt_en)::numeric / COUNT(*)::numeric * 100, 1) as english_percentage,
  ROUND(COUNT(prompt_tr)::numeric / COUNT(*)::numeric * 100, 1) as turkish_percentage
FROM public.questions;

-- 3. Show sample questions with their translations
SELECT 
  LEFT(prompt, 50) as norwegian_question,
  CASE 
    WHEN prompt_en IS NOT NULL THEN '✅ Has English'
    ELSE '❌ Missing'
  END as english_status,
  CASE 
    WHEN prompt_tr IS NOT NULL THEN '✅ Has Turkish'
    ELSE '❌ Missing'
  END as turkish_status
FROM public.questions
LIMIT 10;

-- 4. Find questions missing translations
SELECT 
  id,
  LEFT(prompt, 60) as question,
  CASE WHEN prompt_en IS NULL THEN '❌ Missing EN' ELSE '✅ Has EN' END as english,
  CASE WHEN prompt_tr IS NULL THEN '❌ Missing TR' ELSE '✅ Has TR' END as turkish
FROM public.questions
WHERE prompt_en IS NULL OR prompt_tr IS NULL
LIMIT 20;

