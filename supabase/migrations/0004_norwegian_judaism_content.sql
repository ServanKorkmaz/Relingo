-- Norwegian Judaism Content Migration
-- Add comprehensive lessons and quizzes about Judaism in Norwegian

-- First, add Judaism to religions if not exists
INSERT INTO public.religions (slug, name, color, icon_url)
VALUES ('judaism', 'Jødedom', '#14B8A6', '/assets/religions/judaism.svg')
ON CONFLICT (slug) DO NOTHING;

-- Add detailed lessons for Judaism
INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'jodedom-opprinnelse', 'Opprinnelse og historisk bakgrunn', 'Lær om jødedommens eldgamle historie', 1, '/assets/religions/judaism.svg', 0, true
FROM public.religions WHERE slug = 'judaism';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'jodedom-tro', 'Grunnleggende tro og læresetninger', 'Utforsk monoteisme og pakten med Gud', 2, '/assets/religions/judaism.svg', 1, true
FROM public.religions WHERE slug = 'judaism';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'jodedom-praksis', 'Viktige praksiser og ritualer', 'Oppdag sabbat, kosher og daglig jødisk liv', 2, '/assets/religions/judaism.svg', 2, true
FROM public.religions WHERE slug = 'judaism';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'jodedom-hoytider', 'Høytider og merkedager', 'Utforsk Pesach, Yom Kippur og andre høytider', 2, '/assets/religions/judaism.svg', 3, true
FROM public.religions WHERE slug = 'judaism';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'jodedom-tekster', 'Hellige tekster og symboler', 'Lær om Tanakh, Talmud og jødiske symboler', 2, '/assets/religions/judaism.svg', 4, true
FROM public.religions WHERE slug = 'judaism';

INSERT INTO public.lessons (religion_id, slug, title, description, difficulty, thumbnail_url, order_index, published)
SELECT id, 'jodedom-moderne', 'Moderne uttrykk og mangfold', 'Utforsk ortodoks, reform og konservativ jødedom', 3, '/assets/religions/judaism.svg', 5, true
FROM public.religions WHERE slug = 'judaism';

-- Quiz 1: Opprinnelse og historisk bakgrunn
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Historisk bakgrunn Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'jodedom-opprinnelse';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Ifølge jødisk tradisjon inngikk patriarken ___ (ca. 1800 fvt.) en pakt med én Gud.', 0,
'{"answer":"Abraham"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvem mottok loven (Toraen) på Sinaifjellet?', 1,
'{"choices":[
 {"id":"a","text":"Abraham"},
 {"id":"b","text":"Moses","correct":true},
 {"id":"c","text":"David"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Kong Salomo bygde det første tempelet i ___.', 2,
'{"answer":"Jerusalem"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Når ødela romerne det andre tempelet?', 3,
'{"choices":[
 {"id":"a","text":"586 fvt."},
 {"id":"b","text":"70 evt.","correct":true},
 {"id":"c","text":"1948"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Holocaust under andre verdenskrig tok livet av omkring seks millioner europeiske jøder.', 4,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Når ble staten Israel etablert?', 5,
'{"choices":[
 {"id":"a","text":"1918"},
 {"id":"b","text":"1948","correct":true},
 {"id":"c","text":"1967"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-opprinnelse'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ spredningen av jøder til samfunn over hele verden.', 6,
'{"answer":"Diaspora"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-opprinnelse'
LIMIT 1;

-- Quiz 2: Grunnleggende tro og læresetninger
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Tro og læresetninger Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'jodedom-tro';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Jødedommen er strengt monoteistisk.', 0,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Et sentralt konsept er ___ (brit) mellom Gud og det jødiske folk.', 1,
'{"answer":"pakten"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvor mange bud eller mitsvot har jøder ifølge tradisjonen?', 2,
'{"choices":[
 {"id":"a","text":"10"},
 {"id":"b","text":"248"},
 {"id":"c","text":"613","correct":true}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Jødedommen har et konsept om arvesynd.', 3,
'{"answer": false}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva vektlegges mest i jødedommen?', 4,
'{"choices":[
 {"id":"a","text":"Handling og rett livsførsel","correct":true},
 {"id":"b","text":"Kun tro og dogmer"},
 {"id":"c","text":"Kun ritualer"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Forsoningsdagen heter ___ på hebraisk.', 5,
'{"answer":"Yom Kippur"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-tro'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Tradisjonelt venter jøder på en Messias som skal skape fred og frihet.', 6,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-tro'
LIMIT 1;

-- Quiz 3: Viktige praksiser og ritualer
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Praksiser og ritualer Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'jodedom-praksis';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvor mange ganger om dagen er tradisjonelle bønner i jødedommen?', 0,
'{"choices":[
 {"id":"a","text":"En gang"},
 {"id":"b","text":"Tre ganger","correct":true},
 {"id":"c","text":"Fem ganger"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ er den jødiske kalottes som menn ofte dekker hodet med.', 1,
'{"answer":"Kippa"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Sabbaten (shabbat) er den viktigste ukentlige hviledagen og varer fra fredag kveld til lørdag kveld.', 2,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilket mat er ikke kosher?', 3,
'{"choices":[
 {"id":"a","text":"Kylling"},
 {"id":"b","text":"Fisk med skjell"},
 {"id":"c","text":"Svinekjøtt","correct":true}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Gutter blir omskåret på sin åttende levedag i ritualet kalt ___.', 4,
'{"answer":"brit milah"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Ved hvilken alder feirer jøder bar/bat mitzva?', 5,
'{"choices":[
 {"id":"a","text":"8 år"},
 {"id":"b","text":"12-13 år","correct":true},
 {"id":"c","text":"18 år"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-praksis'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Under sabbaten skal man avstå fra arbeid og verdslige sysler.', 6,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-praksis'
LIMIT 1;

-- Quiz 4: Høytider og merkedager
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Høytider Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'jodedom-hoytider';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ (påske) er vårfesten til minne om utgangen fra Egypt.', 0,
'{"answer":"Pesach"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva er Yom Kippur?', 1,
'{"choices":[
 {"id":"a","text":"Lysfesten"},
 {"id":"b","text":"Forsoningsdagen","correct":true},
 {"id":"c","text":"Nyttår"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Under Yom Kippur faster jøder i cirka 25 timer.', 2,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ er den åtte dager lange lysfesten til minne om gjeninnvielsen av Tempelet.', 3,
'{"answer":"Hanukka"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilket horn blåses under Rosh Hashana?', 4,
'{"choices":[
 {"id":"a","text":"Trompet"},
 {"id":"b","text":"Shofar","correct":true},
 {"id":"c","text":"Fløyte"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Purim feires til minne om dronning Esters redning av jødene i Persia.', 5,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva bygger familier under Sukkot?', 6,
'{"choices":[
 {"id":"a","text":"Snøhytter"},
 {"id":"b","text":"Løvhytter","correct":true},
 {"id":"c","text":"Telt"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-hoytider'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Rosh Hashana er jødisk ___ og markerer begynnelsen på det nye året.', 7,
'{"answer":"nyttår"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-hoytider'
LIMIT 1;

-- Quiz 5: Hellige tekster og symboler
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Tekster og symboler Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'jodedom-tekster';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___, også kalt Den hebraiske bibel, er jødedommens viktigste samling av hellige skrifter.', 0,
'{"answer":"Tanakh"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva består Tanakh av?', 1,
'{"choices":[
 {"id":"a","text":"Kun Toraen"},
 {"id":"b","text":"Toraen, Nevi''im og Ketuvim","correct":true},
 {"id":"c","text":"Kun Talmud"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Toraen består av de fem Mosebøkene.', 2,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ er en omfattende samling av muntlige lover og tolkninger som ble nedskrevet ca. 200-500 evt.', 3,
'{"answer":"Talmud"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva er Davidstjernen?', 4,
'{"choices":[
 {"id":"a","text":"En femkantet stjerne"},
 {"id":"b","text":"En sekskantet stjerne formet av to trekanter","correct":true},
 {"id":"c","text":"En åttekantet stjerne"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Menoraen er en syvarmet ljusstake som er et av de eldste symbolene i jødedommen.', 5,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'En ___ er en liten beholder med skriftsteder som henger på dørkarmen i jødiske hjem.', 6,
'{"answer":"mezuza"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-tekster'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva kalles det "evige lys" som henger tent i synagogen?', 7,
'{"choices":[
 {"id":"a","text":"Shofar"},
 {"id":"b","text":"Ner Tamid","correct":true},
 {"id":"c","text":"Tallit"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-tekster'
LIMIT 1;

-- Quiz 6: Moderne uttrykk og mangfold
INSERT INTO public.quizzes (lesson_id, title, order_index, published)
SELECT l.id, 'Moderne mangfold Quiz', 0, true
FROM public.lessons l
WHERE l.slug = 'jodedom-moderne';

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hvilken retning holder fast ved at Toraen er guddommelig og uforanderlig?', 0,
'{"choices":[
 {"id":"a","text":"Reformjødedom"},
 {"id":"b","text":"Ortodoks jødedom","correct":true},
 {"id":"c","text":"Humanistisk jødedom"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Reformjødedom tillater kvinnelige rabbinere.', 1,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', '___ jødedom oppstod som en mellomposisjon mellom ortodoks og reformert jødedom.', 2,
'{"answer":"Konservativ"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Når ble den første kvinnelige rabbiner ordinert?', 3,
'{"choices":[
 {"id":"a","text":"1885"},
 {"id":"b","text":"1935","correct":true},
 {"id":"c","text":"1985"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Ultraortodokse (haredim) lever mer isolert for å unngå påvirkning utenfra.', 4,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Hva er askenasiske jøder?', 5,
'{"choices":[
 {"id":"a","text":"Jøder med opphav i Europa","correct":true},
 {"id":"b","text":"Jøder fra Afrika"},
 {"id":"c","text":"Jøder fra Asia"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Tradisjonelt regnes en person som jøde dersom vedkommende er født av en jødisk ___.', 6,
'{"answer":"mor"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-moderne'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Man kan være jøde uten å være religiøs, da jødedommen forstås både som religion og som et folk.', 7,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'jodedom-moderne'
LIMIT 1;