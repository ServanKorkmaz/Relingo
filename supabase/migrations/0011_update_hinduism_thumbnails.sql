-- Update Hinduism lesson thumbnails to use unique images
-- This migration updates existing lessons with new thumbnail URLs

UPDATE public.lessons
SET thumbnail_url = '/assets/lessons/hinduism_origins.svg'
WHERE slug = 'hinduisme-opprinnelse';

UPDATE public.lessons
SET thumbnail_url = '/assets/lessons/hinduism_beliefs.svg'
WHERE slug = 'hinduisme-tro';

UPDATE public.lessons
SET thumbnail_url = '/assets/lessons/hinduism_practices.svg'
WHERE slug = 'hinduisme-praksis';

UPDATE public.lessons
SET thumbnail_url = '/assets/lessons/hinduism_holidays.svg'
WHERE slug = 'hinduisme-hoytider';

UPDATE public.lessons
SET thumbnail_url = '/assets/lessons/hinduism_texts.svg'
WHERE slug = 'hinduisme-tekster';

UPDATE public.lessons
SET thumbnail_url = '/assets/lessons/hinduism_modern.svg'
WHERE slug = 'hinduisme-moderne';

