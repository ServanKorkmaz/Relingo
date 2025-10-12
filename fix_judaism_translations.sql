-- Fix Judaism lesson translation keys
UPDATE public.lessons SET 
  title_key = 'lessons.judaism.origins.title',
  description_key = 'lessons.judaism.origins.description'
WHERE slug = 'jodedom-opprinnelse';

UPDATE public.lessons SET 
  title_key = 'lessons.judaism.beliefs.title',
  description_key = 'lessons.judaism.beliefs.description'
WHERE slug = 'jodedom-tro';

UPDATE public.lessons SET 
  title_key = 'lessons.judaism.practices.title',
  description_key = 'lessons.judaism.practices.description'
WHERE slug = 'jodedom-praksis';

UPDATE public.lessons SET 
  title_key = 'lessons.judaism.holidays.title',
  description_key = 'lessons.judaism.holidays.description'
WHERE slug = 'jodedom-hoytider';

UPDATE public.lessons SET 
  title_key = 'lessons.judaism.texts.title',
  description_key = 'lessons.judaism.texts.description'
WHERE slug = 'jodedom-tekster';

UPDATE public.lessons SET 
  title_key = 'lessons.judaism.modern.title',
  description_key = 'lessons.judaism.modern.description'
WHERE slug = 'jodedom-moderne';

