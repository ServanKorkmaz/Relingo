-- Populate English translations for existing questions
-- This provides a starting point - you can refine these translations later

-- Christianity Intro Quiz - English
UPDATE public.questions SET 
  prompt_en = 'Christianity is the world''s largest religion.',
  meta_en = '{"answer": true}'::jsonb
WHERE prompt = 'Kristendommen er verdens største religion.';

UPDATE public.questions SET 
  prompt_en = 'What is the Christian holy book called?',
  meta_en = '{"choices":[
    {"id":"a","text":"The Quran"},
    {"id":"b","text":"The Bible","correct":true},
    {"id":"c","text":"The Torah"}
  ]}'::jsonb
WHERE prompt = 'Hva heter kristendommens hellige bok?';

UPDATE public.questions SET 
  prompt_en = 'Christianity is based on the teachings of ___.',
  meta_en = '{"answer":"Jesus"}'::jsonb
WHERE prompt = 'Kristendommen er basert på læren til ___.';

UPDATE public.questions SET 
  prompt_en = 'How many main branches does Christianity have?',
  meta_en = '{"choices":[
    {"id":"a","text":"Two"},
    {"id":"b","text":"Three","correct":true},
    {"id":"c","text":"Five"}
  ]}'::jsonb
WHERE prompt = 'Hvor mange hovedgrener har kristendommen?';

UPDATE public.questions SET 
  prompt_en = 'The cross is a central symbol in Christianity.',
  meta_en = '{"answer": true}'::jsonb
WHERE prompt = 'Korset er et sentralt symbol i kristendommen.';

-- Islam Intro Quiz - English
UPDATE public.questions SET 
  prompt_en = 'Islam is the world''s second-largest religion.',
  meta_en = '{"answer": true}'::jsonb
WHERE prompt = 'Islam er verdens nest største religion.';

UPDATE public.questions SET 
  prompt_en = 'What is the Islamic holy book called?',
  meta_en = '{"choices":[
    {"id":"a","text":"The Bible"},
    {"id":"b","text":"The Quran","correct":true},
    {"id":"c","text":"The Vedas"}
  ]}'::jsonb
WHERE prompt = 'Hva heter islams hellige bok?';

UPDATE public.questions SET 
  prompt_en = 'Islam was founded by the prophet ___.',
  meta_en = '{"answer":"Muhammad"}'::jsonb
WHERE prompt = 'Islam ble grunnlagt av profeten ___.';

UPDATE public.questions SET 
  prompt_en = 'How many pillars does Islam have?',
  meta_en = '{"choices":[
    {"id":"a","text":"Three"},
    {"id":"b","text":"Five","correct":true},
    {"id":"c","text":"Seven"}
  ]}'::jsonb
WHERE prompt = 'Hvor mange søyler har islam?';

UPDATE public.questions SET 
  prompt_en = 'Muslims pray towards Mecca.',
  meta_en = '{"answer": true}'::jsonb
WHERE prompt = 'Muslimer ber mot Mekka.';

-- Hinduism Intro Quiz - English
UPDATE public.questions SET 
  prompt_en = 'Hinduism is one of the world''s oldest religions.',
  meta_en = '{"answer": true}'::jsonb
WHERE prompt = 'Hinduisme er en av verdens eldste religioner.';

UPDATE public.questions SET 
  prompt_en = 'What characterizes Hinduism''s origins?',
  meta_en = '{"choices":[
    {"id":"a","text":"It has one single founder"},
    {"id":"b","text":"It has no single founder and developed over thousands of years","correct":true},
    {"id":"c","text":"It began in Egypt"}
  ]}'::jsonb
WHERE prompt = 'Hva kjennetegner hinduismens opprinnelse?';

UPDATE public.questions SET 
  prompt_en = 'The belief in ___ (reincarnation) is central to Hinduism.',
  meta_en = '{"answer":"rebirth"}'::jsonb
WHERE prompt = 'Troen på ___ (reinkarnasjon) er sentral i hinduismen.';

UPDATE public.questions SET 
  prompt_en = 'Daily worship in Hinduism is called ___.',
  meta_en = '{"answer":"puja"}'::jsonb
WHERE prompt = 'Daglig tilbedelse i hinduismen kalles ___.';

-- Judaism Intro Quiz - English
UPDATE public.questions SET 
  prompt_en = 'Judaism is the oldest of the Abrahamic religions.',
  meta_en = '{"answer": true}'::jsonb
WHERE prompt = 'Jødedommen er den eldste av de abrahamittiske religionene.';

UPDATE public.questions SET 
  prompt_en = 'What is the Jewish holy book called?',
  meta_en = '{"choices":[
    {"id":"a","text":"The Bible"},
    {"id":"b","text":"The Tanakh","correct":true},
    {"id":"c","text":"The Quran"}
  ]}'::jsonb
WHERE prompt = 'Hva heter jødedommens hellige bok?';

UPDATE public.questions SET 
  prompt_en = 'Judaism is based on belief in ___ God.',
  meta_en = '{"answer":"one"}'::jsonb
WHERE prompt = 'Jødedommen er basert på troen på ___ Gud.';

-- Buddhism Intro Quiz - English  
UPDATE public.questions SET 
  prompt_en = 'Where did Buddhism originate?',
  meta_en = '{"choices":[
    {"id":"a","text":"China"},
    {"id":"b","text":"North India","correct":true},
    {"id":"c","text":"Tibet"}
  ]}'::jsonb
WHERE prompt = 'Hvor oppstod buddhismen?';

UPDATE public.questions SET 
  prompt_en = 'Buddhism was founded by ___ Gautama, who later became known as Buddha.',
  meta_en = '{"answer":"Siddhartha"}'::jsonb
WHERE prompt = 'Buddhismen ble grunnlagt av ___ Gautama, som senere ble kjent som Buddha.';

UPDATE public.questions SET 
  prompt_en = 'Approximately how long ago did Buddhism originate?',
  meta_en = '{"choices":[
    {"id":"a","text":"2500 years ago","correct":true},
    {"id":"b","text":"1000 years ago"},
    {"id":"c","text":"5000 years ago"}
  ]}'::jsonb
WHERE prompt = 'For omtrent hvor lenge siden oppstod buddhismen?';

-- Add more translations as needed
-- This is a starting template - you can add the rest of the questions later

