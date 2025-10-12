-- Comprehensive Hinduism Icon Fix
-- This will diagnose and fix the missing icon issue

-- STEP 1: Check what's currently in the database
SELECT 
  'Current State' as step,
  slug, 
  name, 
  color, 
  COALESCE(icon_url, 'NULL - MISSING!') as icon_url,
  created_at
FROM public.religions 
ORDER BY slug;

-- STEP 2: Check if hinduism exists at all
SELECT 
  'Does Hinduism Exist?' as check_name,
  CASE 
    WHEN EXISTS (SELECT 1 FROM public.religions WHERE slug = 'hinduism') 
    THEN 'YES - Religion exists'
    ELSE 'NO - Religion missing, will insert'
  END as result;

-- STEP 3: Delete and re-insert Hinduism (safest approach)
DELETE FROM public.religions WHERE slug = 'hinduism';

INSERT INTO public.religions (slug, name, color, icon_url)
VALUES ('hinduism', 'Hinduism', '#F59E0B', '/assets/religions/hinduism.svg');

-- STEP 4: Verify the fix
SELECT 
  'After Fix' as step,
  slug, 
  name, 
  color, 
  icon_url,
  created_at
FROM public.religions 
WHERE slug = 'hinduism';

-- STEP 5: Compare with Islam (working example)
SELECT 
  'Comparison' as step,
  slug, 
  name, 
  color, 
  icon_url
FROM public.religions 
WHERE slug IN ('islam', 'hinduism')
ORDER BY slug;

