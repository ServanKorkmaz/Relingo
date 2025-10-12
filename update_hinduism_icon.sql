-- Update Hinduism religion icon
-- This ensures Hinduism has the correct main icon/picture

-- First, let's check the current state
SELECT slug, name, color, icon_url 
FROM public.religions 
WHERE slug = 'hinduism';

-- Update Hinduism with the icon URL (safe to run - uses ON CONFLICT)
INSERT INTO public.religions (slug, name, color, icon_url)
VALUES ('hinduism', 'Hinduism', '#F59E0B', '/assets/religions/hinduism.svg')
ON CONFLICT (slug) 
DO UPDATE SET 
  icon_url = '/assets/religions/hinduism.svg',
  color = '#F59E0B';

-- Verify the update
SELECT slug, name, color, icon_url 
FROM public.religions 
WHERE slug = 'hinduism';

