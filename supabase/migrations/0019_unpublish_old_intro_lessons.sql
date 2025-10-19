-- Unpublish old English intro lessons since we have Norwegian versions
-- The intro lessons from 0001_init.sql are in English and duplicates of the Norwegian content

UPDATE public.lessons 
SET published = false
WHERE slug IN ('intro-christianity', 'intro-islam', 'intro-hinduism', 'intro-judaism', 'intro-buddhism');

