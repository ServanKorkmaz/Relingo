-- Add English and Turkish translations for ALL quiz questions
-- This migration adds prompt_en, prompt_tr, meta_en, and meta_tr for all questions
-- that currently only have Norwegian text

-- ==================== CHRISTIANITY LESSONS ====================

-- kristendom-opprinnelse (Origins) - Question 1
UPDATE public.questions SET
  prompt_en = 'When did Christianity originate?',
  prompt_tr = 'Hıristiyanlık ne zaman ortaya çıktı?',
  meta_en = '{"choices":[
    {"id":"a","text":"Around year 30 CE","correct":true},
    {"id":"b","text":"Around year 100 BCE"},
    {"id":"c","text":"Around year 500 CE"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"MS 30 civarında","correct":true},
    {"id":"b","text":"MÖ 100 civarında"},
    {"id":"c","text":"MS 500 civarında"}
  ]}'::jsonb
WHERE prompt = 'Når oppsto kristendommen?'
  AND type = 'mcq';

-- kristendom-opprinnelse - Question 2
UPDATE public.questions SET
  prompt_en = 'Where did Christianity originate?',
  prompt_tr = 'Hıristiyanlık nerede ortaya çıktı?',
  meta_en = '{"choices":[
    {"id":"a","text":"In Egypt"},
    {"id":"b","text":"In Jewish Palestine","correct":true},
    {"id":"c","text":"In Rome"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Mısır''da"},
    {"id":"b","text":"Yahudi Filistin''inde","correct":true},
    {"id":"c","text":"Roma''da"}
  ]}'::jsonb
WHERE prompt = 'Hvor oppsto kristendommen?'
  AND type = 'mcq';

-- kristendom-opprinnelse - Question 3
UPDATE public.questions SET
  prompt_en = 'Jesus was executed by crucifixion, but his followers proclaimed that he rose from the dead.',
  prompt_tr = 'İsa çarmıha gerilerek idam edildi, ancak takipçileri onun ölümden dirildiğini ilan etti.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Jesus ble henrettet ved korsfestelse, men hans tilhengere forkynte at han stod opp fra de døde.'
  AND type = 'tf';

-- kristendom-opprinnelse - Question 4
UPDATE public.questions SET
  prompt_en = 'Which emperor introduced religious freedom and ended the persecution of Christians in 313 CE?',
  prompt_tr = 'Hangi imparator MS 313''te dini özgürlüğü getirdi ve Hıristiyanların zulmünü sona erdirdi?',
  meta_en = '{"choices":[
    {"id":"a","text":"Augustus"},
    {"id":"b","text":"Constantine the Great","correct":true},
    {"id":"c","text":"Nero"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Augustus"},
    {"id":"b","text":"Büyük Konstantin","correct":true},
    {"id":"c","text":"Neron"}
  ]}'::jsonb
WHERE prompt = 'Hvilken keiser innførte religionsfrihet og gjorde slutt på forfølgelsene av kristne i 313 e.Kr.?'
  AND type = 'mcq';

-- kristendom-opprinnelse - Question 5
UPDATE public.questions SET
  prompt_en = 'In ___ CE, Emperor Theodosius declared Christianity the Roman state religion.',
  prompt_tr = 'MS ___ yılında İmparator Theodosius Hıristiyanlığı Roma devlet dini ilan etti.',
  meta_en = '{"answer":"380"}'::jsonb,
  meta_tr = '{"answer":"380"}'::jsonb
WHERE prompt = 'I ___ e.Kr. erklærte keiser Theodosius kristendommen som romersk statsreligion.'
  AND type = 'gap';

-- kristendom-opprinnelse - Question 6
UPDATE public.questions SET
  prompt_en = 'When did the Great Schism between the Western and Eastern Church occur?',
  prompt_tr = 'Batı ve Doğu Kilisesi arasındaki Büyük Ayrılık ne zaman gerçekleşti?',
  meta_en = '{"choices":[
    {"id":"a","text":"1054","correct":true},
    {"id":"b","text":"1517"},
    {"id":"c","text":"313"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"1054","correct":true},
    {"id":"b","text":"1517"},
    {"id":"c","text":"313"}
  ]}'::jsonb
WHERE prompt = 'Når skjedde det store skisma mellom Vestkirken og Østkirken?'
  AND type = 'mcq';

-- kristendom-opprinnelse - Question 7
UPDATE public.questions SET
  prompt_en = 'In the 1500s, the ___, led by Martin Luther, led to new Protestant denominations breaking away from the Catholic Church.',
  prompt_tr = '1500''lerde Martin Luther''in öncülük ettiği ___, Katolik Kilisesi''nden ayrılan yeni Protestan mezheplerinin oluşmasına yol açtı.',
  meta_en = '{"answer":"Reformation"}'::jsonb,
  meta_tr = '{"answer":"Reformasyon"}'::jsonb
WHERE prompt = 'På 1500-tallet førte ___, anført av Martin Luther, til at nye protestantiske kirkesamfunn brøt ut fra den katolske kirke.'
  AND type = 'gap';

-- kristendom-tro (Beliefs) - Question 1
UPDATE public.questions SET
  prompt_en = 'Christianity is a monotheistic religion.',
  prompt_tr = 'Hıristiyanlık tek tanrılı bir dindir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Kristendommen er en monoteistisk religion.'
  AND type = 'tf'
  AND order_index = 0
  AND quiz_id IN (
    SELECT q.id FROM public.quizzes q
    JOIN public.lessons l ON l.id = q.lesson_id
    WHERE l.slug = 'kristendom-tro'
  );

-- kristendom-tro - Question 2
UPDATE public.questions SET
  prompt_en = 'Most denominations uphold the belief in ___: that God is one being, but three "persons".',
  prompt_tr = 'Çoğu mezhep ___''e inanır: Tanrı bir varlık ama üç "kişi"dir.',
  meta_en = '{"answer":"the Trinity"}'::jsonb,
  meta_tr = '{"answer":"Teslis"}'::jsonb
WHERE prompt = 'De fleste kirkesamfunn fastholder troen på ___: at Gud er ett vesen, men tre «personer».'
  AND type = 'gap';

-- kristendom-tro - Question 3
UPDATE public.questions SET
  prompt_en = 'What does the Trinity consist of?',
  prompt_tr = 'Teslis nelerden oluşur?',
  meta_en = '{"choices":[
    {"id":"a","text":"Three gods"},
    {"id":"b","text":"The Father, the Son, and the Holy Spirit","correct":true},
    {"id":"c","text":"Three churches"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Üç tanrı"},
    {"id":"b","text":"Baba, Oğul ve Kutsal Ruh","correct":true},
    {"id":"c","text":"Üç kilise"}
  ]}'::jsonb
WHERE prompt = 'Hva består treenigheten av?'
  AND type = 'mcq';

-- kristendom-tro - Question 4
UPDATE public.questions SET
  prompt_en = 'Christians believe Jesus is both fully ___ and fully God.',
  prompt_tr = 'Hıristiyanlar İsa''nın hem tamamen ___ hem de tamamen Tanrı olduğuna inanırlar.',
  meta_en = '{"answer":"human"}'::jsonb,
  meta_tr = '{"answer":"insan"}'::jsonb
WHERE prompt = 'Kristne tror Jesus er både fullt ut ___ og fullt ut Gud.'
  AND type = 'gap';

-- kristendom-tro - Question 5
UPDATE public.questions SET
  prompt_en = 'The concept of original sin means that humanity has been marked by sin since Adam and Eve.',
  prompt_tr = 'İlk günah kavramı, insanlığın Adem ve Havva''dan beri günahla damgalandığı anlamına gelir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Forestillingen om arvesynd innebærer at menneskeheten har vært preget av synd siden Adam og Eva.'
  AND type = 'tf';

-- kristendom-tro - Question 6
UPDATE public.questions SET
  prompt_en = 'What does "salvation through grace" mean?',
  prompt_tr = '"Lütufla kurtuluş" ne anlama gelir?',
  meta_en = '{"choices":[
    {"id":"a","text":"That one earns salvation through good deeds"},
    {"id":"b","text":"That salvation is a gift from God that people cannot earn themselves","correct":true},
    {"id":"c","text":"That no one can be saved"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"İyi işler yaparak kurtuluş kazanılır"},
    {"id":"b","text":"Kurtuluş, insanların kendi başlarına kazanamayacağı Tanrı''nın bir hediyesidir","correct":true},
    {"id":"c","text":"Kimse kurtulamaz"}
  ]}'::jsonb
WHERE prompt = 'Hva betyr «frelse ved nåde»?'
  AND type = 'mcq';

-- kristendom-tro - Question 7
UPDATE public.questions SET
  prompt_en = 'Christians believe that all people will face God''s judgment on ___.',
  prompt_tr = 'Hıristiyanlar, tüm insanların ___ günü Tanrı''nın yargısıyla karşılaşacağına inanırlar.',
  meta_en = '{"answer":"Judgment Day"}'::jsonb,
  meta_tr = '{"answer":"Kıyamet Günü"}'::jsonb
WHERE prompt = 'Kristne tror at alle mennesker vil møte Guds dom på ___.'
  AND type = 'gap';

-- kristendom-praksis (Practices) - Question 1
UPDATE public.questions SET
  prompt_en = 'Sunday is the Christian day of worship because Jesus rose from the dead on a Sunday.',
  prompt_tr = 'Pazar, Hıristiyanların ibadet günüdür çünkü İsa pazar günü ölümden dirilmiştir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Søndagen er kristne gudstjenestedag fordi Jesus stod opp fra de døde en søndag.'
  AND type = 'tf';

-- kristendom-praksis - Question 2
UPDATE public.questions SET
  prompt_en = '___ is a ritual where water is used to mark a person''s entry into the Christian faith.',
  prompt_tr = '___, bir kişinin Hıristiyan inancına girişini işaretlemek için suyun kullanıldığı bir ritüeldir.',
  meta_en = '{"answer":"Baptism"}'::jsonb,
  meta_tr = '{"answer":"Vaftiz"}'::jsonb
WHERE prompt = '___ er et ritual der vann brukes for å markere en persons inntreden i den kristne tro.'
  AND type = 'gap';

-- kristendom-praksis - Question 3
UPDATE public.questions SET
  prompt_en = 'What does Holy Communion/Eucharist commemorate?',
  prompt_tr = 'Kutsal Komünyon/Evharistiya neyi anımsatır?',
  meta_en = '{"choices":[
    {"id":"a","text":"Jesus'' birth"},
    {"id":"b","text":"The Last Supper before Jesus'' crucifixion","correct":true},
    {"id":"c","text":"Jesus'' baptism"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"İsa''nın doğumu"},
    {"id":"b","text":"İsa''nın çarmıha gerilmeden önceki Son Akşam Yemeği","correct":true},
    {"id":"c","text":"İsa''nın vaftizi"}
  ]}'::jsonb
WHERE prompt = 'Hva minner nattverden/eukaristien om?'
  AND type = 'mcq';

-- kristendom-praksis - Question 4
UPDATE public.questions SET
  prompt_en = 'Prayer is a central practice where Christians communicate with ___.',
  prompt_tr = 'Dua, Hıristiyanların ___ ile iletişim kurduğu merkezi bir uygulamadır.',
  meta_en = '{"answer":"God"}'::jsonb,
  meta_tr = '{"answer":"Tanrı"}'::jsonb
WHERE prompt = 'Bønn er en sentral praksis hvor kristne kommuniserer med ___.'
  AND type = 'gap';

-- kristendom-praksis - Question 5
UPDATE public.questions SET
  prompt_en = 'Christianity encourages helping the poor and needy.',
  prompt_tr = 'Hıristiyanlık fakirlere ve muhtaçlara yardım etmeyi teşvik eder.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Kristendommen oppfordrer til å hjelpe fattige og trengende.'
  AND type = 'tf';

-- kristendom-praksis - Question 6
UPDATE public.questions SET
  prompt_en = 'What is the role of priests/pastors in most Christian denominations?',
  prompt_tr = 'Çoğu Hıristiyan mezheplerinde rahiplerin/papazların rolü nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"To lead services, preach, and provide pastoral care","correct":true},
    {"id":"b","text":"To collect taxes"},
    {"id":"c","text":"To enforce the law"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"İbadetleri yönetmek, vaaz vermek ve pastoral bakım sağlamak","correct":true},
    {"id":"b","text":"Vergi toplamak"},
    {"id":"c","text":"Yasayı uygulamak"}
  ]}'::jsonb
WHERE prompt = 'Hva er rollen til prester/pastorer i de fleste kristne kirkesamfunn?'
  AND type = 'mcq';

-- kristendom-praksis - Question 7
UPDATE public.questions SET
  prompt_en = 'Many Christians practice ___ during Lent as preparation for Easter.',
  prompt_tr = 'Birçok Hıristiyan, Paskalya''ya hazırlık olarak Perhiz döneminde ___ yapar.',
  meta_en = '{"answer":"fasting"}'::jsonb,
  meta_tr = '{"answer":"oruç"}'::jsonb
WHERE prompt = 'Mange kristne praktiserer ___ under fastetiden som forberedelse til påske.'
  AND type = 'gap';

-- kristendom-hoytider (Holidays) - Question 1
UPDATE public.questions SET
  prompt_en = 'Christmas celebrates Jesus'' birth.',
  prompt_tr = 'Noel, İsa''nın doğumunu kutlar.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Jul feirer Jesu fødsel.'
  AND type = 'tf';

-- kristendom-hoytider - Question 2
UPDATE public.questions SET
  prompt_en = 'When is Christmas traditionally celebrated?',
  prompt_tr = 'Noel geleneksel olarak ne zaman kutlanır?',
  meta_en = '{"choices":[
    {"id":"a","text":"January 6"},
    {"id":"b","text":"December 25","correct":true},
    {"id":"c","text":"December 31"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"6 Ocak"},
    {"id":"b","text":"25 Aralık","correct":true},
    {"id":"c","text":"31 Aralık"}
  ]}'::jsonb
WHERE prompt = 'Når feires jul tradisjonelt?'
  AND type = 'mcq';

-- kristendom-hoytider - Question 3
UPDATE public.questions SET
  prompt_en = '___ is the period leading up to Christmas.',
  prompt_tr = '___, Noel''e kadar olan dönemdir.',
  meta_en = '{"answer":"Advent"}'::jsonb,
  meta_tr = '{"answer":"Advent"}'::jsonb
WHERE prompt = '___ er tiden fram til jul.'
  AND type = 'gap';

-- kristendom-hoytider - Question 4
UPDATE public.questions SET
  prompt_en = 'Easter commemorates Jesus'' resurrection from the dead.',
  prompt_tr = 'Paskalya, İsa''nın ölümden dirilişini anımsar.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Påske minnes Jesu oppstandelse fra de døde.'
  AND type = 'tf';

-- kristendom-hoytider - Question 5
UPDATE public.questions SET
  prompt_en = 'What is Lent?',
  prompt_tr = 'Perhiz dönemi nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"A summer festival"},
    {"id":"b","text":"A 40-day fasting period before Easter","correct":true},
    {"id":"c","text":"A winter celebration"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Bir yaz festivali"},
    {"id":"b","text":"Paskalya''dan önce 40 günlük oruç dönemi","correct":true},
    {"id":"c","text":"Bir kış kutlaması"}
  ]}'::jsonb
WHERE prompt = 'Hva er fastetiden?'
  AND type = 'mcq';

-- kristendom-hoytider - Question 6
UPDATE public.questions SET
  prompt_en = '___ commemorates the descent of the Holy Spirit upon the apostles.',
  prompt_tr = '___, Kutsal Ruh''un havarilere inmesini anımsar.',
  meta_en = '{"answer":"Pentecost"}'::jsonb,
  meta_tr = '{"answer":"Pentikost"}'::jsonb
WHERE prompt = '___ minnes Den hellige ånds komme over disiplene.'
  AND type = 'gap';

-- kristendom-hoytider - Question 7
UPDATE public.questions SET
  prompt_en = 'Good Friday is the day Jesus was crucified.',
  prompt_tr = 'İyi Cuma, İsa''nın çarmıha gerildiği gündür.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Langfredag er dagen Jesus ble korsfestet.'
  AND type = 'tf';

-- kristendom-tekster (Texts) - Question 1
UPDATE public.questions SET
  prompt_en = 'The Bible consists of the ___ and the New Testament.',
  prompt_tr = 'İncil, ___ ve Yeni Ahit''ten oluşur.',
  meta_en = '{"answer":"Old Testament"}'::jsonb,
  meta_tr = '{"answer":"Eski Ahit"}'::jsonb
WHERE prompt = 'Bibelen består av ___ og Det nye testamente.'
  AND type = 'gap';

-- kristendom-tekster - Question 2
UPDATE public.questions SET
  prompt_en = 'How many books does the Bible contain?',
  prompt_tr = 'İncil kaç kitaptan oluşur?',
  meta_en = '{"choices":[
    {"id":"a","text":"27"},
    {"id":"b","text":"39"},
    {"id":"c","text":"66","correct":true}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"27"},
    {"id":"b","text":"39"},
    {"id":"c","text":"66","correct":true}
  ]}'::jsonb
WHERE prompt = 'Hvor mange bøker inneholder Bibelen?'
  AND type = 'mcq';

-- kristendom-tekster - Question 3
UPDATE public.questions SET
  prompt_en = 'The Gospels tell the story of Jesus'' life and teachings.',
  prompt_tr = 'İnciller, İsa''nın yaşamının ve öğretilerinin hikayesini anlatır.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Evangeliene forteller historien om Jesu liv og læresetninger.'
  AND type = 'tf';

-- kristendom-tekster - Question 4
UPDATE public.questions SET
  prompt_en = 'Who wrote many letters in the New Testament?',
  prompt_tr = 'Yeni Ahit''te birçok mektup yazan kimdir?',
  meta_en = '{"choices":[
    {"id":"a","text":"Peter"},
    {"id":"b","text":"Paul","correct":true},
    {"id":"c","text":"John"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Petrus"},
    {"id":"b","text":"Pavlus","correct":true},
    {"id":"c","text":"Yuhanna"}
  ]}'::jsonb
WHERE prompt = 'Hvem skrev mange av brevene i Det nye testamente?'
  AND type = 'mcq';

-- kristendom-tekster - Question 5
UPDATE public.questions SET
  prompt_en = 'The ___ is a Christian symbol representing Jesus'' sacrifice.',
  prompt_tr = '___, İsa''nın kurbanını temsil eden bir Hıristiyan sembolüdür.',
  meta_en = '{"answer":"cross"}'::jsonb,
  meta_tr = '{"answer":"haç"}'::jsonb
WHERE prompt = '___ er et kristent symbol som representerer Jesu offer.'
  AND type = 'gap';

-- kristendom-tekster - Question 6
UPDATE public.questions SET
  prompt_en = 'The fish symbol (Ichthys) was an early Christian symbol.',
  prompt_tr = 'Balık sembolü (İhthis), erken dönem Hıristiyan sembolüydü.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Fisksymbolet (ichtys) var et tidlig kristent symbol.'
  AND type = 'tf';

-- kristendom-tekster - Question 7
UPDATE public.questions SET
  prompt_en = 'What is the Nicene Creed?',
  prompt_tr = 'İznik İnançı nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"A type of prayer"},
    {"id":"b","text":"A statement of Christian faith","correct":true},
    {"id":"c","text":"A church building"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Bir dua türü"},
    {"id":"b","text":"Hıristiyan inancının bir beyanı","correct":true},
    {"id":"c","text":"Bir kilise binası"}
  ]}'::jsonb
WHERE prompt = 'Hva er Den nikenske trosbekjennelse?'
  AND type = 'mcq';

-- ==================== ISLAM LESSONS ====================

-- islam-opprinnelse (Origins) - Question 1
UPDATE public.questions SET
  prompt_en = 'When did Islam originate?',
  prompt_tr = 'İslam ne zaman ortaya çıktı?',
  meta_en = '{"choices":[
    {"id":"a","text":"In the 7th century CE","correct":true},
    {"id":"b","text":"In the 1st century CE"},
    {"id":"c","text":"In the 10th century CE"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"MS 7. yüzyılda","correct":true},
    {"id":"b","text":"MS 1. yüzyılda"},
    {"id":"c","text":"MS 10. yüzyılda"}
  ]}'::jsonb
WHERE prompt = 'Når oppsto islam?'
  AND type = 'mcq'
  AND order_index = 0;

-- islam-opprinnelse - Question 2
UPDATE public.questions SET
  prompt_en = 'The founder of the religion, the Prophet ___ (c. 570-632 CE), received according to Islamic belief his first revelation from God in the year 610.',
  prompt_tr = 'Dinin kurucusu Peygamber ___ (yaklaşık 570-632 MS), İslam inancına göre 610 yılında Tanrı''dan ilk vahyini aldı.',
  meta_en = '{"answer":"Muhammad"}'::jsonb,
  meta_tr = '{"answer":"Muhammed"}'::jsonb
WHERE prompt = 'Religionens grunnlegger, profeten ___ (ca. 570–632 e.v.t.), mottok ifølge islams tro sin første åpenbaring fra Gud i år 610.'
  AND type = 'gap';

-- islam-opprinnelse - Question 3
UPDATE public.questions SET
  prompt_en = 'Where did Muhammad live when he received his first revelation?',
  prompt_tr = 'Muhammed ilk vahyini aldığında nerede yaşıyordu?',
  meta_en = '{"choices":[
    {"id":"a","text":"Cairo"},
    {"id":"b","text":"Mecca","correct":true},
    {"id":"c","text":"Baghdad"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Kahire"},
    {"id":"b","text":"Mekke","correct":true},
    {"id":"c","text":"Bağdat"}
  ]}'::jsonb
WHERE prompt = 'Hvor bodde Muhammed da han mottok sin første åpenbaring?'
  AND type = 'mcq';

-- islam-opprinnelse - Question 4
UPDATE public.questions SET
  prompt_en = 'The Hijra (migration) to ___ in 622 CE marks the beginning of the Islamic calendar.',
  prompt_tr = 'MS 622''de ___''ye Hicret (göç), İslam takviminin başlangıcını işaret eder.',
  meta_en = '{"answer":"Medina"}'::jsonb,
  meta_tr = '{"answer":"Medine"}'::jsonb
WHERE prompt = 'Hijra (utvandringen) til ___ i år 622 markerer begynnelsen av den islamske kalenderen.'
  AND type = 'gap';

-- islam-opprinnelse - Question 5
UPDATE public.questions SET
  prompt_en = 'Islam spread quickly after Muhammad''s death.',
  prompt_tr = 'İslam, Muhammed''in ölümünden sonra hızla yayıldı.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Islam spredte seg raskt etter Muhammeds død.'
  AND type = 'tf';

-- islam-opprinnelse - Question 6
UPDATE public.questions SET
  prompt_en = 'What is a caliph?',
  prompt_tr = 'Halife nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"A religious building"},
    {"id":"b","text":"A successor and leader of the Muslim community","correct":true},
    {"id":"c","text":"A holy book"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Bir dini bina"},
    {"id":"b","text":"Müslüman toplumun halefi ve lideri","correct":true},
    {"id":"c","text":"Kutsal bir kitap"}
  ]}'::jsonb
WHERE prompt = 'Hva er en kalif?'
  AND type = 'mcq';

-- islam-opprinnelse - Question 7
UPDATE public.questions SET
  prompt_en = 'The split between ___ and Shia Muslims arose over the question of who should lead the Muslim community after Muhammad.',
  prompt_tr = '___ ve Şii Müslümanlar arasındaki ayrılık, Muhammed''den sonra Müslüman topluluğu kimin yönetmesi gerektiği sorusundan kaynaklandı.',
  meta_en = '{"answer":"Sunni"}'::jsonb,
  meta_tr = '{"answer":"Sünni"}'::jsonb
WHERE prompt = 'Splittelsen mellom ___ og sjiittiske muslimer oppstod over spørsmålet om hvem som skulle lede det muslimske samfunnet etter Muhammed.'
  AND type = 'gap';

-- islam-tro (Beliefs) - Question 1
UPDATE public.questions SET
  prompt_en = 'Islam is a monotheistic religion.',
  prompt_tr = 'İslam tek tanrılı bir dindir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Islam er en monoteistisk religion.'
  AND type = 'tf'
  AND order_index = 0
  AND quiz_id IN (
    SELECT q.id FROM public.quizzes q
    JOIN public.lessons l ON l.id = q.lesson_id
    WHERE l.slug = 'islam-tro'
  );

-- islam-tro - Question 2
UPDATE public.questions SET
  prompt_en = '___ means submission to God''s will.',
  prompt_tr = '___, Tanrı''nın iradesine teslim olmak anlamına gelir.',
  meta_en = '{"answer":"Islam"}'::jsonb,
  meta_tr = '{"answer":"İslam"}'::jsonb
WHERE prompt = '___ betyr underordning under Guds vilje.'
  AND type = 'gap';

-- islam-tro - Question 3
UPDATE public.questions SET
  prompt_en = 'How many main beliefs (articles of faith) does Islam have?',
  prompt_tr = 'İslam''ın kaç ana inancı (iman esası) vardır?',
  meta_en = '{"choices":[
    {"id":"a","text":"Three"},
    {"id":"b","text":"Five"},
    {"id":"c","text":"Six","correct":true}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Üç"},
    {"id":"b","text":"Beş"},
    {"id":"c","text":"Altı","correct":true}
  ]}'::jsonb
WHERE prompt = 'Hvor mange hovedtrosartikler har islam?'
  AND type = 'mcq';

-- islam-tro - Question 4
UPDATE public.questions SET
  prompt_en = 'Muslims believe in one God called ___.',
  prompt_tr = 'Müslümanlar ___ adında tek bir Tanrı''ya inanırlar.',
  meta_en = '{"answer":"Allah"}'::jsonb,
  meta_tr = '{"answer":"Allah"}'::jsonb
WHERE prompt = 'Muslimer tror på én Gud som kalles ___.'
  AND type = 'gap';

-- islam-tro - Question 5
UPDATE public.questions SET
  prompt_en = 'Muslims believe in angels, prophets, holy books, and the Day of Judgment.',
  prompt_tr = 'Müslümanlar meleklere, peygamberlere, kutsal kitaplara ve Kıyamet Günü''ne inanırlar.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Muslimer tror på engler, profeter, hellige bøker og dommedag.'
  AND type = 'tf';

-- islam-tro - Question 6
UPDATE public.questions SET
  prompt_en = 'Who is considered the final prophet in Islam?',
  prompt_tr = 'İslam''da son peygamber olarak kim kabul edilir?',
  meta_en = '{"choices":[
    {"id":"a","text":"Moses"},
    {"id":"b","text":"Jesus"},
    {"id":"c","text":"Muhammad","correct":true}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Musa"},
    {"id":"b","text":"İsa"},
    {"id":"c","text":"Muhammed","correct":true}
  ]}'::jsonb
WHERE prompt = 'Hvem regnes som den siste profeten i islam?'
  AND type = 'mcq';

-- islam-tro - Question 7
UPDATE public.questions SET
  prompt_en = 'Muslims believe in ___, the doctrine that God has predetermined everything.',
  prompt_tr = 'Müslümanlar, Tanrı''nın her şeyi önceden belirlediği doktrini olan ___''a inanırlar.',
  meta_en = '{"answer":"predestination"}'::jsonb,
  meta_tr = '{"answer":"kader"}'::jsonb
WHERE prompt = 'Muslimer tror på ___, læren om at Gud har forutbestemt alt.'
  AND type = 'gap';

-- islam-soylene (Five Pillars) - Question 1
UPDATE public.questions SET
  prompt_en = 'The Five Pillars of Islam are the five fundamental practices that every Muslim should follow.',
  prompt_tr = 'İslam''ın Beş Şartı, her Müslümanın uyması gereken beş temel uygulamadır.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Islams fem søyler er de fem grunnleggende praksisene som enhver muslim skal følge.'
  AND type = 'tf';

-- islam-soylene - Question 2
UPDATE public.questions SET
  prompt_en = 'What is Shahada?',
  prompt_tr = 'Şehadet nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"Fasting"},
    {"id":"b","text":"The Islamic declaration of faith","correct":true},
    {"id":"c","text":"Pilgrimage"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Oruç"},
    {"id":"b","text":"İslami inanç beyanı","correct":true},
    {"id":"c","text":"Hac"}
  ]}'::jsonb
WHERE prompt = 'Hva er shahada?'
  AND type = 'mcq';

-- islam-soylene - Question 3
UPDATE public.questions SET
  prompt_en = 'Muslims pray ___ times a day.',
  prompt_tr = 'Müslümanlar günde ___ kez namaz kılarlar.',
  meta_en = '{"answer":"five"}'::jsonb,
  meta_tr = '{"answer":"beş"}'::jsonb
WHERE prompt = 'Muslimer ber ___ ganger om dagen.'
  AND type = 'gap';

-- islam-soylene - Question 4
UPDATE public.questions SET
  prompt_en = 'Zakat is mandatory charity in Islam.',
  prompt_tr = 'Zekat İslam''da zorunlu bir sadakadır.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Zakat er obligatorisk veldedighet i islam.'
  AND type = 'tf';

-- islam-soylene - Question 5
UPDATE public.questions SET
  prompt_en = 'What is Sawm?',
  prompt_tr = 'Oruç (Savm) nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"Prayer"},
    {"id":"b","text":"Fasting during Ramadan","correct":true},
    {"id":"c","text":"Pilgrimage to Mecca"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Namaz"},
    {"id":"b","text":"Ramazan''da oruç tutmak","correct":true},
    {"id":"c","text":"Mekke''ye hac"}
  ]}'::jsonb
WHERE prompt = 'Hva er sawm?'
  AND type = 'mcq';

-- islam-soylene - Question 6
UPDATE public.questions SET
  prompt_en = 'Every able Muslim should perform ___ (pilgrimage to Mecca) at least once in their lifetime.',
  prompt_tr = 'Her güçlü Müslüman hayatında en az bir kez ___ (Mekke''ye hac) yapmalıdır.',
  meta_en = '{"answer":"Hajj"}'::jsonb,
  meta_tr = '{"answer":"Hac"}'::jsonb
WHERE prompt = 'Enhver muslim som er i stand til det, bør utføre ___ (pilegrimsreisen til Mekka) minst én gang i løpet av livet.'
  AND type = 'gap';

-- islam-soylene - Question 7
UPDATE public.questions SET
  prompt_en = 'The Five Pillars are equally important in Islam.',
  prompt_tr = 'Beş Şart İslam''da eşit derecede önemlidir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'De fem søylene er like viktige i islam.'
  AND type = 'tf';

-- islam-hoytider (Holidays) - Question 1
UPDATE public.questions SET
  prompt_en = 'Ramadan is the Islamic holy month of fasting.',
  prompt_tr = 'Ramazan, İslam''ın kutsal oruç ayıdır.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Ramadan er den islamske hellige fastemåneden.'
  AND type = 'tf';

-- islam-hoytider - Question 2
UPDATE public.questions SET
  prompt_en = 'During Ramadan, Muslims fast from ___ until sunset.',
  prompt_tr = 'Ramazan boyunca Müslümanlar ___''dan güneş batımına kadar oruç tutarlar.',
  meta_en = '{"answer":"dawn"}'::jsonb,
  meta_tr = '{"answer":"şafak"}'::jsonb
WHERE prompt = 'Under ramadan faster muslimer fra ___ til solnedgang.'
  AND type = 'gap';

-- islam-hoytider - Question 3
UPDATE public.questions SET
  prompt_en = 'What is Eid al-Fitr?',
  prompt_tr = 'Ramazan Bayramı (Eid al-Fitr) nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"The start of Ramadan"},
    {"id":"b","text":"The festival marking the end of Ramadan","correct":true},
    {"id":"c","text":"The pilgrimage to Mecca"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Ramazan''ın başlangıcı"},
    {"id":"b","text":"Ramazan''ın sonunu işaret eden bayram","correct":true},
    {"id":"c","text":"Mekke''ye hac"}
  ]}'::jsonb
WHERE prompt = 'Hva er Id al-Fitr?'
  AND type = 'mcq';

-- islam-hoytider - Question 4
UPDATE public.questions SET
  prompt_en = 'Eid al-Adha commemorates Abraham''s willingness to sacrifice his son.',
  prompt_tr = 'Kurban Bayramı (Eid al-Adha), İbrahim''in oğlunu kurban etmeye hazır oluşunu anımsar.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Id al-Adha minnes Abrahams vilje til å ofre sin sønn.'
  AND type = 'tf';

-- islam-hoytider - Question 5
UPDATE public.questions SET
  prompt_en = 'When is Eid al-Adha celebrated?',
  prompt_tr = 'Kurban Bayramı ne zaman kutlanır?',
  meta_en = '{"choices":[
    {"id":"a","text":"After Ramadan"},
    {"id":"b","text":"During the Hajj pilgrimage","correct":true},
    {"id":"c","text":"On Muhammad''s birthday"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Ramazan''dan sonra"},
    {"id":"b","text":"Hac ziyareti sırasında","correct":true},
    {"id":"c","text":"Muhammed''in doğum gününde"}
  ]}'::jsonb
WHERE prompt = 'Når feires Id al-Adha?'
  AND type = 'mcq';

-- islam-hoytider - Question 6
UPDATE public.questions SET
  prompt_en = '___ marks the night when Muhammad received his first revelation.',
  prompt_tr = '___, Muhammed''in ilk vahyini aldığı geceyi işaret eder.',
  meta_en = '{"answer":"Laylat al-Qadr"}'::jsonb,
  meta_tr = '{"answer":"Kadir Gecesi"}'::jsonb
WHERE prompt = '___ markerer natten da Muhammed mottok sin første åpenbaring.'
  AND type = 'gap';

-- islam-hoytider - Question 7
UPDATE public.questions SET
  prompt_en = 'Mawlid celebrates the birthday of Prophet Muhammad.',
  prompt_tr = 'Mevlid, Peygamber Muhammed''in doğum gününü kutlar.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Mawlid feirer profeten Muhammeds fødselsdag.'
  AND type = 'tf';

-- islam-tekster (Texts) - Question 1
UPDATE public.questions SET
  prompt_en = 'The ___ is the holy book of Islam.',
  prompt_tr = '___, İslam''ın kutsal kitabıdır.',
  meta_en = '{"answer":"Quran"}'::jsonb,
  meta_tr = '{"answer":"Kuran"}'::jsonb
WHERE prompt = '___ er islams hellige bok.'
  AND type = 'gap';

-- islam-tekster - Question 2
UPDATE public.questions SET
  prompt_en = 'Muslims believe the Quran is the literal word of God.',
  prompt_tr = 'Müslümanlar Kuran''ın Tanrı''nın kelimenin tam anlamıyla sözü olduğuna inanırlar.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Muslimer tror at Koranen er Guds bokstavelige ord.'
  AND type = 'tf';

-- islam-tekster - Question 3
UPDATE public.questions SET
  prompt_en = 'In which language was the Quran revealed?',
  prompt_tr = 'Kuran hangi dilde vahyedildi?',
  meta_en = '{"choices":[
    {"id":"a","text":"Persian"},
    {"id":"b","text":"Arabic","correct":true},
    {"id":"c","text":"Hebrew"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Farsça"},
    {"id":"b","text":"Arapça","correct":true},
    {"id":"c","text":"İbranice"}
  ]}'::jsonb
WHERE prompt = 'På hvilket språk ble Koranen åpenbart?'
  AND type = 'mcq';

-- islam-tekster - Question 4
UPDATE public.questions SET
  prompt_en = 'The ___ are collections of Muhammad''s sayings and actions.',
  prompt_tr = '___, Muhammed''in sözleri ve eylemlerinin koleksiyonlarıdır.',
  meta_en = '{"answer":"Hadith"}'::jsonb,
  meta_tr = '{"answer":"Hadis"}'::jsonb
WHERE prompt = '___ er samlinger av Muhammeds uttalelser og handlinger.'
  AND type = 'gap';

-- islam-tekster - Question 5
UPDATE public.questions SET
  prompt_en = 'The crescent moon and star are widely recognized symbols of Islam.',
  prompt_tr = 'Hilal ve yıldız, İslam''ın yaygın olarak tanınan sembolleridir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Halvmånen og stjernen er allment anerkjente symboler på islam.'
  AND type = 'tf';

-- islam-tekster - Question 6
UPDATE public.questions SET
  prompt_en = 'What is a mosque?',
  prompt_tr = 'Cami nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"A religious leader"},
    {"id":"b","text":"A Muslim place of worship","correct":true},
    {"id":"c","text":"A holy book"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Bir dini lider"},
    {"id":"b","text":"Bir Müslüman ibadet yeri","correct":true},
    {"id":"c","text":"Bir kutsal kitap"}
  ]}'::jsonb
WHERE prompt = 'Hva er en moské?'
  AND type = 'mcq';

-- islam-tekster - Question 7
UPDATE public.questions SET
  prompt_en = 'Islamic ___ is a system of artistic decoration using geometric patterns.',
  prompt_tr = 'İslami ___, geometrik desenler kullanan sanatsal bir dekorasyon sistemidir.',
  meta_en = '{"answer":"calligraphy"}'::jsonb,
  meta_tr = '{"answer":"hat sanatı"}'::jsonb
WHERE prompt = 'Islamsk ___ er et system for kunstnerisk dekorasjon som bruker geometriske mønstre.'
  AND type = 'gap';

-- ==================== HINDUISM LESSONS ====================

-- hinduisme-opprinnelse (Origins) - Question 1
UPDATE public.questions SET
  prompt_en = 'Hinduism is one of the world''s oldest religions.',
  prompt_tr = 'Hinduizm dünyanın en eski dinlerinden biridir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Hinduisme er en av verdens eldste religioner.'
  AND type = 'tf'
  AND order_index = 0
  AND quiz_id IN (
    SELECT q.id FROM public.quizzes q
    JOIN public.lessons l ON l.id = q.lesson_id
    WHERE l.slug = 'hinduisme-opprinnelse'
  );

-- hinduisme-opprinnelse - Question 2
UPDATE public.questions SET
  prompt_en = 'What characterizes Hinduism''s origins?',
  prompt_tr = 'Hinduizm''in kökenlerini ne karakterize eder?',
  meta_en = '{"choices":[
    {"id":"a","text":"It has one single founder"},
    {"id":"b","text":"It has no single founder and developed over thousands of years","correct":true},
    {"id":"c","text":"It was founded in Egypt"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Tek bir kurucusu var"},
    {"id":"b","text":"Tek bir kurucusu yok ve binlerce yıl içinde gelişti","correct":true},
    {"id":"c","text":"Mısır''da kuruldu"}
  ]}'::jsonb
WHERE prompt = 'Hva kjennetegner hinduismens opprinnelse?'
  AND type = 'mcq';

-- hinduisme-opprinnelse - Question 3
UPDATE public.questions SET
  prompt_en = 'The earliest traces are linked to the ___ civilization (approx. 2500 BCE).',
  prompt_tr = 'En erken izler ___ uygarlığına (yaklaşık MÖ 2500) bağlıdır.',
  meta_en = '{"answer":"Indus"}'::jsonb,
  meta_tr = '{"answer":"İndus"}'::jsonb
WHERE prompt = 'De tidligste sporene knyttes til ___-sivilisasjonen (ca. 2500 fvt.).'
  AND type = 'gap';

-- hinduisme-opprinnelse - Question 4
UPDATE public.questions SET
  prompt_en = 'What is the early religion from Indo-European peoples called?',
  prompt_tr = 'Hint-Avrupa halklarından gelen erken dine ne denir?',
  meta_en = '{"choices":[
    {"id":"a","text":"Vedic religion","correct":true},
    {"id":"b","text":"Buddhism"},
    {"id":"c","text":"Jainism"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Vedik din","correct":true},
    {"id":"b","text":"Budizm"},
    {"id":"c","text":"Jainizm"}
  ]}'::jsonb
WHERE prompt = 'Hva kalles den tidlige religionen fra indoeuropeiske folkegrupper?'
  AND type = 'mcq';

-- hinduisme-opprinnelse - Question 5
UPDATE public.questions SET
  prompt_en = 'The ___ introduced the thinking about rebirth and a universal force called Brahman.',
  prompt_tr = '___, yeniden doğuş ve Brahman adlı evrensel bir güç hakkında düşünceyi tanıttı.',
  meta_en = '{"answer":"Upanishads"}'::jsonb,
  meta_tr = '{"answer":"Upanişadlar"}'::jsonb
WHERE prompt = '___ introduserte tenkningen om gjenfødsel og en universell kraft kalt Brahman.'
  AND type = 'gap';

-- hinduisme-opprinnelse - Question 6
UPDATE public.questions SET
  prompt_en = 'The Bhagavad Gita is a philosophical dialogue where Krishna guides Prince Arjuna.',
  prompt_tr = 'Bhagavad Gita, Krishna''nın Prens Arjuna''ya rehberlik ettiği felsefi bir diyalogdur.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Bhagavad Gita er en filosofisk dialog hvor Krishna veileder prins Arjuna.'
  AND type = 'tf';

-- hinduisme-opprinnelse - Question 7
UPDATE public.questions SET
  prompt_en = 'What is the bhakti movement?',
  prompt_tr = 'Bhakti hareketi nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"A political movement"},
    {"id":"b","text":"A direction based on personal devotion to the divine","correct":true},
    {"id":"c","text":"A warrior order"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Politik bir hareket"},
    {"id":"b","text":"İlahi''ye kişisel bağlılığa dayalı bir yön","correct":true},
    {"id":"c","text":"Bir savaşçı düzeni"}
  ]}'::jsonb
WHERE prompt = 'Hva er bhakti-bevegelsen?'
  AND type = 'mcq';

-- hinduisme-tro (Beliefs) - Question 1
UPDATE public.questions SET
  prompt_en = 'The belief in ___ (reincarnation) is central to Hinduism.',
  prompt_tr = '___ (reenkarnasyon) inancı Hinduizm için merkezidir.',
  meta_en = '{"answer":"rebirth"}'::jsonb,
  meta_tr = '{"answer":"yeniden doğuş"}'::jsonb
WHERE prompt = 'Troen på ___ (reinkarnasjon) er sentral i hinduismen.'
  AND type = 'gap'
  AND order_index = 0;

-- hinduisme-tro - Question 2
UPDATE public.questions SET
  prompt_en = 'What influences one''s future life in Hinduism?',
  prompt_tr = 'Hinduizm''de gelecekteki yaşamı ne etkiler?',
  meta_en = '{"choices":[
    {"id":"a","text":"Random chance"},
    {"id":"b","text":"Karma (consequences of actions)","correct":true},
    {"id":"c","text":"Just luck"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Tesadüf"},
    {"id":"b","text":"Karma (eylemlerin sonuçları)","correct":true},
    {"id":"c","text":"Sadece şans"}
  ]}'::jsonb
WHERE prompt = 'Hva påvirker ens fremtidige liv i hinduismen?'
  AND type = 'mcq';

-- hinduisme-tro - Question 3
UPDATE public.questions SET
  prompt_en = 'The ultimate goal of life is to achieve ___ (liberation from the cycle of rebirth).',
  prompt_tr = 'Yaşamın nihai amacı ___ (yeniden doğuş döngüsünden kurtuluş) elde etmektir.',
  meta_en = '{"answer":"moksha"}'::jsonb,
  meta_tr = '{"answer":"mokşa"}'::jsonb
WHERE prompt = 'Livets endelige mål er å oppnå ___ (frigjøring fra gjenfødelsens kretsløp).'
  AND type = 'gap';

-- hinduisme-tro - Question 4
UPDATE public.questions SET
  prompt_en = 'Brahman is considered the all-encompassing divine principle.',
  prompt_tr = 'Brahman, her şeyi kapsayan ilahi ilke olarak kabul edilir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Brahman anses som det altomfattende guddommelige prinsipp.'
  AND type = 'tf';

-- hinduisme-tro - Question 5
UPDATE public.questions SET
  prompt_en = 'Which three deities are most central in Hinduism?',
  prompt_tr = 'Hinduizm''de en merkezi üç tanrı hangileridir?',
  meta_en = '{"choices":[
    {"id":"a","text":"Vishnu, Shiva, and Devi","correct":true},
    {"id":"b","text":"Rama, Sita, and Hanuman"},
    {"id":"c","text":"Krishna, Arjuna, and Ganesha"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Vişnu, Şiva ve Devi","correct":true},
    {"id":"b","text":"Rama, Sita ve Hanuman"},
    {"id":"c","text":"Krishna, Arjuna ve Ganeş"}
  ]}'::jsonb
WHERE prompt = 'Hvilke tre guddommer er mest sentrale i hinduismen?'
  AND type = 'mcq';

-- hinduisme-tro - Question 6
UPDATE public.questions SET
  prompt_en = 'Vishnu descends to earth in different ___ to restore balance.',
  prompt_tr = 'Vişnu dengeyi yeniden kurmak için farklı ___ şeklinde dünyaya iner.',
  meta_en = '{"answer":"avatars"}'::jsonb,
  meta_tr = '{"answer":"avatarlar"}'::jsonb
WHERE prompt = 'Vishnu stiger ned til jorden i ulike ___ for å gjenopprette balansen.'
  AND type = 'gap';

-- hinduisme-tro - Question 7
UPDATE public.questions SET
  prompt_en = 'Shiva represents both creative and destructive power.',
  prompt_tr = 'Şiva hem yaratıcı hem de yıkıcı gücü temsil eder.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Shiva representerer skaper- og ødeleggermakt.'
  AND type = 'tf';

-- hinduisme-praksis (Practices) - Question 1
UPDATE public.questions SET
  prompt_en = 'Daily worship in Hinduism is called ___.',
  prompt_tr = 'Hinduizm''de günlük ibadete ___ denir.',
  meta_en = '{"answer":"puja"}'::jsonb,
  meta_tr = '{"answer":"puja"}'::jsonb
WHERE prompt = 'Daglig tilbedelse i hinduismen kalles ___.'
  AND type = 'gap'
  AND order_index = 0;

-- hinduisme-praksis - Question 2
UPDATE public.questions SET
  prompt_en = 'What is prasada?',
  prompt_tr = 'Prasad nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"A deity"},
    {"id":"b","text":"Blessed food returned from the deity","correct":true},
    {"id":"c","text":"A temple"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Bir tanrı"},
    {"id":"b","text":"Tanrıdan dönen kutsanmış yiyecek","correct":true},
    {"id":"c","text":"Bir tapınak"}
  ]}'::jsonb
WHERE prompt = 'Hva er prasada?'
  AND type = 'mcq';

-- hinduisme-praksis - Question 3
UPDATE public.questions SET
  prompt_en = 'Most Hindus have a small home altar.',
  prompt_tr = 'Çoğu Hindu''nun küçük bir ev sunağı vardır.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'De fleste hinduer har et lite husalter hjemme.'
  AND type = 'tf';

-- hinduisme-praksis - Question 4
UPDATE public.questions SET
  prompt_en = 'The principle of ___ (non-violence) has contributed to many Hindus being vegetarians.',
  prompt_tr = '___ (şiddet karşıtlığı) ilkesi, birçok Hindu''nun vejetaryen olmasına katkıda bulunmuştur.',
  meta_en = '{"answer":"ahimsa"}'::jsonb,
  meta_tr = '{"answer":"ahimsa"}'::jsonb
WHERE prompt = 'Prinsippet om ___ (ikke-vold) har bidratt til at mange hinduer er vegetarianere.'
  AND type = 'gap';

-- hinduisme-praksis - Question 5
UPDATE public.questions SET
  prompt_en = 'Which river is considered sacred in Hinduism?',
  prompt_tr = 'Hinduizm''de hangi nehir kutsal kabul edilir?',
  meta_en = '{"choices":[
    {"id":"a","text":"The Nile"},
    {"id":"b","text":"The Ganges","correct":true},
    {"id":"c","text":"The Jordan"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Nil"},
    {"id":"b","text":"Ganj","correct":true},
    {"id":"c","text":"Ürdün"}
  ]}'::jsonb
WHERE prompt = 'Hvilken elv anses som hellig i hinduismen?'
  AND type = 'mcq'
  AND order_index = 4;

-- hinduisme-praksis - Question 6
UPDATE public.questions SET
  prompt_en = 'The cow is seen as a sacred animal in Hinduism.',
  prompt_tr = 'İnek Hinduizm''de kutsal bir hayvan olarak görülür.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Kua sees som et hellig dyr i hinduismen.'
  AND type = 'tf';

-- hinduisme-praksis - Question 7
UPDATE public.questions SET
  prompt_en = 'Hindu religious teachers are called ___.',
  prompt_tr = 'Hindu dini öğretmenlere ___ denir.',
  meta_en = '{"answer":"gurus"}'::jsonb,
  meta_tr = '{"answer":"gurular"}'::jsonb
WHERE prompt = 'Hinduiske religiøse lærere kalles ___.'
  AND type = 'gap';

-- hinduisme-hoytider (Holidays) - Question 1
UPDATE public.questions SET
  prompt_en = 'Which two holidays are most famous in Hinduism?',
  prompt_tr = 'Hinduizm''de en ünlü iki bayram hangileridir?',
  meta_en = '{"choices":[
    {"id":"a","text":"Christmas and Easter"},
    {"id":"b","text":"Diwali and Holi","correct":true},
    {"id":"c","text":"Ramadan and Eid"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Noel ve Paskalya"},
    {"id":"b","text":"Diwali ve Holi","correct":true},
    {"id":"c","text":"Ramazan ve Bayram"}
  ]}'::jsonb
WHERE prompt = 'Hvilke to høytider er mest kjente i hinduismen?'
  AND type = 'mcq';

-- hinduisme-hoytider - Question 2
UPDATE public.questions SET
  prompt_en = '___ is a festival of lights that marks the triumph of light over darkness.',
  prompt_tr = '___, ışığın karanlığa galibiyetini işaret eden bir ışık festivalidir.',
  meta_en = '{"answer":"Diwali"}'::jsonb,
  meta_tr = '{"answer":"Diwali"}'::jsonb
WHERE prompt = '___ er en lysfest som markerer lysets triumf over mørket.'
  AND type = 'gap';

-- hinduisme-hoytider - Question 3
UPDATE public.questions SET
  prompt_en = 'During Diwali, the goddess Lakshmi (goddess of prosperity) is honored.',
  prompt_tr = 'Diwali sırasında tanrıça Lakşmi (refah tanrıçası) onurlandırılır.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Under Divali æres gudinnen Lakshmi (velstandens gudinne).'
  AND type = 'tf';

-- hinduisme-hoytider - Question 4
UPDATE public.questions SET
  prompt_en = 'When is Holi celebrated?',
  prompt_tr = 'Holi ne zaman kutlanır?',
  meta_en = '{"choices":[
    {"id":"a","text":"Winter"},
    {"id":"b","text":"Spring (February/March)","correct":true},
    {"id":"c","text":"Autumn"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Kış"},
    {"id":"b","text":"İlkbahar (Şubat/Mart)","correct":true},
    {"id":"c","text":"Sonbahar"}
  ]}'::jsonb
WHERE prompt = 'Når feires Holi?'
  AND type = 'mcq';

-- hinduisme-hoytider - Question 5
UPDATE public.questions SET
  prompt_en = 'During Holi, people throw colored ___ and water at each other.',
  prompt_tr = 'Holi sırasında insanlar birbirlerine renkli ___ ve su atarlar.',
  meta_en = '{"answer":"powder"}'::jsonb,
  meta_tr = '{"answer":"toz"}'::jsonb
WHERE prompt = 'Under Holi kaster folk farget ___ og vann på hverandre.'
  AND type = 'gap';

-- hinduisme-hoytider - Question 6
UPDATE public.questions SET
  prompt_en = 'Navaratri lasts nine nights and celebrates the triumph of good over evil.',
  prompt_tr = 'Navaratri dokuz gece sürer ve iyiliğin kötülüğe galibiyetini kutlar.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Navaratri varer i ni netter og feirer det godes seier over det onde.'
  AND type = 'tf';

-- hinduisme-hoytider - Question 7
UPDATE public.questions SET
  prompt_en = 'What is celebrated during Krishna Janmashtami?',
  prompt_tr = 'Krishna Janmashtami''de ne kutlanır?',
  meta_en = '{"choices":[
    {"id":"a","text":"Krishna''s wedding"},
    {"id":"b","text":"Krishna''s birthday","correct":true},
    {"id":"c","text":"Krishna''s death"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Krishna''nın düğünü"},
    {"id":"b","text":"Krishna''nın doğum günü","correct":true},
    {"id":"c","text":"Krishna''nın ölümü"}
  ]}'::jsonb
WHERE prompt = 'Hva feires under Krishna Janmashtami?'
  AND type = 'mcq';

-- hinduisme-tekster (Texts) - Question 1
UPDATE public.questions SET
  prompt_en = 'The most important shruti scripture collection is ___.',
  prompt_tr = 'En önemli shruti yazı koleksiyonu ___''dir.',
  meta_en = '{"answer":"the Vedas"}'::jsonb,
  meta_tr = '{"answer":"Vedalar"}'::jsonb
WHERE prompt = 'Den viktigste shruti-skriftsamlingen er ___.'
  AND type = 'gap';

-- hinduisme-tekster - Question 2
UPDATE public.questions SET
  prompt_en = 'How old is the Rigveda, the oldest of the Vedas?',
  prompt_tr = 'Vedaların en eskisi olan Rigveda ne kadar eski?',
  meta_en = '{"choices":[
    {"id":"a","text":"500 years"},
    {"id":"b","text":"At least 3000 years","correct":true},
    {"id":"c","text":"100 years"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"500 yıl"},
    {"id":"b","text":"En az 3000 yıl","correct":true},
    {"id":"c","text":"100 yıl"}
  ]}'::jsonb
WHERE prompt = 'Hvor gammel er Rigveda, den eldste av Vedaene?'
  AND type = 'mcq';

-- hinduisme-tekster - Question 3
UPDATE public.questions SET
  prompt_en = 'Atman (the individual soul) is identical with Brahman (the universal soul) according to the Upanishads.',
  prompt_tr = 'Atman (bireysel ruh), Upanişadlara göre Brahman (evrensel ruh) ile aynıdır.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Atman (individets sjel) er identisk med Brahman (den universelle sjel) ifølge Upanishadene.'
  AND type = 'tf';

-- hinduisme-tekster - Question 4
UPDATE public.questions SET
  prompt_en = 'The ___ is an epic poem about Prince Rama''s battle against the demon king Ravana.',
  prompt_tr = '___, Prens Rama''nın şeytan kralı Ravana''ya karşı savaşını anlatan epik bir şiirdir.',
  meta_en = '{"answer":"Ramayana"}'::jsonb,
  meta_tr = '{"answer":"Ramayana"}'::jsonb
WHERE prompt = '___ er et epos om prins Ramas kamp mot demonkongen Ravana.'
  AND type = 'gap';

-- hinduisme-tekster - Question 5
UPDATE public.questions SET
  prompt_en = 'The Mahabharata is one of the longest epic poems in the world.',
  prompt_tr = 'Mahabharata dünyanın en uzun destanlarından biridir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Mahabharata er et av verdens lengste epos.'
  AND type = 'tf';

-- hinduisme-tekster - Question 6
UPDATE public.questions SET
  prompt_en = 'What symbol represents the sacred syllable in Hinduism?',
  prompt_tr = 'Hinduizm''de kutsal heceyi hangi sembol temsil eder?',
  meta_en = '{"choices":[
    {"id":"a","text":"The cross"},
    {"id":"b","text":"Om (ॐ)","correct":true},
    {"id":"c","text":"The crescent"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Haç"},
    {"id":"b","text":"Om (ॐ)","correct":true},
    {"id":"c","text":"Hilal"}
  ]}'::jsonb
WHERE prompt = 'Hvilket symbol representerer den hellige stavelsen i hinduismen?'
  AND type = 'mcq';

-- hinduisme-tekster - Question 7
UPDATE public.questions SET
  prompt_en = 'The ___ is a symbol of good fortune and is widely used in Hindu ceremonies.',
  prompt_tr = '___, iyi şansın sembolüdür ve Hindu törenlerde yaygın olarak kullanılır.',
  meta_en = '{"answer":"swastika"}'::jsonb,
  meta_tr = '{"answer":"svastika"}'::jsonb
WHERE prompt = '___ er et symbol på hell og lykke og brukes mye i hinduistiske seremonier.'
  AND type = 'gap';

-- hinduisme-moderne (Modern) - Question 1
UPDATE public.questions SET
  prompt_en = 'Hinduism is the dominant religion in India.',
  prompt_tr = 'Hinduizm Hindistan''da baskın dindir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Hinduismen er den dominerende religionen i India.'
  AND type = 'tf';

-- hinduisme-moderne - Question 2
UPDATE public.questions SET
  prompt_en = 'Approximately how many Hindus are there worldwide?',
  prompt_tr = 'Dünya çapında yaklaşık kaç Hindu vardır?',
  meta_en = '{"choices":[
    {"id":"a","text":"About 100 million"},
    {"id":"b","text":"About 1 billion","correct":true},
    {"id":"c","text":"About 5 billion"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Yaklaşık 100 milyon"},
    {"id":"b","text":"Yaklaşık 1 milyar","correct":true},
    {"id":"c","text":"Yaklaşık 5 milyar"}
  ]}'::jsonb
WHERE prompt = 'Hvor mange hinduer finnes det i verden i dag?'
  AND type = 'mcq';

-- hinduisme-moderne - Question 3
UPDATE public.questions SET
  prompt_en = 'Yoga and ___ have become popular worldwide.',
  prompt_tr = 'Yoga ve ___ dünya çapında popüler hale geldi.',
  meta_en = '{"answer":"meditation"}'::jsonb,
  meta_tr = '{"answer":"meditasyon"}'::jsonb
WHERE prompt = 'Yoga og ___ har blitt populære over hele verden.'
  AND type = 'gap';

-- hinduisme-moderne - Question 4
UPDATE public.questions SET
  prompt_en = 'Modern Hindus can freely choose which deities to worship.',
  prompt_tr = 'Modern Hindular hangi tanrılara ibadet edeceklerini özgürce seçebilirler.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Moderne hinduer kan fritt velge hvilke guddommer de ønsker å tilbe.'
  AND type = 'tf';

-- hinduisme-moderne - Question 5
UPDATE public.questions SET
  prompt_en = 'What has contributed to Hinduism spreading beyond India?',
  prompt_tr = 'Hinduizm''in Hindistan''ın ötesine yayılmasına ne katkıda bulundu?',
  meta_en = '{"choices":[
    {"id":"a","text":"War and conquest"},
    {"id":"b","text":"Migration and globalization","correct":true},
    {"id":"c","text":"Forced conversion"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Savaş ve fetih"},
    {"id":"b","text":"Göç ve küreselleşme","correct":true},
    {"id":"c","text":"Zorla din değiştirme"}
  ]}'::jsonb
WHERE prompt = 'Hva har bidratt til at hinduismen har spredt seg utenfor India?'
  AND type = 'mcq';

-- hinduisme-moderne - Question 6
UPDATE public.questions SET
  prompt_en = 'The caste system remains a controversial aspect of Hindu society.',
  prompt_tr = 'Kast sistemi Hindu toplumunun tartışmalı bir yönü olmaya devam ediyor.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Kastesystemet er fortsatt et kontroversielt aspekt ved det hinduistiske samfunnet.'
  AND type = 'tf';

-- hinduisme-moderne - Question 7
UPDATE public.questions SET
  prompt_en = '___ was a Hindu leader who promoted non-violence and civil rights.',
  prompt_tr = '___, şiddet karşıtlığını ve sivil hakları teşvik eden bir Hindu liderdi.',
  meta_en = '{"answer":"Gandhi"}'::jsonb,
  meta_tr = '{"answer":"Gandhi"}'::jsonb
WHERE prompt = '___ var en hinduistisk leder som fremmet ikke-vold og sivile rettigheter.'
  AND type = 'gap';


