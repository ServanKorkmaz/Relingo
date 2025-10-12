-- Check Hinduism Status - Why is it not showing?

-- STEP 1: Check if Hinduism religion exists
SELECT 
  'Religion Check' as check_type,
  id,
  slug, 
  name, 
  color, 
  icon_url
FROM public.religions 
WHERE slug = 'hinduism';

-- STEP 2: Check if there are any Hinduism lessons
SELECT 
  'Lesson Count' as check_type,
  COUNT(*) as total_lessons
FROM public.lessons l
JOIN public.religions r ON r.id = l.religion_id
WHERE r.slug = 'hinduism';

-- STEP 3: List all Hinduism lessons
SELECT 
  'Hinduism Lessons' as info,
  l.id,
  l.slug,
  l.title,
  l.order_index,
  l.published
FROM public.lessons l
JOIN public.religions r ON r.id = l.religion_id
WHERE r.slug = 'hinduism'
ORDER BY l.order_index;

-- STEP 4: Compare with Islam (working example)
SELECT 
  'Comparison' as info,
  r.slug as religion,
  r.name,
  r.icon_url,
  COUNT(l.id) as lesson_count
FROM public.religions r
LEFT JOIN public.lessons l ON l.religion_id = r.id
WHERE r.slug IN ('islam', 'hinduism')
GROUP BY r.id, r.slug, r.name, r.icon_url
ORDER BY r.slug;

-- STEP 5: Check if lessons exist but are orphaned (no religion_id match)
SELECT 
  'Orphaned Hinduism Lessons?' as check_type,
  COUNT(*) as orphaned_count
FROM public.lessons
WHERE slug LIKE 'hinduism%' OR slug LIKE 'hinduisme%'
  AND religion_id NOT IN (SELECT id FROM public.religions WHERE slug = 'hinduism');

