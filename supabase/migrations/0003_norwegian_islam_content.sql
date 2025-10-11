-- Norwegian Islam Content Migration
-- Add comprehensive lessons and quizzes about Islam in Norwegian

-- First, let's add more detailed lessons for Islam
INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'islam-opprinnelse', 'Opprinnelse og historisk bakgrunn', 'Lær om islams begynnelse på 600-tallet', 1, '/assets/lessons/islam_intro.svg', 1, true
FROM public.religions WHERE slug = 'islam';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'islam-tro', 'Grunnleggende tro og læresetninger', 'Utforsk de sentrale trosprinsippene i islam', 2, '/assets/lessons/islam_intro.svg', 2, true
FROM public.religions WHERE slug = 'islam';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'islam-soylene', 'De fem søylene', 'Oppdag islams fem grunnleggende plikter', 2, '/assets/lessons/islam_intro.svg', 3, true
FROM public.religions WHERE slug = 'islam';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'islam-hoytider', 'Høytider og merkedager', 'Utforsk muslimske høytider som ramadan og id', 2, '/assets/lessons/islam_intro.svg', 4, true
FROM public.religions WHERE slug = 'islam';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'islam-tekster', 'Hellige tekster og symboler', 'Lær om Koranen og islamske symboler', 2, '/assets/lessons/islam_intro.svg', 5, true
FROM public.religions WHERE slug = 'islam';

-- Quiz 1: Opprinnelse og historisk bakgrunn
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Historisk bakgrunn Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'islam-opprinnelse';

-- Questions for Quiz 1
INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Når oppsto islam?', 0,
'{"choices":[
 {"id":"a","text":"På 600-tallet e.v.t.","correct":true},
 {"id":"b","text":"På 100-tallet e.v.t."},
 {"id":"c","text":"På 1000-tallet e.v.t."}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Religionens grunnlegger, profeten ___ (ca. 570–632 e.v.t.), mottok ifølge islams tro sin første åpenbaring fra Gud i år 610.', 1,
'{"answer":"Muhammad"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'I hvilket år mottok profeten Muhammad sin første åpenbaring?', 2,
'{"choices":[
 {"id":"a","text":"610","correct":true},
 {"id":"b","text":"622"},
 {"id":"c","text":"632"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'I ___ utvandret Muhammad fra Mekka til Medina (den såkalte hijra).', 3,
'{"answer":"622"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Ved Muhammads død i 632 hadde han forent store deler av Den arabiske halvøy under islam.', 4,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva er navnet på tilhengerne av Ali som utviklet seg til en egen retning i islam?', 5,
'{"choices":[
 {"id":"a","text":"Sunni"},
 {"id":"b","text":"Sjia","correct":true},
 {"id":"c","text":"Sufi"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Skillet mellom sunni og sjia oppsto på grunn av uenighet om hvem som skulle etterfølge Muhammad som leder.', 6,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-opprinnelse'
LIMIT 1;

-- Quiz 2: Grunnleggende tro og læresetninger
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Tro og læresetninger Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'islam-tro';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Islam er en strengt monoteistisk religion.', 0,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Det finnes bare én allmektig Gud – ___.', 1,
'{"answer":"Allah"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvor mange trosartikler har islam?', 2,
'{"choices":[
 {"id":"a","text":"Tre"},
 {"id":"b","text":"Fem"},
 {"id":"c","text":"Seks","correct":true}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Trosbekjennelsen (___) lyder: «Jeg bevitner at det er ingen guddom utenom Allah, og at Muhammad er Hans sendebud».', 3,
'{"answer":"shahada"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva betyr ordet "islam"?', 4,
'{"choices":[
 {"id":"a","text":"Fred"},
 {"id":"b","text":"Underkastelse (under Gud)","correct":true},
 {"id":"c","text":"Kjærlighet"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Islam lærer at mennesket skal stå til ansvar overfor Gud på Dommens dag.', 5,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Ifølge islam, hvem er tidligere profeter i den abrahamittiske tradisjonen?', 6,
'{"choices":[
 {"id":"a","text":"Kun Muhammad"},
 {"id":"b","text":"Abraham, Moses og Jesus","correct":true},
 {"id":"c","text":"Kun Jesus"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tro'
LIMIT 1;

-- Quiz 3: De fem søylene
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'De fem søylene Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'islam-soylene';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvor mange daglige bønner skal muslimer be?', 0,
'{"choices":[
 {"id":"a","text":"Tre"},
 {"id":"b","text":"Fem","correct":true},
 {"id":"c","text":"Syv"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-soylene'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Den rituelle avgiften kalles ___ og er ca. 2,5% av ens formue.', 1,
'{"answer":"zakat"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-soylene'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Muslimer skal be vendt mot Mekka.', 2,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-soylene'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva er navnet på pilegrimsreisen til Mekka?', 3,
'{"choices":[
 {"id":"a","text":"Hajj","correct":true},
 {"id":"b","text":"Umrah"},
 {"id":"c","text":"Salah"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-soylene'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Under fastemåneden ___ skal voksne muslimer faste fra daggry til solnedgang.', 4,
'{"answer":"ramadan"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-soylene'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Hver muslim skal forsøke å gjennomføre hajj én gang i livet dersom vedkommende har helse og økonomi til det.', 5,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-soylene'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilken dag i uken er den viktigste bønnedagen i islam?', 6,
'{"choices":[
 {"id":"a","text":"Søndag"},
 {"id":"b","text":"Fredag","correct":true},
 {"id":"c","text":"Lørdag"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-soylene'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Før bønn må muslimer utføre rituell renselse som kalles ___.', 7,
'{"answer":"wudu"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-soylene'
LIMIT 1;

-- Quiz 4: Høytider og merkedager
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Høytider Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'islam-hoytider';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva kalles høytiden som markerer slutten på ramadan?', 0,
'{"choices":[
 {"id":"a","text":"Id al-fitr","correct":true},
 {"id":"b","text":"Id al-adha"},
 {"id":"c","text":"Ashura"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ (offerfesten) feires ved avslutningen av den årlige hajj-pilegrimsferden.', 1,
'{"answer":"Id al-adha"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Islam følger en islamsk kalender basert på måneåret.', 2,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva markerer id al-adha ifølge tradisjonen?', 3,
'{"choices":[
 {"id":"a","text":"Muhammads fødsel"},
 {"id":"b","text":"Profeten Abrahams villighet til å ofre sin sønn","correct":true},
 {"id":"c","text":"Slutten på fasten"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Ashura-dagen markeres den 10. ___ (første måned i året).', 4,
'{"answer":"muharram"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'For sjiamuslimer er ashura en sørgedag til minne om Imam Husayns martyrdød.', 5,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilken dag hedrer muslimer profeten Muhammads fødsel?', 6,
'{"choices":[
 {"id":"a","text":"Ashura"},
 {"id":"b","text":"Mawlid al-nabi","correct":true},
 {"id":"c","text":"Id al-fitr"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-hoytider'
LIMIT 1;

-- Quiz 5: Hellige tekster og symboler
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Tekster og symboler Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'islam-tekster';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ er islams helligste skrift.', 0,
'{"answer":"Koranen"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Gjennom hvem mottok Muhammad åpenbaringene?', 1,
'{"choices":[
 {"id":"a","text":"Direkte fra Gud"},
 {"id":"b","text":"Engelen Gabriel","correct":true},
 {"id":"c","text":"Profeten Abraham"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Koranen er inndelt i 114 kapitler som kalles ___.', 2,
'{"answer":"surer"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Hadith er nedskrevne fortellinger om hva Muhammad sa og gjorde.', 3,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva kalles Profetens eksempel som dannes av hadith?', 4,
'{"choices":[
 {"id":"a","text":"Sharia"},
 {"id":"b","text":"Sunna","correct":true},
 {"id":"c","text":"Umma"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ (den islamske loven) bygger på påbud og forbud som kommer til uttrykk i Koranen og hadith.', 5,
'{"answer":"Sharia"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Islam har tradisjonelt et strengt billedforbud i religiøs sammenheng.', 6,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva er navnet på den svarte steinbygningen i Mekka som muslimer vender seg mot når de ber?', 7,
'{"choices":[
 {"id":"a","text":"Moskéen"},
 {"id":"b","text":"Kaba","correct":true},
 {"id":"c","text":"Minareten"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Islamsk kunst og symbolbruk er hovedsakelig nonfigurativ og pyntes med arabisk ___ (kunstferdig skrift).', 8,
'{"answer":"kalligrafi"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilket symbol er mest kjent som emblem for islam i dag?', 9,
'{"choices":[
 {"id":"a","text":"Korset"},
 {"id":"b","text":"Halvmånen og stjernen","correct":true},
 {"id":"c","text":"Fisken"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Halvmåne-og-stjerne-symbolet har historisk opprinnelse før islam og ble populært gjennom det osmanske riket.', 10,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Farven ___ forbindes ofte med islam og symboliserer paradiset.', 11,
'{"answer":"grønn"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'islam-tekster'
LIMIT 1;

