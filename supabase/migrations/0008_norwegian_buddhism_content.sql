-- Norwegian Buddhism Content Migration
-- Add comprehensive lessons and quizzes about Buddhism in Norwegian

-- First, add Buddhism to religions if it doesn't exist
INSERT INTO public.religions (slug, name, color, icon_url)
VALUES ('buddhism', 'Buddhisme', '#EC4899', '/assets/religions/buddhism.svg')
ON CONFLICT (slug) DO NOTHING;

-- Add 6 lessons for Buddhism
INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'buddhisme-opprinnelse', 'Opprinnelse og historisk bakgrunn', 'Lær om buddhismens begynnelse i Nord-India for 2500 år siden', 1, '/assets/lessons/buddhism_intro.svg', 1, true
FROM public.religions WHERE slug = 'buddhism';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'buddhisme-tro', 'Grunnleggende tro og læresetninger', 'Utforsk de fire edle sannheter og den åttedelte vei', 2, '/assets/lessons/buddhism_intro.svg', 2, true
FROM public.religions WHERE slug = 'buddhism';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'buddhisme-praksis', 'Viktige praksiser og ritualer', 'Oppdag meditasjon, bønn og buddhistiske ritualer', 2, '/assets/lessons/buddhism_intro.svg', 3, true
FROM public.religions WHERE slug = 'buddhism';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'buddhisme-hoytider', 'Høytider og merkedager', 'Utforsk buddhistiske høytider som Vesak og nyttår', 2, '/assets/lessons/buddhism_intro.svg', 4, true
FROM public.religions WHERE slug = 'buddhism';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'buddhisme-tekster', 'Hellige tekster og symboler', 'Lær om Tripitaka, dharmahjulet og lotusblomsten', 2, '/assets/lessons/buddhism_intro.svg', 5, true
FROM public.religions WHERE slug = 'buddhism';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'buddhisme-moderne', 'Moderne uttrykk og mangfold', 'Utforsk buddhisme i dagens verden og ulike tradisjoner', 3, '/assets/lessons/buddhism_intro.svg', 6, true
FROM public.religions WHERE slug = 'buddhism';

-- Quiz 1: Opprinnelse og historisk bakgrunn
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Historisk bakgrunn Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'buddhisme-opprinnelse';

-- Questions for Quiz 1
INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvor oppstod buddhismen?', 0,
'{"choices":[
 {"id":"a","text":"Kina"},
 {"id":"b","text":"Nord-India","correct":true},
 {"id":"c","text":"Tibet"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Buddhismen ble grunnlagt av ___ Gautama, som senere ble kjent som Buddha.', 1,
'{"answer":"Siddhartha"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'For omtrent hvor lenge siden oppstod buddhismen?', 2,
'{"choices":[
 {"id":"a","text":"For 2500 år siden","correct":true},
 {"id":"b","text":"For 1000 år siden"},
 {"id":"c","text":"For 5000 år siden"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Den tidlige buddhistiske munkeordenen (sangha) spilte en nøkkelrolle i å spre Buddhas lære.', 3,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilken keiser fremmet buddhismen som statsreligion på 200-tallet fvt?', 4,
'{"choices":[
 {"id":"a","text":"Ashoka","correct":true},
 {"id":"b","text":"Augustus"},
 {"id":"c","text":"Konstantin"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilken gren av buddhismen betyr "De eldstes lære"?', 5,
'{"choices":[
 {"id":"a","text":"Mahayana"},
 {"id":"b","text":"Theravada","correct":true},
 {"id":"c","text":"Vajrayana"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ ("Den store vognen") introduserte nye idealer som bodhisattvaen.', 6,
'{"answer":"Mahayana"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Vajrayana utviklet seg med tantriske praksiser og fikk særlig fotfeste i Tibet.', 7,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-opprinnelse'
LIMIT 1;

-- Quiz 2: Grunnleggende tro og læresetninger
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Tro og læresetninger Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'buddhisme-tro';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Buddhismen er en ikke-teistisk religion – den opererer ikke med en allmektig skapergud.', 0,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva kalles "de tre juveler" som buddhister søker tilflukt i?', 1,
'{"choices":[
 {"id":"a","text":"Buddha, Dharma, Sangha","correct":true},
 {"id":"b","text":"Karma, Nirvana, Samsara"},
 {"id":"c","text":"Zen, Tantra, Yoga"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvor mange "edle sannheter" er det i buddhismen?', 2,
'{"choices":[
 {"id":"a","text":"Tre"},
 {"id":"b","text":"Fire","correct":true},
 {"id":"c","text":"Fem"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ er en tilstand av fullstendig frihet fra begjær, uvitenhet og videre gjenfødelse.', 3,
'{"answer":"Nirvana"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva kalles rekken av gjenfødelser som buddhister ønsker å bryte ut av?', 4,
'{"choices":[
 {"id":"a","text":"Karma"},
 {"id":"b","text":"Samsara","correct":true},
 {"id":"c","text":"Dharma"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'I motsetning til hinduismen lærer buddhismen at det ikke finnes noen evig sjel eller et fast "selv" (anatman).', 5,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvor mange etiske leveregler har buddhismen?', 6,
'{"choices":[
 {"id":"a","text":"Tre"},
 {"id":"b","text":"Fem","correct":true},
 {"id":"c","text":"Ti"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'En ___ er en opplyst person som velger å utsette sin endelige nirvana for å hjelpe alle andre vesener.', 7,
'{"answer":"bodhisattva"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-tro'
LIMIT 1;

-- Quiz 3: Viktige praksiser og ritualer
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Praksiser og ritualer Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'buddhisme-praksis';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva er en kjernepraksis i alle buddhistiske retninger?', 0,
'{"choices":[
 {"id":"a","text":"Meditasjon","correct":true},
 {"id":"b","text":"Pilegrimsreiser"},
 {"id":"c","text":"Faste"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'I Theravada-tradisjonen resiterer munker beskyttende tekster som kalles ___.', 1,
'{"answer":"paritta"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'I Vajrayana benyttes esoteriske metoder som mantraer og mandala-bilder i meditasjonen.', 2,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva er navnet på stedet der Buddha oppnådde oppvåkning?', 3,
'{"choices":[
 {"id":"a","text":"Lumbini"},
 {"id":"b","text":"Bodh Gaya","correct":true},
 {"id":"c","text":"Varanasi"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Munker og nonner lever etter strenge regler som kalles ___.', 4,
'{"answer":"vinaya"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Lekfolk støtter klostrene gjennom almisser og får veiledning og velsignelser til gjengjeld.', 5,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilke rituelle gaver brukes ofte i buddhistiske templer?', 6,
'{"choices":[
 {"id":"a","text":"Lys, røkelse og blomster","correct":true},
 {"id":"b","text":"Vin, brød og salt"},
 {"id":"c","text":"Gull, sølv og edelstener"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-praksis'
LIMIT 1;

-- Quiz 4: Høytider og merkedager
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Høytider Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'buddhisme-hoytider';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva er den viktigste buddhistiske høytiden?', 0,
'{"choices":[
 {"id":"a","text":"Vesak","correct":true},
 {"id":"b","text":"Ullambana"},
 {"id":"c","text":"Obon"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Vesak feires til minne om Buddhas fødsel, oppvåkning og død.', 1,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Når feires Vesak vanligvis?', 2,
'{"choices":[
 {"id":"a","text":"På fullmånedagen i april–mai","correct":true},
 {"id":"b","text":"På vintermånedagen i desember"},
 {"id":"c","text":"På nyttårsaften"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'I mahayana-tradisjoner faller nyttårsfeiringen som regel sammen med det tradisjonelle ___ i januar–februar.', 3,
'{"answer":"månenyåret"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva kalles den årlige høytiden for å ære avdøde sjeler i Mahayana-buddhismen?', 4,
'{"choices":[
 {"id":"a","text":"Vesak"},
 {"id":"b","text":"Ullambana","correct":true},
 {"id":"c","text":"Bodhi Day"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Under Ullambana samles familier i templene for å be for avdøde slektninger.', 5,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvordan markeres Vesak?', 6,
'{"choices":[
 {"id":"a","text":"Med lykter, lysdekorasjoner og tempelbesøk","correct":true},
 {"id":"b","text":"Med faste og meditasjon i ensom celle"},
 {"id":"c","text":"Med dans og sang"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-hoytider'
LIMIT 1;

-- Quiz 5: Hellige tekster og symboler
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Tekster og symboler Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'buddhisme-tekster';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva kalles buddhismens eldste tekstsamling?', 0,
'{"choices":[
 {"id":"a","text":"Tripitaka","correct":true},
 {"id":"b","text":"Vedaene"},
 {"id":"c","text":"Bhagavad Gita"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Tripitaka betyr "tre ___" på sanskrit.', 1,
'{"answer":"kurver"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvor mange samlinger består Tripitaka av?', 2,
'{"choices":[
 {"id":"a","text":"To"},
 {"id":"b","text":"Tre","correct":true},
 {"id":"c","text":"Fem"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Dharmahjulet er et hjul med åtte eiker som representerer Buddhas lære og den edle åttedelte veien.', 3,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva symboliserer lotusblomsten i buddhismen?', 4,
'{"choices":[
 {"id":"a","text":"Makt og rikdom"},
 {"id":"b","text":"Renhet og opplysning","correct":true},
 {"id":"c","text":"Sorg og lidelse"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Buddha satt under ___ da han ble opplyst.', 5,
'{"answer":"Bodhi-treet"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilke sutraer introduserte Mahayana-buddhismen?', 6,
'{"choices":[
 {"id":"a","text":"Lotus-sutraen og Hjertesutraen","correct":true},
 {"id":"b","text":"Vedaene og Upanishadene"},
 {"id":"c","text":"Torá og Talmud"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-tekster'
LIMIT 1;

-- Quiz 6: Moderne uttrykk og mangfold
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Moderne buddhisme Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'buddhisme-moderne';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvor stor prosent av jordens befolkning er buddhister?', 0,
'{"choices":[
 {"id":"a","text":"Ca. syv prosent","correct":true},
 {"id":"b","text":"Ca. femten prosent"},
 {"id":"c","text":"Ca. tyve prosent"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'I dag bor omkring 98% av buddhistene fortsatt i Asia.', 1,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'I ___ er buddhismen tett knyttet til nasjonal identitet, og Dalai Lama fungerer som leder.', 2,
'{"answer":"Tibet"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvor mange buddhister bodde i Norge i 2018?', 3,
'{"choices":[
 {"id":"a","text":"Omkring 10 000"},
 {"id":"b","text":"Omkring 40 000","correct":true},
 {"id":"c","text":"Omkring 100 000"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvem var den vietnamesiske munken som drev ikkevoldelig fredsarbeid under Vietnamkrigen?', 4,
'{"choices":[
 {"id":"a","text":"Dalai Lama"},
 {"id":"b","text":"Thich Nhat Hanh","correct":true},
 {"id":"c","text":"Ashoka"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Engasjert buddhisme forener religiøs praksis med sosial aktivisme, miljøvern og fredsarbeid.', 5,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilke verdier vektlegges i moderne buddhisme?', 6,
'{"choices":[
 {"id":"a","text":"Medfølelse, ikke-vold og en enkel livsstil","correct":true},
 {"id":"b","text":"Makt, rikdom og prestisje"},
 {"id":"c","text":"Hevn, straff og dominans"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'buddhisme-moderne'
LIMIT 1;


