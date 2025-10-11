-- Norwegian Hinduism Content Migration
-- Add comprehensive lessons and quizzes about Hinduism in Norwegian

-- Add detailed lessons for Hinduism with unique thumbnails
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

-- Quiz 1: Opprinnelse og historisk bakgrunn
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Historisk bakgrunn Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'hinduisme-opprinnelse';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Hinduisme er en av verdens eldste religioner.', 0,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva kjennetegner hinduismens opprinnelse?', 1,
'{"choices":[
 {"id":"a","text":"Den har én enkelt grunnlegger"},
 {"id":"b","text":"Den har ingen enkelt grunnlegger og oppstod over tusen år","correct":true},
 {"id":"c","text":"Den ble grunnlagt i Egypt"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'De tidligste sporene knyttes til ___-sivilisasjonen (ca. 2500 fvt.).', 2,
'{"answer":"Indus"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva kalles den tidlige religionen fra indoeuropeiske folkegrupper?', 3,
'{"choices":[
 {"id":"a","text":"Vedisk religion","correct":true},
 {"id":"b","text":"Buddhisme"},
 {"id":"c","text":"Jainisme"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ introduserte tenkningen om gjenfødsel og en universell kraft kalt Brahman.', 4,
'{"answer":"Upanishadene"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Bhagavad Gita er en filosofisk dialog hvor Krishna veileder prins Arjuna.', 5,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva er bhakti-bevegelsen?', 6,
'{"choices":[
 {"id":"a","text":"En politisk bevegelse"},
 {"id":"b","text":"En retning basert på personlig hengivenhet til det guddommelige","correct":true},
 {"id":"c","text":"En krigerorden"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-opprinnelse'
LIMIT 1;

-- Quiz 2: Grunnleggende tro og læresetninger
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Tro og læresetninger Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'hinduisme-tro';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Troen på ___ (reinkarnasjon) er sentral i hinduismen.', 0,
'{"answer":"gjenfødelse"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva påvirker ens fremtidige liv i hinduismen?', 1,
'{"choices":[
 {"id":"a","text":"Tilfeldigheter"},
 {"id":"b","text":"Karma (handlingenes konsekvenser)","correct":true},
 {"id":"c","text":"Bare lykke"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Livets endelige mål er å oppnå ___ (frigjøring fra gjenfødelsens kretsløp).', 2,
'{"answer":"moksha"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Brahman anses som det altomfattende guddommelige prinsipp.', 3,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilke tre guddommer er mest sentrale i hinduismen?', 4,
'{"choices":[
 {"id":"a","text":"Vishnu, Shiva og Devi","correct":true},
 {"id":"b","text":"Rama, Sita og Hanuman"},
 {"id":"c","text":"Krishna, Arjuna og Ganesha"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Vishnu stiger ned til jorden i ulike ___ for å gjenopprette balansen.', 5,
'{"answer":"avatarer"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Shiva representerer skaper- og ødeleggermakt.', 6,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-tro'
LIMIT 1;

-- Quiz 3: Viktige praksiser og ritualer
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Praksiser og ritualer Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'hinduisme-praksis';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Daglig tilbedelse i hinduismen kalles ___.', 0,
'{"answer":"puja"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva er prasada?', 1,
'{"choices":[
 {"id":"a","text":"En guddom"},
 {"id":"b","text":"Velsignet mat som tilbakegis fra guddommen","correct":true},
 {"id":"c","text":"Et tempel"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'De fleste hinduer har et lite husalter hjemme.', 2,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Prinsippet om ___ (ikke-vold) har bidratt til at mange hinduer er vegetarianere.', 3,
'{"answer":"ahimsa"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilken elv anses som hellig i hinduismen?', 4,
'{"choices":[
 {"id":"a","text":"Nilen"},
 {"id":"b","text":"Ganges","correct":true},
 {"id":"c","text":"Jordan"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Kua sees som et hellig dyr i hinduismen.', 5,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Hinduiske religiøse lærere kalles ___.', 6,
'{"answer":"guruer"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-praksis'
LIMIT 1;

-- Quiz 4: Høytider og merkedager
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Høytider Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'hinduisme-hoytider';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilke to høytider er mest kjente i hinduismen?', 0,
'{"choices":[
 {"id":"a","text":"Jul og påske"},
 {"id":"b","text":"Divali og Holi","correct":true},
 {"id":"c","text":"Ramadan og id"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ er en lysfest som markerer lysets triumf over mørket.', 1,
'{"answer":"Divali"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Under Divali æres gudinnen Lakshmi (velstandens gudinne).', 2,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Når feires Holi?', 3,
'{"choices":[
 {"id":"a","text":"Vinter"},
 {"id":"b","text":"Vår (februar/mars)","correct":true},
 {"id":"c","text":"Høst"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Under Holi kaster folk farget ___ og vann på hverandre.', 4,
'{"answer":"pulver"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Navaratri varer i ni netter og feirer det godes seier over det onde.', 5,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva feires under Krishna Janmashtami?', 6,
'{"choices":[
 {"id":"a","text":"Krishnas bryllup"},
 {"id":"b","text":"Krishnas fødselsdag","correct":true},
 {"id":"c","text":"Krishnas død"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-hoytider'
LIMIT 1;

-- Quiz 5: Hellige tekster og symboler
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Tekster og symboler Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'hinduisme-tekster';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Den viktigste shruti-skriftsamlingen er ___.', 0,
'{"answer":"Vedaene"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvor gammel er Rigveda, den eldste av Vedaene?', 1,
'{"choices":[
 {"id":"a","text":"500 år"},
 {"id":"b","text":"Minst 3000 år","correct":true},
 {"id":"c","text":"100 år"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Atman (individets sjel) er identisk med Brahman (den universelle sjel) ifølge Upanishadene.', 2,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilke to store eposer er mest berømte i hinduismen?', 3,
'{"choices":[
 {"id":"a","text":"Bibelen og Koranen"},
 {"id":"b","text":"Ramayana og Mahabharata","correct":true},
 {"id":"c","text":"Illiaden og Odysseen"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ er en hellig lyd og et symbol som representerer det guddommelige universets urlyd.', 4,
'{"answer":"Om"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'I hinduistisk tradisjon er swastikaen et eldgammelt lykkesymbol.', 5,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva symboliserer lotusblomsten?', 6,
'{"choices":[
 {"id":"a","text":"Krig"},
 {"id":"b","text":"Renhet og åndelig utfoldelse","correct":true},
 {"id":"c","text":"Død"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Shruti-tekstene anses som åpenbarte tekster, mens ___-tekstene er menneskeskapte.', 7,
'{"answer":"smriti"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-tekster'
LIMIT 1;

-- Quiz 6: Moderne uttrykk og mangfold
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Moderne mangfold Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'hinduisme-moderne';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Omtrent hvor mange hinduer er det i verden?', 0,
'{"choices":[
 {"id":"a","text":"100 millioner"},
 {"id":"b","text":"1,2 milliarder","correct":true},
 {"id":"c","text":"5 milliarder"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Hinduismen er majoritetsreligionen i India og ___.', 1,
'{"answer":"Nepal"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva er de tre hovedretningene i hinduismen basert på?', 2,
'{"choices":[
 {"id":"a","text":"Ulike templer"},
 {"id":"b","text":"Hvilken guddom som står i sentrum","correct":true},
 {"id":"c","text":"Ulike land"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Vishnuismen fokuserer på Vishnu og hans avatarer som Krishna og ___.', 3,
'{"answer":"Rama"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Swami Vivekananda presenterte hinduismen på Verdensparlamentet for religioner i Chicago i 1893.', 4,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva er ISKCON også kjent som?', 5,
'{"choices":[
 {"id":"a","text":"Buddhisme"},
 {"id":"b","text":"Hare Krishna-bevegelsen","correct":true},
 {"id":"c","text":"Jainisme"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Mange hinduer praktiserer ___ og meditasjon, også populært i Vesten.', 6,
'{"answer":"yoga"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Hinduismen verdsetter toleranse og pluralisme – idealet om at det finnes mange veier til det guddommelige.', 7,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'hinduisme-moderne'
LIMIT 1;

