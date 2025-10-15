-- Populate Turkish translations for existing questions
-- Bu dosya mevcut sorular için Türkçe çeviriler içerir

-- Christianity Intro Quiz - Turkish
UPDATE public.questions SET 
  prompt_tr = 'Hıristiyanlık dünyanın en büyük dinidir.',
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Kristendommen er verdens største religion.';

UPDATE public.questions SET 
  prompt_tr = 'Hıristiyan kutsal kitabına ne denir?',
  meta_tr = '{"choices":[
    {"id":"a","text":"Kuran"},
    {"id":"b","text":"İncil","correct":true},
    {"id":"c","text":"Tevrat"}
  ]}'::jsonb
WHERE prompt = 'Hva heter kristendommens hellige bok?';

UPDATE public.questions SET 
  prompt_tr = 'Hıristiyanlık ___ öğretilerine dayanır.',
  meta_tr = '{"answer":"İsa"}'::jsonb
WHERE prompt = 'Kristendommen er basert på læren til ___.';

UPDATE public.questions SET 
  prompt_tr = 'Hıristiyanlığın kaç ana dalı vardır?',
  meta_tr = '{"choices":[
    {"id":"a","text":"İki"},
    {"id":"b","text":"Üç","correct":true},
    {"id":"c","text":"Beş"}
  ]}'::jsonb
WHERE prompt = 'Hvor mange hovedgrener har kristendommen?';

UPDATE public.questions SET 
  prompt_tr = 'Haç Hıristiyanlıkta merkezi bir semboldür.',
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Korset er et sentralt symbol i kristendommen.';

-- Islam Intro Quiz - Turkish
UPDATE public.questions SET 
  prompt_tr = 'İslam dünyanın ikinci en büyük dinidir.',
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Islam er verdens nest største religion.';

UPDATE public.questions SET 
  prompt_tr = 'İslam''ın kutsal kitabına ne denir?',
  meta_tr = '{"choices":[
    {"id":"a","text":"İncil"},
    {"id":"b","text":"Kuran","correct":true},
    {"id":"c","text":"Vedalar"}
  ]}'::jsonb
WHERE prompt = 'Hva heter islams hellige bok?';

UPDATE public.questions SET 
  prompt_tr = 'İslam peygamber ___ tarafından kuruldu.',
  meta_tr = '{"answer":"Muhammed"}'::jsonb
WHERE prompt = 'Islam ble grunnlagt av profeten ___.';

UPDATE public.questions SET 
  prompt_tr = 'İslam''ın kaç direği vardır?',
  meta_tr = '{"choices":[
    {"id":"a","text":"Üç"},
    {"id":"b","text":"Beş","correct":true},
    {"id":"c","text":"Yedi"}
  ]}'::jsonb
WHERE prompt = 'Hvor mange søyler har islam?';

UPDATE public.questions SET 
  prompt_tr = 'Müslümanlar Mekke''ye doğru namaz kılarlar.',
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Muslimer ber mot Mekka.';

-- Hinduism Intro Quiz - Turkish
UPDATE public.questions SET 
  prompt_tr = 'Hinduizm dünyanın en eski dinlerinden biridir.',
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Hinduisme er en av verdens eldste religioner.';

UPDATE public.questions SET 
  prompt_tr = 'Hinduizm''in kökenlerini ne karakterize eder?',
  meta_tr = '{"choices":[
    {"id":"a","text":"Tek bir kurucusu var"},
    {"id":"b","text":"Tek bir kurucusu yok ve binlerce yıl içinde gelişti","correct":true},
    {"id":"c","text":"Mısır''da başladı"}
  ]}'::jsonb
WHERE prompt = 'Hva kjennetegner hinduismens opprinnelse?';

UPDATE public.questions SET 
  prompt_tr = '___ (reenkarnasyon) inancı Hinduizm için merkezidir.',
  meta_tr = '{"answer":"yeniden doğuş"}'::jsonb
WHERE prompt = 'Troen på ___ (reinkarnasjon) er sentral i hinduismen.';

UPDATE public.questions SET 
  prompt_tr = 'Hinduizm''de günlük ibadete ___ denir.',
  meta_tr = '{"answer":"puja"}'::jsonb
WHERE prompt = 'Daglig tilbedelse i hinduismen kalles ___.';

-- Judaism Intro Quiz - Turkish
UPDATE public.questions SET 
  prompt_tr = 'Yahudilik İbrahimi dinlerin en eskisidir.',
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Jødedommen er den eldste av de abrahamittiske religionene.';

UPDATE public.questions SET 
  prompt_tr = 'Yahudi kutsal kitabına ne denir?',
  meta_tr = '{"choices":[
    {"id":"a","text":"İncil"},
    {"id":"b","text":"Tanah","correct":true},
    {"id":"c","text":"Kuran"}
  ]}'::jsonb
WHERE prompt = 'Hva heter jødedommens hellige bok?';

UPDATE public.questions SET 
  prompt_tr = 'Yahudilik ___ Tanrı''ya inanmaya dayanır.',
  meta_tr = '{"answer":"bir"}'::jsonb
WHERE prompt = 'Jødedommen er basert på troen på ___ Gud.';

-- Buddhism Intro Quiz - Turkish
UPDATE public.questions SET 
  prompt_tr = 'Budizm nerede ortaya çıktı?',
  meta_tr = '{"choices":[
    {"id":"a","text":"Çin"},
    {"id":"b","text":"Kuzey Hindistan","correct":true},
    {"id":"c","text":"Tibet"}
  ]}'::jsonb
WHERE prompt = 'Hvor oppstod buddhismen?';

UPDATE public.questions SET 
  prompt_tr = 'Budizm, daha sonra Buda olarak bilinen ___ Gautama tarafından kuruldu.',
  meta_tr = '{"answer":"Siddhartha"}'::jsonb
WHERE prompt = 'Buddhismen ble grunnlagt av ___ Gautama, som senere ble kjent som Buddha.';

UPDATE public.questions SET 
  prompt_tr = 'Budizm yaklaşık ne kadar zaman önce ortaya çıktı?',
  meta_tr = '{"choices":[
    {"id":"a","text":"2500 yıl önce","correct":true},
    {"id":"b","text":"1000 yıl önce"},
    {"id":"c","text":"5000 yıl önce"}
  ]}'::jsonb
WHERE prompt = 'For omtrent hvor lenge siden oppstod buddhismen?';

-- Add more translations as needed

