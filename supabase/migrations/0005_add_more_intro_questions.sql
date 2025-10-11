-- Add more questions to intro quizzes
-- The initial migration only created 1 question per quiz, which is not enough for a proper quiz experience

-- Add more questions for Christianity intro quiz
INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Christianity is based on the life and teachings of Jesus Christ.', 2,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'intro-christianity'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'What is the holy book of Christianity?', 3,
'{"choices":[
 {"id":"a","text":"Quran"},
 {"id":"b","text":"The Bible","correct":true},
 {"id":"c","text":"Torah"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'intro-christianity'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Christians believe in one God in three persons: Father, Son, and Holy ___.', 4,
'{"answer":"Spirit"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'intro-christianity'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'What is the Christian day of worship?', 5,
'{"choices":[
 {"id":"a","text":"Friday"},
 {"id":"b","text":"Saturday"},
 {"id":"c","text":"Sunday","correct":true}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'intro-christianity'
LIMIT 1;

-- Add more questions for Islam intro quiz
INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Islam is a monotheistic religion.', 2,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'intro-islam'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'What is the holy book of Islam?', 3,
'{"choices":[
 {"id":"a","text":"The Bible"},
 {"id":"b","text":"The Quran","correct":true},
 {"id":"c","text":"The Torah"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'intro-islam'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'Muslims pray ___ times a day.', 4,
'{"answer":"five"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'intro-islam'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'What is the pilgrimage to Mecca called?', 5,
'{"choices":[
 {"id":"a","text":"Hajj","correct":true},
 {"id":"b","text":"Salah"},
 {"id":"c","text":"Zakat"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'intro-islam'
LIMIT 1;

-- Add more questions for Hinduism intro quiz
INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'tf', 'Hinduism is one of the world''s oldest religions.', 2,
'{"answer": true}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'intro-hinduism'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'What is the concept of rebirth in Hinduism called?', 3,
'{"choices":[
 {"id":"a","text":"Karma"},
 {"id":"b","text":"Reincarnation","correct":true},
 {"id":"c","text":"Nirvana"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'intro-hinduism'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'gap', 'In Hinduism, the concept of duty and righteous living is called ___.', 4,
'{"answer":"dharma"}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'intro-hinduism'
LIMIT 1;

INSERT INTO public.questions (quiz_id, type, prompt, order_index, meta)
SELECT q.id, 'mcq', 'Which river is considered sacred in Hinduism?', 5,
'{"choices":[
 {"id":"a","text":"Nile"},
 {"id":"b","text":"Ganges","correct":true},
 {"id":"c","text":"Jordan"}]}'::jsonb
FROM public.quizzes q
JOIN public.lessons l ON l.id = q.lesson_id
WHERE l.slug = 'intro-hinduism'
LIMIT 1;

