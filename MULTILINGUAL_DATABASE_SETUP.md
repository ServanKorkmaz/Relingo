# Flerspråklig Database-oppsett

## 📚 Oversikt

Relingo lagrer nå **alle oversettelser direkte i databasen** i stedet for å bruke Google Translate API. Dette gir:

- ✅ **Bedre kvalitet** - Manuelt oversatte, nøyaktige oversettelser
- ✅ **Raskere** - Ingen API-kall, øyeblikkelig lasting
- ✅ **Gratis** - Ingen API-kostnader
- ✅ **Offline-støtte** - Fungerer uten internett etter første lasting
- ✅ **Mer kontroll** - Du kan finjustere hver oversettelse

## 🗄️ Database-struktur

### Nye kolonner i `questions`-tabellen:

```sql
- prompt     (TEXT)  - Spørsmål på norsk (standard)
- prompt_en  (TEXT)  - Spørsmål på engelsk  
- prompt_tr  (TEXT)  - Spørsmål på tyrkisk

- meta       (JSONB) - Svaralternativer/data på norsk
- meta_en    (JSONB) - Svaralternativer/data på engelsk
- meta_tr    (JSONB) - Svaralternativer/data på tyrkisk
```

## 🚀 Installering

### Steg 1: Kjør Migrasjoner i Supabase

Åpne **Supabase Dashboard** → **SQL Editor** og kjør disse migrasjonene **i rekkefølge**:

#### 1. Legg til kolonner (Migration 0013)
```sql
-- Kopier og lim inn innholdet fra:
supabase/migrations/0013_add_multilingual_questions.sql
```

#### 2. Populer engelske oversettelser (Migration 0014)
```sql
-- Kopier og lim inn innholdet fra:
supabase/migrations/0014_populate_english_translations.sql
```

#### 3. Populer tyrkiske oversettelser (Migration 0015)
```sql
-- Kopier og lim inn innholdet fra:
supabase/migrations/0015_populate_turkish_translations.sql
```

### Steg 2: Restart Dev Server

```bash
npm run dev
```

## ✅ Testing

1. Åpne appen: `http://localhost:5173`
2. Gå til **Settings** → Bytt språk til **English**
3. Start en quiz
4. Spørsmålene skal nå vises på **engelsk** 🎉
5. Bytt til **Tyrkisk** og test igjen

## 📝 Legge til flere oversettelser

### For å oversette flere spørsmål:

```sql
-- Finne spørsmål som mangler oversettelser
SELECT id, prompt, prompt_en, prompt_tr 
FROM public.questions 
WHERE prompt_en IS NULL OR prompt_tr IS NULL;

-- Legge til engelsk oversettelse
UPDATE public.questions
SET 
  prompt_en = 'Your English translation here',
  meta_en = '{"answer":"English answer"}'::jsonb
WHERE prompt = 'Norsk spørsmål her';

-- Legge til tyrkisk oversettelse  
UPDATE public.questions
SET 
  prompt_tr = 'Türkçe çeviriniz buraya',
  meta_tr = '{"answer":"Türkçe cevap"}'::jsonb
WHERE prompt = 'Norsk spørsmål her';
```

### Eksempel for MCQ-spørsmål:

```sql
UPDATE public.questions
SET 
  prompt_en = 'What is the largest religion in the world?',
  meta_en = '{
    "choices":[
      {"id":"a","text":"Islam"},
      {"id":"b","text":"Christianity","correct":true},
      {"id":"c","text":"Hinduism"}
    ]
  }'::jsonb,
  prompt_tr = 'Dünyanın en büyük dini nedir?',
  meta_tr = '{
    "choices":[
      {"id":"a","text":"İslam"},
      {"id":"b","text":"Hıristiyanlık","correct":true},
      {"id":"c","text":"Hinduizm"}
    ]
  }'::jsonb
WHERE prompt = 'Hva er verdens største religion?';
```

## 🎯 Hvordan det fungerer

### Frontend (Automatisk)

Frontend velger automatisk riktig språkkolonne basert på `i18n.language`:

```typescript
// I src/db/queries.ts
export async function getQuestions(quizId: string, language: string = 'no') {
  // Henter spørsmål fra database
  const data = await supabase.from('questions').select('*')...
  
  // Mapper til riktig språk
  return data.map(question => ({
    ...question,
    prompt: language === 'en' ? question.prompt_en : 
            language === 'tr' ? question.prompt_tr : 
            question.prompt,  // default norsk
    meta: // samme logikk for meta
  }));
}
```

### Fallback-logikk

Hvis en oversettelse mangler:
1. ✅ Prøver først valgt språk (en/tr)
2. ✅ Faller tilbake til norsk hvis oversettelse ikke finnes
3. ✅ Sikrer at appen alltid fungerer

## 📊 Oversikt over oversettelser

### Status per språk:

| Leksjon | Norsk | Engelsk | Tyrkisk |
|---------|-------|---------|---------|
| Christianity Intro | ✅ | ✅ | ✅ |
| Islam Intro | ✅ | ✅ | ✅ |
| Hinduism Intro | ✅ | ✅ | ✅ |
| Judaism Intro | ✅ | ✅ | ✅ |
| Buddhism Intro | ✅ | ✅ | ✅ |
| Andre leksjoner | ✅ | ⚠️ Delvis | ⚠️ Delvis |

**⚠️ Delvis** = Intro-spørsmål er oversatt, men de andre leksjonene trenger oversettelser

## 🔧 Verktøy for masseoversettelse

### Eksporter alle spørsmål til CSV:

```sql
COPY (
  SELECT id, prompt, meta::text, prompt_en, prompt_tr 
  FROM public.questions
) TO '/tmp/questions.csv' WITH CSV HEADER;
```

### Importer etter oversettelse:

```sql
-- Bruk et script eller gjør det manuelt med UPDATE-statements
```

## 🎨 Best Practices

### 1. Konsistens
- Bruk samme terminologi på tvers av oversettelser
- Behold tekniske termer korrekte (f.eks. "Quran" ikke "Koran" på engelsk)

### 2. Kulturell sensitivitet
- Vær respektfull i alle oversettelser
- Sjekk med eksperter for religiøse termer

### 3. Testning
- Test hver oversettelse i appen
- Sjekk at alle svaralternativer vises riktig
- Bekreft at riktige svar markeres korrekt

## 🆘 Feilsøking

### Problem: Spørsmål vises fortsatt på norsk

**Løsning:**
1. Sjekk at migrasjoner er kjørt (se Steg 1)
2. Verifiser at oversettelsene finnes i databasen:
   ```sql
   SELECT prompt, prompt_en, prompt_tr FROM questions LIMIT 5;
   ```
3. Hard refresh i browser (Ctrl+Shift+R)

### Problem: Noen svaralternativer mangler

**Løsning:**
- Sjekk at `meta_en` og `meta_tr` har samme struktur som `meta`
- Alle `choices` må ha samme `id` på tvers av språk

## 📈 Fremtidige forbedringer

- [ ] Automatisk eksport/import-verktøy
- [ ] Admin-panel for å redigere oversettelser
- [ ] Crowdsourcing av oversettelser
- [ ] Støtte for flere språk (spansk, fransk, arabisk, etc.)

## ✅ Migrasjoner fullført!

Når alle 3 migrasjoner er kjørt:
- ✅ Database har kolonner for alle språk
- ✅ Intro-spørsmål er oversatt til engelsk og tyrkisk
- ✅ Frontend velger automatisk riktig språk
- ✅ Alt fungerer offline og raskt

---

**Git commit melding:**

```
Add multilingual database support for quiz content
```

**Neste steg:** Fortsett å oversette resten av spørsmålene! 🌍

