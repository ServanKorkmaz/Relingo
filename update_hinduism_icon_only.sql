-- Update Hinduism Icon (don't insert, just update)
-- Hinduism already exists, we just need to set the icon_url

-- Update the existing Hinduism record
UPDATE public.religions 
SET 
  icon_url = '/assets/religions/hinduism.svg',
  color = '#F59E0B',
  name = 'Hinduism'
WHERE slug = 'hinduism';

-- Verify the update worked
SELECT 
  slug, 
  name, 
  color, 
  icon_url,
  'Updated successfully!' as status
FROM public.religions 
WHERE slug = 'hinduism';

-- Compare with Islam to ensure they match format
SELECT 
  slug, 
  name, 
  color, 
  icon_url
FROM public.religions 
WHERE slug IN ('islam', 'hinduism')
ORDER BY slug;

