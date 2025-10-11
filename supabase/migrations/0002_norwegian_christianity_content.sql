-- Norwegian Christianity Content Migration
-- Add comprehensive lessons and quizzes about Christianity in Norwegian

-- First, let's add more detailed lessons for Christianity with unique thumbnails
INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'kristendom-opprinnelse', 'Opprinnelse og historisk bakgrunn', 'Lær om kristendommens begynnelse i det første århundre', 1, '/assets/lessons/christianity_origins.svg', 1, true
FROM public.religions WHERE slug = 'christianity';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'kristendom-tro', 'Grunnleggende tro og læresetninger', 'Utforsk de sentrale trosprinsippene i kristendommen', 2, '/assets/lessons/christianity_beliefs.svg', 2, true
FROM public.religions WHERE slug = 'christianity';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'kristendom-praksis', 'Viktige praksiser og ritualer', 'Oppdag kristne ritualer og daglige praksiser', 2, '/assets/lessons/christianity_practices.svg', 3, true
FROM public.religions WHERE slug = 'christianity';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'kristendom-hoytider', 'Høytider og merkedager', 'Utforsk kristne høytider som jul, påske og pinse', 2, '/assets/lessons/christianity_holidays.svg', 4, true
FROM public.religions WHERE slug = 'christianity';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'kristendom-tekster', 'Hellige tekster og symboler', 'Lær om Bibelen og kristne symboler', 2, '/assets/lessons/christianity_texts.svg', 5, true
FROM public.religions WHERE slug = 'christianity';

-- Quiz 1: Opprinnelse og historisk bakgrunn
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Historisk bakgrunn Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'kristendom-opprinnelse';

-- Questions for Quiz 1
INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Når oppsto kristendommen?', 0,
'{"choices":[
 {"id":"a","text":"Rundt år 30 e.Kr.","correct":true},
 {"id":"b","text":"Rundt år 100 f.Kr."},
 {"id":"c","text":"Rundt år 500 e.Kr."}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvor oppsto kristendommen?', 1,
'{"choices":[
 {"id":"a","text":"I Egypt"},
 {"id":"b","text":"I det jødiske Palestina","correct":true},
 {"id":"c","text":"I Roma"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Jesus ble henrettet ved korsfestelse, men hans tilhengere forkynte at han stod opp fra de døde.', 2,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilken keiser innførte religionsfrihet og gjorde slutt på forfølgelsene av kristne i 313 e.Kr.?', 3,
'{"choices":[
 {"id":"a","text":"Augustus"},
 {"id":"b","text":"Konstantin den store","correct":true},
 {"id":"c","text":"Nero"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'I ___ e.Kr. erklærte keiser Theodosius kristendommen som romersk statsreligion.', 4,
'{"answer":"380"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Når skjedde det store skisma mellom Vestkirken og Østkirken?', 5,
'{"choices":[
 {"id":"a","text":"1054","correct":true},
 {"id":"b","text":"1517"},
 {"id":"c","text":"313"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'På 1500-tallet førte ___, anført av Martin Luther, til at nye protestantiske kirkesamfunn brøt ut fra den katolske kirke.', 6,
'{"answer":"reformasjonen"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-opprinnelse'
LIMIT 1;

-- Quiz 2: Grunnleggende tro og læresetninger
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Tro og læresetninger Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'kristendom-tro';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Kristendommen er en monoteistisk religion.', 0,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'De fleste kirkesamfunn fastholder troen på ___: at Gud er ett vesen, men tre «personer».', 1,
'{"answer":"treenigheten"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva består treenigheten av?', 2,
'{"choices":[
 {"id":"a","text":"Tre guder"},
 {"id":"b","text":"Faderen, Sønnen og Den hellige ånd","correct":true},
 {"id":"c","text":"Tre kirker"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'I kristen lære forstås Jesus som både fullt ut Gud og menneske.', 3,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvordan oppnås frelse ifølge kristendommen?', 4,
'{"choices":[
 {"id":"a","text":"Ved å følge alle lover perfekt"},
 {"id":"b","text":"Ved tro på Jesus","correct":true},
 {"id":"c","text":"Ved å gi penger til kirken"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Kristendommen legger vekt på ___, tilgivelse og omsorg for andre som grunnleggende verdier.', 5,
'{"answer":"nestekjærlighet"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-tro'
LIMIT 1;

-- Quiz 3: Viktige praksiser og ritualer
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Praksiser og ritualer Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'kristendom-praksis';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilken dag i uken er den vanligste gudstjenestedagen?', 0,
'{"choices":[
 {"id":"a","text":"Fredag"},
 {"id":"b","text":"Lørdag"},
 {"id":"c","text":"Søndag","correct":true}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Dåp og nattverd regnes som særlig viktige sakramenter i de fleste kirkesamfunn.', 1,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ markerer innlemmelsen i det kristne fellesskapet og symboliserer renselse fra synd.', 2,
'{"answer":"Dåpen"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva symboliserer brød og vin i nattverden?', 3,
'{"choices":[
 {"id":"a","text":"Mat og drikke generelt"},
 {"id":"b","text":"Jesu kropp og blod","correct":true},
 {"id":"c","text":"Himmelens rikdom"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ er bekreftelsen av dåpspakt i ungdomsalder.', 4,
'{"answer":"Konfirmasjon"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-praksis'
LIMIT 1;

-- Quiz 4: Høytider og merkedager
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Høytider Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'kristendom-hoytider';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva er de tre største kristne høytidene?', 0,
'{"choices":[
 {"id":"a","text":"Jul, påske og pinse","correct":true},
 {"id":"b","text":"Jul, nyttår og allehelgensdag"},
 {"id":"c","text":"Påske, sommer og høst"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Jul feires til minne om Jesu fødsel.', 1,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilken høytid regnes som den viktigste og eldste kristne høytiden?', 2,
'{"choices":[
 {"id":"a","text":"Jul"},
 {"id":"b","text":"Påske","correct":true},
 {"id":"c","text":"Pinse"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Påsken feires til minne om Jesu lidelse, død og ___.', 3,
'{"answer":"oppstandelse"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva markerer pinse?', 4,
'{"choices":[
 {"id":"a","text":"Jesu fødsel"},
 {"id":"b","text":"Den hellige ånds komme over apostlene","correct":true},
 {"id":"c","text":"Jesu korsfestelse"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Pinse kommer ___ dager etter påske.', 5,
'{"answer":"50"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilken dag feires ukentlig fordi Jesus stod opp denne dagen?', 6,
'{"choices":[
 {"id":"a","text":"Fredag"},
 {"id":"b","text":"Lørdag"},
 {"id":"c","text":"Søndag","correct":true}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-hoytider'
LIMIT 1;

-- Quiz 5: Hellige tekster og symboler
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Tekster og symboler Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'kristendom-tekster';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ er kristendommens hellige skrift og autoritative kilde for tro og lære.', 0,
'{"answer":"Bibelen"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva består Bibelen av?', 1,
'{"choices":[
 {"id":"a","text":"Kun Det nye testamentet"},
 {"id":"b","text":"Det gamle testamentet og Det nye testamentet","correct":true},
 {"id":"c","text":"Kun Det gamle testamentet"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Det nye testamentet inneholder de fire evangeliene om Jesu liv.', 2,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva er det mest utbredte symbolet i kristendommen?', 3,
'{"choices":[
 {"id":"a","text":"Korset","correct":true},
 {"id":"b","text":"Fisken"},
 {"id":"c","text":"Duen"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Korset representerer Jesu ___ og frelsesverket.', 4,
'{"answer":"korsfestelse"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva symboliserer duen i kristendommen?', 5,
'{"choices":[
 {"id":"a","text":"Fred"},
 {"id":"b","text":"Den hellige ånd","correct":true},
 {"id":"c","text":"Englene"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Den kristne fisken (Ichthys) ble brukt som et hemmelig kjennetegn av de tidlige kristne.', 6,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'kristendom-tekster'
LIMIT 1;

