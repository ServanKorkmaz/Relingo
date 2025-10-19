-- Verification script to check if all questions have translations
-- Run this in Supabase SQL Editor AFTER running all translation migrations

-- Check for questions missing English translations
SELECT 
  'Missing English' as issue_type,
  q.id,
  l.slug as lesson_slug,
  q.type,
  q.prompt as norwegian_prompt,
  q.order_index
FROM public.questions q
JOIN public.quizzes qz ON q.quiz_id = qz.id
JOIN public.lessons l ON qz.lesson_id = l.id
WHERE q.prompt_en IS NULL OR q.meta_en IS NULL
ORDER BY l.slug, q.order_index;

-- Check for questions missing Turkish translations  
SELECT 
  'Missing Turkish' as issue_type,
  q.id,
  l.slug as lesson_slug,
  q.type,
  q.prompt as norwegian_prompt,
  q.order_index
FROM public.questions q
JOIN public.quizzes qz ON q.quiz_id = qz.id
JOIN public.lessons l ON qz.lesson_id = l.id
WHERE q.prompt_tr IS NULL OR q.meta_tr IS NULL
ORDER BY l.slug, q.order_index;

-- Summary: Count total questions and those with complete translations
SELECT 
  'Total Questions' as category,
  COUNT(*) as count
FROM public.questions

UNION ALL

SELECT 
  'With English Translation' as category,
  COUNT(*) as count
FROM public.questions
WHERE prompt_en IS NOT NULL AND meta_en IS NOT NULL

UNION ALL

SELECT 
  'With Turkish Translation' as category,
  COUNT(*) as count
FROM public.questions
WHERE prompt_tr IS NOT NULL AND meta_tr IS NOT NULL

UNION ALL

SELECT 
  'Missing English' as category,
  COUNT(*) as count
FROM public.questions
WHERE prompt_en IS NULL OR meta_en IS NULL

UNION ALL

SELECT 
  'Missing Turkish' as category,
  COUNT(*) as count
FROM public.questions
WHERE prompt_tr IS NULL OR meta_tr IS NULL;


