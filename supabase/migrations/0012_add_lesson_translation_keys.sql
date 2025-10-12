-- Add translation keys to lessons table
-- Instead of hardcoded titles, we'll use i18n keys

ALTER TABLE public.lessons 
ADD COLUMN title_key TEXT,
ADD COLUMN description_key TEXT;

-- Update Christianity lessons with translation keys
UPDATE public.lessons SET 
  title_key = 'lessons.christianity.origins.title',
  description_key = 'lessons.christianity.origins.description'
WHERE slug = 'kristendom-opprinnelse';

UPDATE public.lessons SET 
  title_key = 'lessons.christianity.beliefs.title',
  description_key = 'lessons.christianity.beliefs.description'
WHERE slug = 'kristendom-tro';

UPDATE public.lessons SET 
  title_key = 'lessons.christianity.practices.title',
  description_key = 'lessons.christianity.practices.description'
WHERE slug = 'kristendom-praksis';

UPDATE public.lessons SET 
  title_key = 'lessons.christianity.holidays.title',
  description_key = 'lessons.christianity.holidays.description'
WHERE slug = 'kristendom-hoytider';

UPDATE public.lessons SET 
  title_key = 'lessons.christianity.texts.title',
  description_key = 'lessons.christianity.texts.description'
WHERE slug = 'kristendom-tekster';

-- Update Islam lessons
UPDATE public.lessons SET 
  title_key = 'lessons.islam.origins.title',
  description_key = 'lessons.islam.origins.description'
WHERE slug = 'islam-opprinnelse';

UPDATE public.lessons SET 
  title_key = 'lessons.islam.beliefs.title',
  description_key = 'lessons.islam.beliefs.description'
WHERE slug = 'islam-tro';

UPDATE public.lessons SET 
  title_key = 'lessons.islam.pillars.title',
  description_key = 'lessons.islam.pillars.description'
WHERE slug = 'islam-soylene';

UPDATE public.lessons SET 
  title_key = 'lessons.islam.holidays.title',
  description_key = 'lessons.islam.holidays.description'
WHERE slug = 'islam-hoytider';

UPDATE public.lessons SET 
  title_key = 'lessons.islam.texts.title',
  description_key = 'lessons.islam.texts.description'
WHERE slug = 'islam-tekster';

-- Update Hinduism lessons
UPDATE public.lessons SET 
  title_key = 'lessons.hinduism.origins.title',
  description_key = 'lessons.hinduism.origins.description'
WHERE slug = 'hinduisme-opprinnelse';

UPDATE public.lessons SET 
  title_key = 'lessons.hinduism.beliefs.title',
  description_key = 'lessons.hinduism.beliefs.description'
WHERE slug = 'hinduisme-tro';

UPDATE public.lessons SET 
  title_key = 'lessons.hinduism.practices.title',
  description_key = 'lessons.hinduism.practices.description'
WHERE slug = 'hinduisme-praksis';

UPDATE public.lessons SET 
  title_key = 'lessons.hinduism.holidays.title',
  description_key = 'lessons.hinduism.holidays.description'
WHERE slug = 'hinduisme-hoytider';

UPDATE public.lessons SET 
  title_key = 'lessons.hinduism.texts.title',
  description_key = 'lessons.hinduism.texts.description'
WHERE slug = 'hinduisme-tekster';

UPDATE public.lessons SET 
  title_key = 'lessons.hinduism.modern.title',
  description_key = 'lessons.hinduism.modern.description'
WHERE slug = 'hinduisme-moderne';

-- Update Judaism lessons
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

-- Update intro lessons
UPDATE public.lessons SET 
  title_key = 'lessons.christianity.intro.title',
  description_key = 'lessons.christianity.intro.description'
WHERE slug = 'intro-christianity';

UPDATE public.lessons SET 
  title_key = 'lessons.islam.intro.title',
  description_key = 'lessons.islam.intro.description'
WHERE slug = 'intro-islam';

UPDATE public.lessons SET 
  title_key = 'lessons.hinduism.intro.title',
  description_key = 'lessons.hinduism.intro.description'
WHERE slug = 'intro-hinduism';

UPDATE public.lessons SET 
  title_key = 'lessons.judaism.intro.title',
  description_key = 'lessons.judaism.intro.description'
WHERE slug = 'intro-judaism';

UPDATE public.lessons SET 
  title_key = 'lessons.buddhism.intro.title',
  description_key = 'lessons.buddhism.intro.description'
WHERE slug = 'intro-buddhism';

