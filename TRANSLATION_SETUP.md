# Automatisk Oversettelse Oppsett

## 📚 Oversikt

Relingo bruker nå **automatisk oversettelse** for å oversette alt innhold (leksjoner, quiz-spørsmål, etc.) fra norsk til valgt språk (engelsk eller tyrkisk).

## 🔑 Slik får du en Google Translate API-nøkkel:

### Steg 1: Opprett Google Cloud prosjekt

1. Gå til [Google Cloud Console](https://console.cloud.google.com/)
2. Klikk på "Select a project" → "NEW PROJECT"
3. Gi prosjektet et navn (f.eks. "Relingo Translation")
4. Klikk "CREATE"

### Steg 2: Aktiver Cloud Translation API

1. I Google Cloud Console, gå til **APIs & Services** → **Library**
2. Søk etter "**Cloud Translation API**"
3. Klikk på "Cloud Translation API"
4. Klikk "**ENABLE**"

### Steg 3: Opprett API-nøkkel

1. Gå til **APIs & Services** → **Credentials**
2. Klikk "**CREATE CREDENTIALS**" → "**API key**"
3. Kopier API-nøkkelen som vises
4. (Anbefalt) Klikk "**RESTRICT KEY**" for sikkerhet:
   - Under "API restrictions", velg "Restrict key"
   - Velg "Cloud Translation API" fra listen
   - Klikk "SAVE"

### Steg 4: Legg til API-nøkkel i prosjektet

1. Kopier `env.example` til `.env`:
   ```bash
   cp env.example .env
   ```

2. Åpne `.env` og legg til API-nøkkelen din:
   ```
   VITE_GOOGLE_TRANSLATE_API_KEY=din_api_nøkkel_her
   ```

3. Restart dev-serveren:
   ```bash
   npm run dev
   ```

## 💰 Kostnader

- Google Cloud Translation API har en **gratis tier** på:
  - **500,000 tegn per måned** gratis
  - $20 per million tegn deretter
  
- For en liten app som Relingo vil den gratis tiered være mer enn nok!

## ⚡ Hvordan det fungerer

1. **Første gang** et innhold vises, sendes det til Google Translate API
2. Oversettelsen **caches lokalt** (både i minnet og localStorage)
3. **Neste gang** samme tekst vises, brukes den cachede versjonen (ingen API-kall)
4. Dette gir rask ytelse og sparer API-kostnader

## 🛠️ Uten API-nøkkel

Hvis du ikke legger til en API-nøkkel:
- Appen fungerer fortsatt normalt
- Innhold vises på **norsk** (originalspråket)
- UI-elementer (knapper, navigasjon) oversettes fortsatt med i18n

## 📝 Notater

- Oversettelser er optimale for generelt innhold
- Religiøse termer kan noen ganger bli unøyaktige
- Du kan alltid manuelt redigere oversettelser i locale-filene (src/locales/)
- Cachen lagres i localStorage og varer til du tømmer den

## 🔧 Debugging

Sjekk konsollen i nettleseren:
- ✅ "Automatic translation enabled" = API-nøkkel er konfigurert
- ⚠️ "Google Translate API key not found" = Ingen API-nøkkel (fortsatt fungerer)

## 🚀 Kommende forbedringer

- [ ] Batch-oversettelse av alle spørsmål ved oppstart
- [ ] Admin-panel for å redigere oversettelser
- [ ] Fallback til alternative oversettelsestjenester
- [ ] Eksporter/importer oversettelsescache

