-- Fix Islam and Christianity intro quiz translations
-- These quizzes were created with English prompts instead of Norwegian,
-- so the translation migrations didn't match them. This migration fixes that.

-- ==================== ISLAM INTRO QUIZ ====================

-- Question 1: What does "Allah" mean?
UPDATE public.questions SET
  prompt = 'Hva betyr "Allah"?',
  prompt_en = 'What does "Allah" mean?',
  prompt_tr = '"Allah" ne anlama gelir?',
  meta = '{"choices":[
    {"id":"a","text":"Profeten"},
    {"id":"b","text":"Gud","correct":true},
    {"id":"c","text":"Bønnetid"}
  ]}'::jsonb,
  meta_en = '{"choices":[
    {"id":"a","text":"The Prophet"},
    {"id":"b","text":"God","correct":true},
    {"id":"c","text":"Prayer time"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Peygamber"},
    {"id":"b","text":"Tanrı","correct":true},
    {"id":"c","text":"Namaz vakti"}
  ]}'::jsonb
WHERE prompt = 'What does "Allah" mean?'
  AND type = 'mcq';

-- Question 2: Islam is a monotheistic religion
UPDATE public.questions SET
  prompt = 'Islam er en monoteistisk religion.',
  prompt_en = 'Islam is a monotheistic religion.',
  prompt_tr = 'İslam tek tanrılı bir dindir.',
  meta = '{"answer": true}'::jsonb,
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Islam is a monotheistic religion.'
  AND type = 'tf';

-- Question 3: What is the holy book of Islam?
UPDATE public.questions SET
  prompt = 'Hva heter islams hellige bok?',
  prompt_en = 'What is the holy book of Islam?',
  prompt_tr = 'İslam''ın kutsal kitabı nedir?',
  meta = '{"choices":[
    {"id":"a","text":"Bibelen"},
    {"id":"b","text":"Koranen","correct":true},
    {"id":"c","text":"Torá"}
  ]}'::jsonb,
  meta_en = '{"choices":[
    {"id":"a","text":"The Bible"},
    {"id":"b","text":"The Quran","correct":true},
    {"id":"c","text":"The Torah"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"İncil"},
    {"id":"b","text":"Kuran","correct":true},
    {"id":"c","text":"Tevrat"}
  ]}'::jsonb
WHERE prompt = 'What is the holy book of Islam?'
  AND type = 'mcq';

-- Question 4: Muslims pray ___ times a day
UPDATE public.questions SET
  prompt = 'Muslimer ber ___ ganger om dagen.',
  prompt_en = 'Muslims pray ___ times a day.',
  prompt_tr = 'Müslümanlar günde ___ kez namaz kılarlar.',
  meta = '{"answer":"fem"}'::jsonb,
  meta_en = '{"answer":"five"}'::jsonb,
  meta_tr = '{"answer":"beş"}'::jsonb
WHERE prompt = 'Muslims pray ___ times a day.'
  AND type = 'gap';

-- Question 5: What is the pilgrimage to Mecca called?
UPDATE public.questions SET
  prompt = 'Hva kalles pilegrimsreisen til Mekka?',
  prompt_en = 'What is the pilgrimage to Mecca called?',
  prompt_tr = 'Mekke''ye yapılan hac yolculuğuna ne denir?',
  meta = '{"choices":[
    {"id":"a","text":"Hajj","correct":true},
    {"id":"b","text":"Salah"},
    {"id":"c","text":"Zakat"}
  ]}'::jsonb,
  meta_en = '{"choices":[
    {"id":"a","text":"Hajj","correct":true},
    {"id":"b","text":"Salah"},
    {"id":"c","text":"Zakat"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Hac","correct":true},
    {"id":"b","text":"Namaz"},
    {"id":"c","text":"Zekat"}
  ]}'::jsonb
WHERE prompt = 'What is the pilgrimage to Mecca called?'
  AND type = 'mcq';

-- ==================== CHRISTIANITY INTRO QUIZ ====================

-- Question 1: The New Testament is part of the Christian Bible
UPDATE public.questions SET
  prompt = 'Det nye testamentet er en del av den kristne bibelen.',
  prompt_en = 'The New Testament is part of the Christian Bible.',
  prompt_tr = 'Yeni Ahit Hıristiyan İncil''inin bir parçasıdır.',
  meta = '{"answer": true}'::jsonb,
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'The New Testament is part of the Christian Bible.'
  AND type = 'tf';

-- Question 2: Christianity is based on the life and teachings of Jesus Christ
UPDATE public.questions SET
  prompt = 'Kristendommen er basert på livet og læren til Jesus Kristus.',
  prompt_en = 'Christianity is based on the life and teachings of Jesus Christ.',
  prompt_tr = 'Hıristiyanlık İsa Mesih''in yaşamı ve öğretilerine dayanır.',
  meta = '{"answer": true}'::jsonb,
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Christianity is based on the life and teachings of Jesus Christ.'
  AND type = 'tf';

-- Question 3: What is the holy book of Christianity?
UPDATE public.questions SET
  prompt = 'Hva heter kristendommens hellige bok?',
  prompt_en = 'What is the holy book of Christianity?',
  prompt_tr = 'Hıristiyanlığın kutsal kitabı nedir?',
  meta = '{"choices":[
    {"id":"a","text":"Koranen"},
    {"id":"b","text":"Bibelen","correct":true},
    {"id":"c","text":"Torá"}
  ]}'::jsonb,
  meta_en = '{"choices":[
    {"id":"a","text":"Quran"},
    {"id":"b","text":"The Bible","correct":true},
    {"id":"c","text":"Torah"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Kuran"},
    {"id":"b","text":"İncil","correct":true},
    {"id":"c","text":"Tevrat"}
  ]}'::jsonb
WHERE prompt = 'What is the holy book of Christianity?'
  AND type = 'mcq';

-- Question 4: Christians believe in one God in three persons: Father, Son, and Holy ___
UPDATE public.questions SET
  prompt = 'Kristne tror på én Gud i tre personer: Fader, Sønn og Den Hellige ___.',
  prompt_en = 'Christians believe in one God in three persons: Father, Son, and Holy ___.',
  prompt_tr = 'Hıristiyanlar üç kişide bir Tanrı''ya inanırlar: Baba, Oğul ve Kutsal ___.',
  meta = '{"answer":"Ånd"}'::jsonb,
  meta_en = '{"answer":"Spirit"}'::jsonb,
  meta_tr = '{"answer":"Ruh"}'::jsonb
WHERE prompt = 'Christians believe in one God in three persons: Father, Son, and Holy ___.'
  AND type = 'gap';

-- Question 5: What is the Christian day of worship?
UPDATE public.questions SET
  prompt = 'Hvilken dag er den kristne tilbedelsesdagen?',
  prompt_en = 'What is the Christian day of worship?',
  prompt_tr = 'Hıristiyanların ibadet günü hangi gündür?',
  meta = '{"choices":[
    {"id":"a","text":"Fredag"},
    {"id":"b","text":"Lørdag"},
    {"id":"c","text":"Søndag","correct":true}
  ]}'::jsonb,
  meta_en = '{"choices":[
    {"id":"a","text":"Friday"},
    {"id":"b","text":"Saturday"},
    {"id":"c","text":"Sunday","correct":true}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Cuma"},
    {"id":"b","text":"Cumartesi"},
    {"id":"c","text":"Pazar","correct":true}
  ]}'::jsonb
WHERE prompt = 'What is the Christian day of worship?'
  AND type = 'mcq';

-- ==================== HINDUISM INTRO QUIZ ====================

-- Question 1 (from 0001_init.sql): In Hinduism, "___" refers to duty/ethical responsibility
UPDATE public.questions SET
  prompt = 'I hinduismen refererer "___" til plikt/etisk ansvar.',
  prompt_en = 'In Hinduism, "___" refers to duty/ethical responsibility.',
  prompt_tr = 'Hinduizm''de "___" görev/etik sorumluluğu ifade eder.',
  meta = '{"answer":"dharma"}'::jsonb,
  meta_en = '{"answer":"dharma"}'::jsonb,
  meta_tr = '{"answer":"dharma"}'::jsonb
WHERE prompt = 'In Hinduism, "___" refers to duty/ethical responsibility.'
  AND type = 'gap';

-- Question 2: Hinduism is one of the world's oldest religions
UPDATE public.questions SET
  prompt = 'Hinduismen er en av verdens eldste religioner.',
  prompt_en = 'Hinduism is one of the world''s oldest religions.',
  prompt_tr = 'Hinduizm dünyanın en eski dinlerinden biridir.',
  meta = '{"answer": true}'::jsonb,
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Hinduism is one of the world''s oldest religions.'
  AND type = 'tf';

-- Question 3: What is the concept of rebirth in Hinduism called?
UPDATE public.questions SET
  prompt = 'Hva kalles konseptet med gjenfødelse i hinduismen?',
  prompt_en = 'What is the concept of rebirth in Hinduism called?',
  prompt_tr = 'Hinduizm''de yeniden doğuş kavramına ne denir?',
  meta = '{"choices":[
    {"id":"a","text":"Karma"},
    {"id":"b","text":"Reinkarnasjon","correct":true},
    {"id":"c","text":"Nirvana"}
  ]}'::jsonb,
  meta_en = '{"choices":[
    {"id":"a","text":"Karma"},
    {"id":"b","text":"Reincarnation","correct":true},
    {"id":"c","text":"Nirvana"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Karma"},
    {"id":"b","text":"Reenkarnasyon","correct":true},
    {"id":"c","text":"Nirvana"}
  ]}'::jsonb
WHERE prompt = 'What is the concept of rebirth in Hinduism called?'
  AND type = 'mcq';

-- Question 4: In Hinduism, the concept of duty and righteous living is called ___
UPDATE public.questions SET
  prompt = 'I hinduismen kalles konseptet med plikt og rettferdig liv ___.',
  prompt_en = 'In Hinduism, the concept of duty and righteous living is called ___.',
  prompt_tr = 'Hinduizm''de görev ve doğru yaşam kavramına ___ denir.',
  meta = '{"answer":"dharma"}'::jsonb,
  meta_en = '{"answer":"dharma"}'::jsonb,
  meta_tr = '{"answer":"dharma"}'::jsonb
WHERE prompt = 'In Hinduism, the concept of duty and righteous living is called ___.'
  AND type = 'gap';

-- Question 5: Which river is considered sacred in Hinduism?
UPDATE public.questions SET
  prompt = 'Hvilken elv anses som hellig i hinduismen?',
  prompt_en = 'Which river is considered sacred in Hinduism?',
  prompt_tr = 'Hinduizm''de hangi nehir kutsal kabul edilir?',
  meta = '{"choices":[
    {"id":"a","text":"Nilen"},
    {"id":"b","text":"Ganges","correct":true},
    {"id":"c","text":"Jordan"}
  ]}'::jsonb,
  meta_en = '{"choices":[
    {"id":"a","text":"Nile"},
    {"id":"b","text":"Ganges","correct":true},
    {"id":"c","text":"Jordan"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Nil"},
    {"id":"b","text":"Ganj","correct":true},
    {"id":"c","text":"Ürdün"}
  ]}'::jsonb
WHERE prompt = 'Which river is considered sacred in Hinduism?'
  AND type = 'mcq';

