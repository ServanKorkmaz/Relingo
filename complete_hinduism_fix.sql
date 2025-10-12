-- Complete Hinduism Fix
-- This will restore Hinduism and all its lessons

-- STEP 1: Ensure Hinduism religion exists with icon
INSERT INTO public.religions (slug, name, color, icon_url)
VALUES ('hinduism', 'Hinduism', '#F59E0B', '/assets/religions/hinduism.svg')
ON CONFLICT (slug) 
DO UPDATE SET 
  icon_url = '/assets/religions/hinduism.svg',
  color = '#F59E0B',
  name = 'Hinduism';

-- STEP 2: Check if Hinduism intro lesson exists
-- If migration 0006 was run, these should exist but might be unlinked
-- We'll re-link or re-create them

-- Delete any existing orphaned Hinduism lessons first (to avoid duplicates)
DELETE FROM public.lessons 
WHERE slug IN (
  'hinduisme-opprinnelse',
  'hinduisme-tro',
  'hinduisme-praksis',
  'hinduisme-hoytider',
  'hinduisme-tekster',
  'hinduisme-moderne'
);

-- STEP 3: Re-insert all Hinduism lessons (from migration 0006)
INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'hinduisme-opprinnelse', 'Opprinnelse og historisk bakgrunn', 'Lær om hinduismens eldgamle røtter', 1, '/assets/lessons/hinduism_origins.svg', 1, true
FROM public.religions WHERE slug = 'hinduism';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'hinduisme-tro', 'Grunnleggende tro og læresetninger', 'Utforsk karma, reinkarnasjon og moksha', 2, '/assets/lessons/hinduism_beliefs.svg', 2, true
FROM public.religions WHERE slug = 'hinduism';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'hinduisme-praksis', 'Viktige praksiser og ritualer', 'Oppdag puja, templer og daglig tilbedelse', 2, '/assets/lessons/hinduism_practices.svg', 3, true
FROM public.religions WHERE slug = 'hinduism';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'hinduisme-hoytider', 'Høytider og merkedager', 'Utforsk Divali, Holi og andre festivaler', 2, '/assets/lessons/hinduism_holidays.svg', 4, true
FROM public.religions WHERE slug = 'hinduism';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'hinduisme-tekster', 'Hellige tekster og symboler', 'Lær om Vedaene, Bhagavad Gita og Om-symbolet', 2, '/assets/lessons/hinduism_texts.svg', 5, true
FROM public.religions WHERE slug = 'hinduism';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'hinduisme-moderne', 'Moderne uttrykk og mangfold', 'Utforsk hinduisme i dagens verden', 3, '/assets/lessons/hinduism_modern.svg', 6, true
FROM public.religions WHERE slug = 'hinduism';

-- STEP 4: Verify the fix
SELECT 
  'Verification' as step,
  r.slug as religion,
  r.name,
  r.icon_url,
  COUNT(l.id) as lesson_count
FROM public.religions r
LEFT JOIN public.lessons l ON l.religion_id = r.id
WHERE r.slug = 'hinduism'
GROUP BY r.id, r.slug, r.name, r.icon_url;

-- STEP 5: Show all religions with lesson counts
SELECT 
  'All Religions' as info,
  r.slug,
  r.name,
  r.color,
  r.icon_url,
  COUNT(l.id) as lessons
FROM public.religions r
LEFT JOIN public.lessons l ON l.religion_id = r.id
GROUP BY r.id, r.slug, r.name, r.color, r.icon_url
ORDER BY r.slug;

