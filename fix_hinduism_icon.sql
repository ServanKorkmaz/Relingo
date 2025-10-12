-- Fix Hinduism Religion Icon
-- This ensures Hinduism has the proper icon like Islam does

-- First, check current state of all religions
SELECT slug, name, color, icon_url 
FROM public.religions 
ORDER BY slug;

-- Update Hinduism to have the icon (matching Islam's format)
UPDATE public.religions 
SET 
  icon_url = '/assets/religions/hinduism.svg',
  color = '#F59E0B',
  name = 'Hinduism'
WHERE slug = 'hinduism';

-- If Hinduism doesn't exist at all, insert it
INSERT INTO public.religions (slug, name, color, icon_url)
VALUES ('hinduism', 'Hinduism', '#F59E0B', '/assets/religions/hinduism.svg')
ON CONFLICT (slug) DO NOTHING;

-- Verify the fix - should now show icon_url like Islam does
SELECT slug, name, color, icon_url 
FROM public.religions 
WHERE slug IN ('islam', 'hinduism')
ORDER BY slug;

