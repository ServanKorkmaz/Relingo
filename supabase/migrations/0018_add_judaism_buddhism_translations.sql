-- Add English and Turkish translations for Judaism and Buddhism quiz questions
-- This is a continuation of the translation migration series

-- ==================== JUDAISM LESSONS ====================

-- jodedom-opprinnelse (Origins) - Question 1
UPDATE public.questions SET
  prompt_en = 'According to Jewish tradition, the patriarch ___ (approx. 1800 BCE) made a covenant with one God.',
  prompt_tr = 'Yahudi geleneğine göre, patrik ___ (yaklaşık MÖ 1800) tek bir Tanrı ile antlaşma yaptı.',
  meta_en = '{"answer":"Abraham"}'::jsonb,
  meta_tr = '{"answer":"İbrahim"}'::jsonb
WHERE prompt = 'Ifølge jødisk tradisjon inngikk patriarken ___ (ca. 1800 fvt.) en pakt med én Gud.'
  AND type = 'gap';

-- jodedom-opprinnelse - Question 2
UPDATE public.questions SET
  prompt_en = 'Who received the law (Torah) on Mount Sinai?',
  prompt_tr = 'Sina Dağı''nda yasayı (Tevrat) kim aldı?',
  meta_en = '{"choices":[
    {"id":"a","text":"Abraham"},
    {"id":"b","text":"Moses","correct":true},
    {"id":"c","text":"David"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"İbrahim"},
    {"id":"b","text":"Musa","correct":true},
    {"id":"c","text":"Davut"}
  ]}'::jsonb
WHERE prompt = 'Hvem mottok loven (Toraen) på Sinaifjellet?'
  AND type = 'mcq';

-- jodedom-opprinnelse - Question 3
UPDATE public.questions SET
  prompt_en = 'King Solomon built the first temple in ___.',
  prompt_tr = 'Kral Süleyman ilk mabedi ___''de inşa etti.',
  meta_en = '{"answer":"Jerusalem"}'::jsonb,
  meta_tr = '{"answer":"Kudüs"}'::jsonb
WHERE prompt = 'Kong Salomo bygde det første tempelet i ___.'
  AND type = 'gap';

-- jodedom-opprinnelse - Question 4
UPDATE public.questions SET
  prompt_en = 'When did the Romans destroy the Second Temple?',
  prompt_tr = 'Romalılar İkinci Mabedi ne zaman yıktı?',
  meta_en = '{"choices":[
    {"id":"a","text":"586 BCE"},
    {"id":"b","text":"70 CE","correct":true},
    {"id":"c","text":"1948"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"MÖ 586"},
    {"id":"b","text":"MS 70","correct":true},
    {"id":"c","text":"1948"}
  ]}'::jsonb
WHERE prompt = 'Når ødela romerne det andre tempelet?'
  AND type = 'mcq';

-- jodedom-opprinnelse - Question 5
UPDATE public.questions SET
  prompt_en = 'The Holocaust during World War II took the lives of approximately six million European Jews.',
  prompt_tr = 'İkinci Dünya Savaşı sırasındaki Holokost yaklaşık altı milyon Avrupalı Yahudi''nin hayatını aldı.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Holocaust under andre verdenskrig tok livet av omkring seks millioner europeiske jøder.'
  AND type = 'tf';

-- jodedom-opprinnelse - Question 6
UPDATE public.questions SET
  prompt_en = 'In what year was the State of Israel established?',
  prompt_tr = 'İsrail Devleti hangi yıl kuruldu?',
  meta_en = '{"choices":[
    {"id":"a","text":"1917"},
    {"id":"b","text":"1948","correct":true},
    {"id":"c","text":"1967"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"1917"},
    {"id":"b","text":"1948","correct":true},
    {"id":"c","text":"1967"}
  ]}'::jsonb
WHERE prompt = 'I hvilket år ble staten Israel etablert?'
  AND type = 'mcq';

-- jodedom-opprinnelse - Question 7
UPDATE public.questions SET
  prompt_en = 'The ___ is all that remains of the Second Temple and is a holy site for Jews.',
  prompt_tr = '___, İkinci Mabetten geriye kalan tek şeydir ve Yahudiler için kutsal bir yerdir.',
  meta_en = '{"answer":"Western Wall"}'::jsonb,
  meta_tr = '{"answer":"Ağlama Duvarı"}'::jsonb
WHERE prompt = '___ er det eneste som er igjen av det andre tempelet og er et hellig sted for jøder.'
  AND type = 'gap';

-- jodedom-tro (Beliefs) - Question 1
UPDATE public.questions SET
  prompt_en = 'Judaism is the oldest of the Abrahamic religions.',
  prompt_tr = 'Yahudilik İbrahimi dinlerin en eskisidir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Jødedommen er den eldste av de abrahamittiske religionene.'
  AND type = 'tf'
  AND order_index = 0;

-- jodedom-tro - Question 2
UPDATE public.questions SET
  prompt_en = 'What is the covenant between God and the Jewish people?',
  prompt_tr = 'Tanrı ve Yahudi halkı arasındaki antlaşma nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"A political agreement"},
    {"id":"b","text":"A sacred promise of mutual obligations","correct":true},
    {"id":"c","text":"A trade treaty"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Politik bir anlaşma"},
    {"id":"b","text":"Karşılıklı yükümlülüklerin kutsal vaadi","correct":true},
    {"id":"c","text":"Bir ticaret antlaşması"}
  ]}'::jsonb
WHERE prompt = 'Hva er pakten mellom Gud og det jødiske folk?'
  AND type = 'mcq';

-- jodedom-tro - Question 3
UPDATE public.questions SET
  prompt_en = 'The Jewish people are called God''s ___ people.',
  prompt_tr = 'Yahudi halkı Tanrı''nın ___ halkı olarak adlandırılır.',
  meta_en = '{"answer":"chosen"}'::jsonb,
  meta_tr = '{"answer":"seçilmiş"}'::jsonb
WHERE prompt = 'Det jødiske folk kalles Guds ___ folk.'
  AND type = 'gap';

-- jodedom-tro - Question 4
UPDATE public.questions SET
  prompt_en = 'The ___ is the central prayer in Judaism that proclaims belief in one God.',
  prompt_tr = '___, Yahudilik''te tek bir Tanrı''ya inancı bildiren merkezi duadır.',
  meta_en = '{"answer":"Shema"}'::jsonb,
  meta_tr = '{"answer":"Şema"}'::jsonb
WHERE prompt = '___ er den sentrale bønnen i jødedommen som forkynner troen på én Gud.'
  AND type = 'gap';

-- jodedom-tro - Question 5
UPDATE public.questions SET
  prompt_en = 'Judaism believes in a coming Messiah who will bring peace and justice.',
  prompt_tr = 'Yahudilik, barış ve adalet getirecek gelecek bir Mesih''e inanır.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Jødedommen tror på en kommende Messias som skal bringe fred og rettferdighet.'
  AND type = 'tf';

-- jodedom-tro - Question 6
UPDATE public.questions SET
  prompt_en = 'What is emphasized more in Judaism?',
  prompt_tr = 'Yahudilik''te neye daha fazla vurgu yapılır?',
  meta_en = '{"choices":[
    {"id":"a","text":"Afterlife and heaven"},
    {"id":"b","text":"Righteous living in this life","correct":true},
    {"id":"c","text":"Material wealth"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Öbür dünya ve cennet"},
    {"id":"b","text":"Bu yaşamda dürüst yaşamak","correct":true},
    {"id":"c","text":"Maddi zenginlik"}
  ]}'::jsonb
WHERE prompt = 'Hva vektlegges mer i jødedommen?'
  AND type = 'mcq';

-- jodedom-tro - Question 7
UPDATE public.questions SET
  prompt_en = 'Jews strive to follow God''s ___ (commandments).',
  prompt_tr = 'Yahudiler Tanrı''nın ___ (emirleri) takip etmeye çalışırlar.',
  meta_en = '{"answer":"mitzvot"}'::jsonb,
  meta_tr = '{"answer":"mitsvot"}'::jsonb
WHERE prompt = 'Jøder streber etter å følge Guds ___ (bud).'
  AND type = 'gap';

-- jodedom-praksis (Practices) - Question 1
UPDATE public.questions SET
  prompt_en = 'The Sabbath (Shabbat) is the Jewish day of rest and begins on Friday evening.',
  prompt_tr = 'Şabat (Şabat), Yahudi dinlenme günüdür ve Cuma akşamı başlar.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Sabbaten (shabbat) er den jødiske hviledagen og begynner fredag kveld.'
  AND type = 'tf';

-- jodedom-praksis - Question 2
UPDATE public.questions SET
  prompt_en = 'What are kosher dietary laws?',
  prompt_tr = 'Koşer beslenme kuralları nelerdir?',
  meta_en = '{"choices":[
    {"id":"a","text":"Rules for exercise"},
    {"id":"b","text":"Jewish dietary regulations","correct":true},
    {"id":"c","text":"Meditation guidelines"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Egzersiz kuralları"},
    {"id":"b","text":"Yahudi beslenme düzenlemeleri","correct":true},
    {"id":"c","text":"Meditasyon yönergeleri"}
  ]}'::jsonb
WHERE prompt = 'Hva er kosher-regler?'
  AND type = 'mcq';

-- jodedom-praksis - Question 3
UPDATE public.questions SET
  prompt_en = '___ is the Jewish house of worship.',
  prompt_tr = '___, Yahudi ibadet evidir.',
  meta_en = '{"answer":"Synagogue"}'::jsonb,
  meta_tr = '{"answer":"Sinagog"}'::jsonb
WHERE prompt = '___ er det jødiske bedehuset.'
  AND type = 'gap';

-- jodedom-praksis - Question 4
UPDATE public.questions SET
  prompt_en = 'Jewish boys undergo ___ (ritual circumcision) eight days after birth.',
  prompt_tr = 'Yahudi erkek çocuklar doğumdan sekiz gün sonra ___ (ritüel sünnet) olurlar.',
  meta_en = '{"answer":"brit milah"}'::jsonb,
  meta_tr = '{"answer":"brit milah"}'::jsonb
WHERE prompt = 'Jødiske gutter gjennomgår ___ (rituell omskjæring) åtte dager etter fødselen.'
  AND type = 'gap';

-- jodedom-praksis - Question 5
UPDATE public.questions SET
  prompt_en = 'Bar Mitzvah (for boys) and Bat Mitzvah (for girls) mark coming of age.',
  prompt_tr = 'Bar Mitzvah (erkekler için) ve Bat Mitzvah (kızlar için) ergenliğe gelişi işaret eder.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Bar Mitzvah (for gutter) og Bat Mitzvah (for jenter) markerer myndiggjøring.'
  AND type = 'tf';

-- jodedom-praksis - Question 6
UPDATE public.questions SET
  prompt_en = 'What is tefillin?',
  prompt_tr = 'Tefillín nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"A type of food"},
    {"id":"b","text":"Small prayer boxes worn during prayer","correct":true},
    {"id":"c","text":"A holiday"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Bir yiyecek türü"},
    {"id":"b","text":"Dua sırasında takılan küçük dua kutuları","correct":true},
    {"id":"c","text":"Bir bayram"}
  ]}'::jsonb
WHERE prompt = 'Hva er tefillin?'
  AND type = 'mcq';

-- jodedom-praksis - Question 7
UPDATE public.questions SET
  prompt_en = 'Jewish men traditionally wear a ___ (head covering) during prayer.',
  prompt_tr = 'Yahudi erkekler geleneksel olarak dua sırasında ___ (baş örtüsü) takarlar.',
  meta_en = '{"answer":"kippah"}'::jsonb,
  meta_tr = '{"answer":"kipa"}'::jsonb
WHERE prompt = 'Jødiske menn bærer tradisjonelt en ___ (hodeplagg) under bønn.'
  AND type = 'gap';

-- jodedom-hoytider (Holidays) - Question 1
UPDATE public.questions SET
  prompt_en = 'Rosh Hashanah is the Jewish New Year.',
  prompt_tr = 'Roş Aşana Yahudi Yeni Yılı''dır.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Rosh Hashanah er det jødiske nyttåret.'
  AND type = 'tf';

-- jodedom-hoytider - Question 2
UPDATE public.questions SET
  prompt_en = 'What is Yom Kippur?',
  prompt_tr = 'Yom Kippur nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"A wedding ceremony"},
    {"id":"b","text":"The Day of Atonement and the holiest day","correct":true},
    {"id":"c","text":"A harvest festival"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Bir düğün töreni"},
    {"id":"b","text":"Kefaret Günü ve en kutsal gün","correct":true},
    {"id":"c","text":"Bir hasat festivali"}
  ]}'::jsonb
WHERE prompt = 'Hva er Yom Kippur?'
  AND type = 'mcq';

-- jodedom-hoytider - Question 3
UPDATE public.questions SET
  prompt_en = '___ commemorates the Israelites'' exodus from Egypt.',
  prompt_tr = '___, İsraillilerin Mısır''dan çıkışını anımsar.',
  meta_en = '{"answer":"Passover"}'::jsonb,
  meta_tr = '{"answer":"Pesah"}'::jsonb
WHERE prompt = '___ minnes israelittenes utvandring fra Egypt.'
  AND type = 'gap';

-- jodedom-hoytider - Question 4
UPDATE public.questions SET
  prompt_en = 'Hanukkah lasts eight days and celebrates the rededication of the Temple.',
  prompt_tr = 'Hanuka sekiz gün sürer ve Mabedi''nin yeniden adanmasını kutlar.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Hanukkah varer i åtte dager og feirer gjennvielsen av tempelet.'
  AND type = 'tf';

-- jodedom-hoytider - Question 5
UPDATE public.questions SET
  prompt_en = 'What is lit during Hanukkah?',
  prompt_tr = 'Hanuka sırasında ne yakılır?',
  meta_en = '{"choices":[
    {"id":"a","text":"A Christmas tree"},
    {"id":"b","text":"A menorah (nine-branched candelabra)","correct":true},
    {"id":"c","text":"Incense"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Noel ağacı"},
    {"id":"b","text":"Menora (dokuz kollu şamdan)","correct":true},
    {"id":"c","text":"Tütsü"}
  ]}'::jsonb
WHERE prompt = 'Hva tennes under Hanukkah?'
  AND type = 'mcq';

-- jodedom-hoytider - Question 6
UPDATE public.questions SET
  prompt_en = '___ is a festive holiday that celebrates the salvation of Jews in ancient Persia.',
  prompt_tr = '___, antik Pers''te Yahudilerin kurtuluşunu kutlayan şenlikli bir bayramdır.',
  meta_en = '{"answer":"Purim"}'::jsonb,
  meta_tr = '{"answer":"Purim"}'::jsonb
WHERE prompt = '___ er en festlig høytid som feirer jødenes redning i det gamle Persia.'
  AND type = 'gap';

-- jodedom-hoytider - Question 7
UPDATE public.questions SET
  prompt_en = 'Sukkot is a harvest festival where Jews build temporary booths.',
  prompt_tr = 'Sukkot, Yahudilerin geçici çardaklar kurduğu bir hasat festivalidir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Sukkot er en høstfest hvor jøder bygger midlertidige hytter.'
  AND type = 'tf';

-- jodedom-tekster (Texts) - Question 1
UPDATE public.questions SET
  prompt_en = 'The ___ is the Jewish holy book.',
  prompt_tr = '___, Yahudi kutsal kitabıdır.',
  meta_en = '{"answer":"Tanakh"}'::jsonb,
  meta_tr = '{"answer":"Tanah"}'::jsonb
WHERE prompt = '___ er den jødiske hellige boken.'
  AND type = 'gap';

-- jodedom-tekster - Question 2
UPDATE public.questions SET
  prompt_en = 'The Tanakh consists of three parts: Torah, Nevi''im (Prophets), and Ketuvim (Writings).',
  prompt_tr = 'Tanah üç bölümden oluşur: Tevrat, Neviim (Peygamberler) ve Ketuvim (Yazılar).',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Tanakh består av tre deler: Tora, Nevi''im (Profetene), og Ketuvim (Skriftene).'
  AND type = 'tf';

-- jodedom-tekster - Question 3
UPDATE public.questions SET
  prompt_en = 'What is the Torah?',
  prompt_tr = 'Tevrat nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"A prayer book"},
    {"id":"b","text":"The first five books of the Bible","correct":true},
    {"id":"c","text":"A temple"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Bir dua kitabı"},
    {"id":"b","text":"İncil''in ilk beş kitabı","correct":true},
    {"id":"c","text":"Bir mabed"}
  ]}'::jsonb
WHERE prompt = 'Hva er Toraen?'
  AND type = 'mcq';

-- jodedom-tekster - Question 4
UPDATE public.questions SET
  prompt_en = 'The ___ is an extensive collection of Jewish oral law and commentary.',
  prompt_tr = '___, Yahudi sözlü yasasının ve yorumların kapsamlı bir koleksiyonudur.',
  meta_en = '{"answer":"Talmud"}'::jsonb,
  meta_tr = '{"answer":"Talmud"}'::jsonb
WHERE prompt = '___ er en omfattende samling av jødisk muntlig lov og kommentarer.'
  AND type = 'gap';

-- jodedom-tekster - Question 5
UPDATE public.questions SET
  prompt_en = 'The Star of David is a prominent Jewish symbol.',
  prompt_tr = 'Davut Yıldızı, öne çıkan bir Yahudi sembolüdür.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Davidsstjernen er et fremtredende jødisk symbol.'
  AND type = 'tf';

-- jodedom-tekster - Question 6
UPDATE public.questions SET
  prompt_en = 'What is a mezuzah?',
  prompt_tr = 'Mezuza nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"A type of food"},
    {"id":"b","text":"A small case containing scripture attached to doorframes","correct":true},
    {"id":"c","text":"A musical instrument"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Bir yiyecek türü"},
    {"id":"b","text":"Kapı kasalarına takılan kutsal metin içeren küçük bir kutu","correct":true},
    {"id":"c","text":"Bir müzik aleti"}
  ]}'::jsonb
WHERE prompt = 'Hva er en mezuzah?'
  AND type = 'mcq';

-- jodedom-tekster - Question 7
UPDATE public.questions SET
  prompt_en = 'The ___ is a candelabra with seven branches and is an ancient Jewish symbol.',
  prompt_tr = '___, yedi kollu bir şamdandır ve antik bir Yahudi sembolüdür.',
  meta_en = '{"answer":"menorah"}'::jsonb,
  meta_tr = '{"answer":"menora"}'::jsonb
WHERE prompt = '___ er en lysestake med sju armer og er et gammelt jødisk symbol.'
  AND type = 'gap';

-- jodedom-moderne (Modern) - Question 1
UPDATE public.questions SET
  prompt_en = 'There are approximately 15 million Jews worldwide.',
  prompt_tr = 'Dünya çapında yaklaşık 15 milyon Yahudi vardır.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Det finnes ca. 15 millioner jøder i verden.'
  AND type = 'tf';

-- jodedom-moderne - Question 2
UPDATE public.questions SET
  prompt_en = 'What are the three main branches of Judaism?',
  prompt_tr = 'Yahudilik''in üç ana dalı nelerdir?',
  meta_en = '{"choices":[
    {"id":"a","text":"Catholic, Protestant, Orthodox"},
    {"id":"b","text":"Orthodox, Conservative, Reform","correct":true},
    {"id":"c","text":"Sunni, Shia, Sufi"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Katolik, Protestan, Ortodoks"},
    {"id":"b","text":"Ortodoks, Muhafazakâr, Reform","correct":true},
    {"id":"c","text":"Sünni, Şii, Sufi"}
  ]}'::jsonb
WHERE prompt = 'Hva er de tre hovedgrenene innen jødedommen?'
  AND type = 'mcq';

-- jodedom-moderne - Question 3
UPDATE public.questions SET
  prompt_en = '___ Judaism emphasizes strict adherence to traditional law and practice.',
  prompt_tr = '___ Yahudilik, geleneksel yasa ve uygulamalara sıkı bağlılığı vurgular.',
  meta_en = '{"answer":"Orthodox"}'::jsonb,
  meta_tr = '{"answer":"Ortodoks"}'::jsonb
WHERE prompt = '___ jødedom legger vekt på streng overholdelse av tradisjonell lov og praksis.'
  AND type = 'gap';

-- jodedom-moderne - Question 4
UPDATE public.questions SET
  prompt_en = 'Reform Judaism allows for modern interpretation and adaptation.',
  prompt_tr = 'Reform Yahudilik modern yorumlama ve uyarlamaya izin verir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Reformjødedom tillater moderne tolkning og tilpasning.'
  AND type = 'tf';

-- jodedom-moderne - Question 5
UPDATE public.questions SET
  prompt_en = 'Where do most Jews live today?',
  prompt_tr = 'Bugün çoğu Yahudi nerede yaşıyor?',
  meta_en = '{"choices":[
    {"id":"a","text":"Europe"},
    {"id":"b","text":"Israel and the USA","correct":true},
    {"id":"c","text":"South America"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Avrupa"},
    {"id":"b","text":"İsrail ve ABD","correct":true},
    {"id":"c","text":"Güney Amerika"}
  ]}'::jsonb
WHERE prompt = 'Hvor bor de fleste jødene i dag?'
  AND type = 'mcq';

-- jodedom-moderne - Question 6
UPDATE public.questions SET
  prompt_en = 'Modern Judaism faces challenges balancing tradition with ___ society.',
  prompt_tr = 'Modern Yahudilik, gelenek ile ___ toplum arasında denge kurma zorlukları yaşıyor.',
  meta_en = '{"answer":"secular"}'::jsonb,
  meta_tr = '{"answer":"laik"}'::jsonb
WHERE prompt = 'Moderne jødedom møter utfordringer med å balansere tradisjon med ___ samfunn.'
  AND type = 'gap';

-- jodedom-moderne - Question 7
UPDATE public.questions SET
  prompt_en = 'The Holocaust Memorial Day (Yom HaShoah) commemorates the victims of the Holocaust.',
  prompt_tr = 'Holokost Anma Günü (Yom HaShoah), Holokost kurbanlarını anımsar.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Holocaust-minnedagen (Yom HaShoah) minnes ofrene for Holocaust.'
  AND type = 'tf';

-- ==================== BUDDHISM LESSONS ====================

-- buddhisme-opprinnelse (Origins) - Question 1
UPDATE public.questions SET
  prompt_en = 'Where did Buddhism originate?',
  prompt_tr = 'Budizm nerede ortaya çıktı?',
  meta_en = '{"choices":[
    {"id":"a","text":"China"},
    {"id":"b","text":"North India","correct":true},
    {"id":"c","text":"Tibet"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Çin"},
    {"id":"b","text":"Kuzey Hindistan","correct":true},
    {"id":"c","text":"Tibet"}
  ]}'::jsonb
WHERE prompt = 'Hvor oppstod buddhismen?'
  AND type = 'mcq'
  AND order_index = 0;

-- buddhisme-opprinnelse - Question 2
UPDATE public.questions SET
  prompt_en = 'Buddhism was founded by ___ Gautama, who later became known as Buddha.',
  prompt_tr = 'Budizm, daha sonra Buda olarak bilinen ___ Gautama tarafından kuruldu.',
  meta_en = '{"answer":"Siddhartha"}'::jsonb,
  meta_tr = '{"answer":"Siddhartha"}'::jsonb
WHERE prompt = 'Buddhismen ble grunnlagt av ___ Gautama, som senere ble kjent som Buddha.'
  AND type = 'gap';

-- buddhisme-opprinnelse - Question 3
UPDATE public.questions SET
  prompt_en = 'Approximately how long ago did Buddhism originate?',
  prompt_tr = 'Budizm yaklaşık ne kadar zaman önce ortaya çıktı?',
  meta_en = '{"choices":[
    {"id":"a","text":"2500 years ago","correct":true},
    {"id":"b","text":"1000 years ago"},
    {"id":"c","text":"5000 years ago"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"2500 yıl önce","correct":true},
    {"id":"b","text":"1000 yıl önce"},
    {"id":"c","text":"5000 yıl önce"}
  ]}'::jsonb
WHERE prompt = 'For omtrent hvor lenge siden oppstod buddhismen?'
  AND type = 'mcq';

-- buddhisme-opprinnelse - Question 4
UPDATE public.questions SET
  prompt_en = 'The early Buddhist monastic order (sangha) played a key role in spreading Buddha''s teachings.',
  prompt_tr = 'Erken Budist keşiş düzeni (sangha), Buda''nın öğretilerini yaymada kilit bir rol oynadı.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Den tidlige buddhistiske munkeordenen (sangha) spilte en nøkkelrolle i å spre Buddhas lære.'
  AND type = 'tf';

-- buddhisme-opprinnelse - Question 5
UPDATE public.questions SET
  prompt_en = 'Which emperor promoted Buddhism as a state religion in the 3rd century BCE?',
  prompt_tr = 'Hangi imparator MÖ 3. yüzyılda Budizm''i devlet dini olarak teşvik etti?',
  meta_en = '{"choices":[
    {"id":"a","text":"Ashoka","correct":true},
    {"id":"b","text":"Qin Shi Huang"},
    {"id":"c","text":"Genghis Khan"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Aşoka","correct":true},
    {"id":"b","text":"Qin Shi Huang"},
    {"id":"c","text":"Cengiz Han"}
  ]}'::jsonb
WHERE prompt = 'Hvilken keiser fremmet buddhismen som statsreligion på 200-tallet fvt?'
  AND type = 'mcq';

-- buddhisme-opprinnelse - Question 6
UPDATE public.questions SET
  prompt_en = 'Buddhism spread along the ___ Road to Central Asia and China.',
  prompt_tr = 'Budizm, Orta Asya ve Çin''e ___ Yolu boyunca yayıldı.',
  meta_en = '{"answer":"Silk"}'::jsonb,
  meta_tr = '{"answer":"İpek"}'::jsonb
WHERE prompt = 'Buddhismen spredte seg langs ___veien til Sentral-Asia og Kina.'
  AND type = 'gap';

-- buddhisme-opprinnelse - Question 7
UPDATE public.questions SET
  prompt_en = 'Buddhism developed into two main branches: Theravada and Mahayana.',
  prompt_tr = 'Budizm iki ana dala ayrıldı: Theravada ve Mahayana.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Buddhismen utviklet seg til to hovedgrener: Theravada og Mahayana.'
  AND type = 'tf';

-- buddhisme-tro (Beliefs) - Question 1
UPDATE public.questions SET
  prompt_en = 'The ___ Noble Truths are the foundation of Buddhist teaching.',
  prompt_tr = 'Dört Asil Gerçek, Budist öğretinin temelini oluşturur.',
  meta_en = '{"answer":"Four"}'::jsonb,
  meta_tr = '{"answer":"Dört"}'::jsonb
WHERE prompt = 'De ___ edle sannheter er grunnlaget for buddhistisk lære.'
  AND type = 'gap';

-- buddhisme-tro - Question 2
UPDATE public.questions SET
  prompt_en = 'What is dukkha in Buddhism?',
  prompt_tr = 'Budizm''de dukkha nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"Eternal happiness"},
    {"id":"b","text":"Suffering or dissatisfaction","correct":true},
    {"id":"c","text":"A temple"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Sonsuz mutluluk"},
    {"id":"b","text":"Acı veya tatminsizlik","correct":true},
    {"id":"c","text":"Bir mabed"}
  ]}'::jsonb
WHERE prompt = 'Hva er dukkha i buddhismen?'
  AND type = 'mcq';

-- buddhisme-tro - Question 3
UPDATE public.questions SET
  prompt_en = 'Buddhism teaches that suffering arises from desire and attachment.',
  prompt_tr = 'Budizm, acının arzudan ve bağlanmadan kaynaklandığını öğretir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Buddhismen lærer at lidelse oppstår fra begjær og tilknytning.'
  AND type = 'tf';

-- buddhisme-tro - Question 4
UPDATE public.questions SET
  prompt_en = 'The path to liberation from suffering is called the ___fold Path.',
  prompt_tr = 'Acıdan kurtuluş yoluna ___ Katlı Yol denir.',
  meta_en = '{"answer":"Eightfold"}'::jsonb,
  meta_tr = '{"answer":"Sekiz"}'::jsonb
WHERE prompt = 'Veien til frigjøring fra lidelse kalles den ___delte vei.'
  AND type = 'gap';

-- buddhisme-tro - Question 5
UPDATE public.questions SET
  prompt_en = 'What is nirvana in Buddhism?',
  prompt_tr = 'Budizm''de nirvana nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"A meditation technique"},
    {"id":"b","text":"The state of liberation from suffering and the cycle of rebirth","correct":true},
    {"id":"c","text":"A Buddhist temple"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Bir meditasyon tekniği"},
    {"id":"b","text":"Acıdan ve yeniden doğuş döngüsünden kurtuluş durumu","correct":true},
    {"id":"c","text":"Bir Budist tapınağı"}
  ]}'::jsonb
WHERE prompt = 'Hva er nirvana i buddhismen?'
  AND type = 'mcq';

-- buddhisme-tro - Question 6
UPDATE public.questions SET
  prompt_en = 'Buddhism believes in ___, the cycle of rebirth influenced by karma.',
  prompt_tr = 'Budizm, karma tarafından etkilenen yeniden doğuş döngüsü olan ___''a inanır.',
  meta_en = '{"answer":"samsara"}'::jsonb,
  meta_tr = '{"answer":"samsara"}'::jsonb
WHERE prompt = 'Buddhismen tror på ___, kretsløpet av gjenfødsel påvirket av karma.'
  AND type = 'gap';

-- buddhisme-tro - Question 7
UPDATE public.questions SET
  prompt_en = 'The Middle Way teaches avoiding extremes of luxury and self-mortification.',
  prompt_tr = 'Orta Yol, lüks ve kendine işkence etme uçlarından kaçınmayı öğretir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Middelveien lærer å unngå ekstremer av luksus og selvpining.'
  AND type = 'tf';

-- buddhisme-praksis (Practices) - Question 1
UPDATE public.questions SET
  prompt_en = '___ is a central practice in Buddhism for developing mindfulness.',
  prompt_tr = '___, farkındalık geliştirmek için Budizm''de merkezi bir uygulamadır.',
  meta_en = '{"answer":"Meditation"}'::jsonb,
  meta_tr = '{"answer":"Meditasyon"}'::jsonb
WHERE prompt = '___ er en sentral praksis i buddhismen for å utvikle oppmerksom tilstedeværelse.'
  AND type = 'gap';

-- buddhisme-praksis - Question 2
UPDATE public.questions SET
  prompt_en = 'What is metta?',
  prompt_tr = 'Metta nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"A type of food"},
    {"id":"b","text":"Loving-kindness meditation","correct":true},
    {"id":"c","text":"A temple"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Bir yiyecek türü"},
    {"id":"b","text":"Sevgi-nezaket meditasyonu","correct":true},
    {"id":"c","text":"Bir tapınak"}
  ]}'::jsonb
WHERE prompt = 'Hva er metta?'
  AND type = 'mcq';

-- buddhisme-praksis - Question 3
UPDATE public.questions SET
  prompt_en = 'Buddhist monks live by the Five Precepts and additional monastic rules.',
  prompt_tr = 'Budist keşişler Beş Prensip ve ek manastır kurallarına göre yaşarlar.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Buddhistiske munker lever etter De fem budene og tilleggsregler for munkene.'
  AND type = 'tf';

-- buddhisme-praksis - Question 4
UPDATE public.questions SET
  prompt_en = 'The Five Precepts include refraining from killing, stealing, sexual misconduct, lying, and ___.',
  prompt_tr = 'Beş Prensip öldürmekten, çalmaktan, cinsel suistimalden, yalan söylemekten ve ___''den kaçınmayı içerir.',
  meta_en = '{"answer":"intoxication"}'::jsonb,
  meta_tr = '{"answer":"sarhoşluktan"}'::jsonb
WHERE prompt = 'De fem budene inkluderer å avstå fra å drepe, stjele, seksuell misforhold, lyve og ___.'
  AND type = 'gap';

-- buddhisme-praksis - Question 5
UPDATE public.questions SET
  prompt_en = 'What is a stupa?',
  prompt_tr = 'Stupa nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"A Buddhist scripure"},
    {"id":"b","text":"A dome-shaped monument containing relics","correct":true},
    {"id":"c","text":"A meditation technique"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Bir Budist yazıt"},
    {"id":"b","text":"Kalıntılar içeren kubbe şeklinde anıt","correct":true},
    {"id":"c","text":"Bir meditasyon tekniği"}
  ]}'::jsonb
WHERE prompt = 'Hva er en stupa?'
  AND type = 'mcq';

-- buddhisme-praksis - Question 6
UPDATE public.questions SET
  prompt_en = 'Many Buddhists practice chanting as a form of devotion.',
  prompt_tr = 'Birçok Budist adanmışlık formu olarak ilahi söylemeyi uygular.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Mange buddhister praktiserer chanting som en form for hengivenhet.'
  AND type = 'tf';

-- buddhisme-praksis - Question 7
UPDATE public.questions SET
  prompt_en = 'Buddhists show respect by making ___ of flowers, incense, and candles.',
  prompt_tr = 'Budistler çiçek, tütsü ve mum ___''ı yaparak saygı gösterirler.',
  meta_en = '{"answer":"offerings"}'::jsonb,
  meta_tr = '{"answer":"sunularını"}'::jsonb
WHERE prompt = 'Buddhister viser respekt ved å gi ___ av blomster, røkelse og lys.'
  AND type = 'gap';

-- buddhisme-hoytider (Holidays) - Question 1
UPDATE public.questions SET
  prompt_en = 'Vesak celebrates Buddha''s birth, enlightenment, and death.',
  prompt_tr = 'Vesak, Buda''nın doğumunu, aydınlanmasını ve ölümünü kutlar.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Vesak feirer Buddhas fødsel, opplysning og død.'
  AND type = 'tf';

-- buddhisme-hoytider - Question 2
UPDATE public.questions SET
  prompt_en = 'When is Vesak typically celebrated?',
  prompt_tr = 'Vesak genellikle ne zaman kutlanır?',
  meta_en = '{"choices":[
    {"id":"a","text":"December"},
    {"id":"b","text":"Full moon in May","correct":true},
    {"id":"c","text":"January"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Aralık"},
    {"id":"b","text":"Mayıs''ta dolunay","correct":true},
    {"id":"c","text":"Ocak"}
  ]}'::jsonb
WHERE prompt = 'Når feires Vesak vanligvis?'
  AND type = 'mcq';

-- buddhisme-hoytider - Question 3
UPDATE public.questions SET
  prompt_en = '___ marks the beginning of the rainy season retreat for monks.',
  prompt_tr = '___, keşişler için yağmur mevsimi inzivasının başlangıcını işaret eder.',
  meta_en = '{"answer":"Vassa"}'::jsonb,
  meta_tr = '{"answer":"Vassa"}'::jsonb
WHERE prompt = '___ markerer begynnelsen av regntidstilbaketrekningen for munker.'
  AND type = 'gap';

-- buddhisme-hoytider - Question 4
UPDATE public.questions SET
  prompt_en = 'Losar is the Tibetan Buddhist New Year.',
  prompt_tr = 'Losar, Tibet Budist Yeni Yılı''dır.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Losar er det tibetanske buddhistiske nyttåret.'
  AND type = 'tf';

-- buddhisme-hoytider - Question 5
UPDATE public.questions SET
  prompt_en = 'What is Bodhi Day?',
  prompt_tr = 'Bodhi Günü nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"Buddha''s birthday"},
    {"id":"b","text":"Buddha''s enlightenment","correct":true},
    {"id":"c","text":"Buddha''s first sermon"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Buda''nın doğum günü"},
    {"id":"b","text":"Buda''nın aydınlanması","correct":true},
    {"id":"c","text":"Buda''nın ilk vaazı"}
  ]}'::jsonb
WHERE prompt = 'Hva er Bodhi Day?'
  AND type = 'mcq';

-- buddhisme-hoytider - Question 6
UPDATE public.questions SET
  prompt_en = 'During Kathina, lay Buddhists offer ___ to monks.',
  prompt_tr = 'Kathina sırasında laik Budistler keşişlere ___ sunarlar.',
  meta_en = '{"answer":"robes"}'::jsonb,
  meta_tr = '{"answer":"cüppe"}'::jsonb
WHERE prompt = 'Under Kathina tilbyr buddhistiske legfolk ___ til munkene.'
  AND type = 'gap';

-- buddhisme-hoytider - Question 7
UPDATE public.questions SET
  prompt_en = 'Uposatha days are Buddhist observance days occurring on full and new moon.',
  prompt_tr = 'Uposatha günleri, dolunay ve yeni ayda meydana gelen Budist gözlem günleridir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Uposatha-dager er buddhistiske observansedager som skjer ved fullmåne og nymåne.'
  AND type = 'tf';

-- buddhisme-tekster (Texts) - Question 1
UPDATE public.questions SET
  prompt_en = 'The ___ is the Pali Canon, the earliest collection of Buddhist scriptures.',
  prompt_tr = '___, Budist yazıtların en erken koleksiyonu olan Pali Kanonu''dur.',
  meta_en = '{"answer":"Tripitaka"}'::jsonb,
  meta_tr = '{"answer":"Tripitaka"}'::jsonb
WHERE prompt = '___ er Pali-kanon, den tidligste samlingen av buddhistiske skrifter.'
  AND type = 'gap';

-- buddhisme-tekster - Question 2
UPDATE public.questions SET
  prompt_en = 'What does "Tripitaka" mean?',
  prompt_tr = '"Tripitaka" ne anlama gelir?',
  meta_en = '{"choices":[
    {"id":"a","text":"Three Jewels"},
    {"id":"b","text":"Three Baskets","correct":true},
    {"id":"c","text":"Three Paths"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Üç Mücevher"},
    {"id":"b","text":"Üç Sepet","correct":true},
    {"id":"c","text":"Üç Yol"}
  ]}'::jsonb
WHERE prompt = 'Hva betyr «Tripitaka»?'
  AND type = 'mcq';

-- buddhisme-tekster - Question 3
UPDATE public.questions SET
  prompt_en = 'Mahayana Buddhism has additional sutras like the Lotus Sutra.',
  prompt_tr = 'Mahayana Budizmi, Lotus Sutra gibi ek sutralara sahiptir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Mahayana-buddhismen har tilleggssutras som Lotus-sutraen.'
  AND type = 'tf';

-- buddhisme-tekster - Question 4
UPDATE public.questions SET
  prompt_en = 'The ___ is the sacred symbol of Buddhism, representing the path to enlightenment.',
  prompt_tr = '___, Budizm''in kutsal sembolüdür ve aydınlanma yolunu temsil eder.',
  meta_en = '{"answer":"Dharma Wheel"}'::jsonb,
  meta_tr = '{"answer":"Dharma Tekerleği"}'::jsonb
WHERE prompt = '___ er buddhismens hellige symbol som representerer veien til opplysning.'
  AND type = 'gap';

-- buddhisme-tekster - Question 5
UPDATE public.questions SET
  prompt_en = 'The lotus flower is a symbol of purity and enlightenment in Buddhism.',
  prompt_tr = 'Lotus çiçeği Budizm''de saflık ve aydınlanmanın sembolüdür.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Lotusblomsten er et symbol på renhet og opplysning i buddhismen.'
  AND type = 'tf';

-- buddhisme-tekster - Question 6
UPDATE public.questions SET
  prompt_en = 'What is a mandala?',
  prompt_tr = 'Mandala nedir?',
  meta_en = '{"choices":[
    {"id":"a","text":"A type of meditation cushion"},
    {"id":"b","text":"A geometric design representing the universe","correct":true},
    {"id":"c","text":"A Buddhist monk"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Bir tür meditasyon yastığı"},
    {"id":"b","text":"Evreni temsil eden geometrik bir tasarım","correct":true},
    {"id":"c","text":"Bir Budist keşiş"}
  ]}'::jsonb
WHERE prompt = 'Hva er en mandala?'
  AND type = 'mcq';

-- buddhisme-tekster - Question 7
UPDATE public.questions SET
  prompt_en = 'Buddhist statues often show Buddha in meditation posture with ___ gesture.',
  prompt_tr = 'Budist heykeller genellikle Buda''yı ___ hareketiyle meditasyon pozisyonunda gösterir.',
  meta_en = '{"answer":"mudra"}'::jsonb,
  meta_tr = '{"answer":"mudra"}'::jsonb
WHERE prompt = 'Buddhistiske statuer viser ofte Buddha i meditasjonsstilling med ___-gestus.'
  AND type = 'gap';

-- buddhisme-moderne (Modern) - Question 1
UPDATE public.questions SET
  prompt_en = 'Buddhism has approximately 500 million followers worldwide.',
  prompt_tr = 'Budizm''in dünya çapında yaklaşık 500 milyon takipçisi vardır.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Buddhismen har ca. 500 millioner tilhengere verden over.'
  AND type = 'tf';

-- buddhisme-moderne - Question 2
UPDATE public.questions SET
  prompt_en = 'Where is Buddhism most practiced today?',
  prompt_tr = 'Budizm bugün en çok nerede uygulanıyor?',
  meta_en = '{"choices":[
    {"id":"a","text":"Europe"},
    {"id":"b","text":"East and Southeast Asia","correct":true},
    {"id":"c","text":"South America"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Avrupa"},
    {"id":"b","text":"Doğu ve Güneydoğu Asya","correct":true},
    {"id":"c","text":"Güney Amerika"}
  ]}'::jsonb
WHERE prompt = 'Hvor praktiseres buddhismen mest i dag?'
  AND type = 'mcq';

-- buddhisme-moderne - Question 3
UPDATE public.questions SET
  prompt_en = '___ Buddhism has become popular in the West, especially mindfulness practices.',
  prompt_tr = '___ Budizm Batı''da özellikle farkındalık uygulamalarıyla popüler hale geldi.',
  meta_en = '{"answer":"Zen"}'::jsonb,
  meta_tr = '{"answer":"Zen"}'::jsonb
WHERE prompt = '___-buddhismen har blitt populær i Vesten, spesielt oppmerksomhetspraksis.'
  AND type = 'gap';

-- buddhisme-moderne - Question 4
UPDATE public.questions SET
  prompt_en = 'The Dalai Lama is the spiritual leader of Tibetan Buddhism.',
  prompt_tr = 'Dalai Lama, Tibet Budizmi''nin ruhani lideridir.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Dalai Lama er den åndelige lederen for tibetansk buddhisme.'
  AND type = 'tf';

-- buddhisme-moderne - Question 5
UPDATE public.questions SET
  prompt_en = 'What has contributed to Buddhism''s spread in the West?',
  prompt_tr = 'Budizm''in Batı''da yayılmasına ne katkıda bulundu?',
  meta_en = '{"choices":[
    {"id":"a","text":"Military conquest"},
    {"id":"b","text":"Interest in meditation and mindfulness","correct":true},
    {"id":"c","text":"Economic trade only"}
  ]}'::jsonb,
  meta_tr = '{"choices":[
    {"id":"a","text":"Askeri fetih"},
    {"id":"b","text":"Meditasyon ve farkındalığa ilgi","correct":true},
    {"id":"c","text":"Sadece ekonomik ticaret"}
  ]}'::jsonb
WHERE prompt = 'Hva har bidratt til buddhismens spredning i Vesten?'
  AND type = 'mcq';

-- buddhisme-moderne - Question 6
UPDATE public.questions SET
  prompt_en = 'Engaged Buddhism emphasizes applying Buddhist principles to social and environmental ___.',
  prompt_tr = 'Engaged Budizm, Budist ilkelerin sosyal ve çevresel ___''lere uygulanmasını vurgular.',
  meta_en = '{"answer":"issues"}'::jsonb,
  meta_tr = '{"answer":"konulara"}'::jsonb
WHERE prompt = 'Engasjert buddhisme legger vekt på å anvende buddhistiske prinsipper på sosiale og miljømessige ___.'
  AND type = 'gap';

-- buddhisme-moderne - Question 7
UPDATE public.questions SET
  prompt_en = 'Modern technology has helped spread Buddhist teachings through apps and online courses.',
  prompt_tr = 'Modern teknoloji, uygulamalar ve çevrimiçi kurslar aracılığıyla Budist öğretilerin yayılmasına yardımcı oldu.',
  meta_en = '{"answer": true}'::jsonb,
  meta_tr = '{"answer": true}'::jsonb
WHERE prompt = 'Moderne teknologi har hjulpet til med å spre buddhistiske læresetninger gjennom apper og nettkurs.'
  AND type = 'tf';


