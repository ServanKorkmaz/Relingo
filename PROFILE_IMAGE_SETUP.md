# Profile Image Upload Setup

## Oversikt

Brukere kan nå laste opp egne profilbilder ved å bruke enten kamera eller velge fra filer/kamerarull. Bildene lagres i Supabase Storage og URLs lagres i brukerens metadata.

## Funksjoner

- Ta bilde med kamera (mobil/desktop med kamera)
- Velg bilde fra filer/kamerarull
- Automatisk opplasting til Supabase Storage
- Bildevalidering (maks 5MB, kun bildefiler)
- Automatisk sletting av gamle profilbilder
- Håndtering av lasting-tilstand
- Hover-effekt for å endre bilde

## Implementerte Filer

### 1. ProfileImageUpload Komponent
**Fil:** `src/components/ProfileImageUpload.tsx`

Modal-komponent som håndterer:
- Filvelger for lokale bilder
- Kamera-input for å ta bilde
- Bildevalidering
- Opplasting til Supabase Storage
- Oppdatering av brukerens metadata
- Sletting av gamle bilder

### 2. Oppdatert Profilside
**Fil:** `src/app/profile/index.tsx`

Endringer:
- Lagt til hover-effekt med kamera-ikon på profilbildet
- Viser brukerens avatar_url fra metadata
- Fallback til standard avatar hvis ingen avatar er satt
- Integrert ProfileImageUpload modal

### 3. Database Migration
**Fil:** `supabase/migrations/0009_setup_avatars_storage.sql`

Setter opp:
- `avatars` storage bucket (offentlig tilgjengelig)
- Row Level Security policies for sikker filbehandling
- Brukere kan kun laste opp/endre/slette sine egne bilder
- Alle kan se bilder (public read)

## Setup Instruksjoner

### 1. Kjør Database Migration

Gå til Supabase Dashboard → SQL Editor og kjør:

```sql
-- Innholdet fra supabase/migrations/0009_setup_avatars_storage.sql
```

### 2. Verifiser Storage Bucket

1. Gå til Supabase Dashboard → Storage
2. Sjekk at `avatars` bucket eksisterer
3. Bekreft at bucketen er satt til "Public"

### 3. Test Funksjonaliteten

#### Desktop:
1. Gå til profilsiden
2. Hover over profilbildet
3. Klikk på kamera-ikonet
4. Klikk "Velg bilde" for å velge fra datamaskinen

**Merk:** På desktop vises kun filvelger siden `capture` attributtet ikke fungerer konsistent på desktop-browsere.

#### Mobil:
1. Gå til profilsiden
2. Trykk på profilbildet
3. Velg enten:
   - **"Ta bilde"** - åpner kamera direkte
   - **"Velg fra bibliotek"** - åpner bildebibliotek/galleri

**Merk:** På mobil detekteres enhetstype automatisk og kamera-knappen vises bare på mobile enheter.

## Tekniske Detaljer

### Filnavnkonvensjon
```
avatars/{userId}-{timestamp}.{extension}
```

Eksempel: `avatars/a1b2c3d4-1704067200000.jpg`

### Validering
- **Maks filstørrelse:** 5MB
- **Tillatte formater:** image/* (JPG, PNG, GIF, etc.)
- **Automatisk komprimering:** Nei (implementer ved behov)

### Sikkerhet

**Row Level Security Policies:**

1. **Upload** - Kun autentiserte brukere kan laste opp sine egne bilder
2. **Read** - Alle kan se bildene (public)
3. **Update** - Kun eieren kan oppdatere sitt bilde
4. **Delete** - Kun eieren kan slette sitt bilde

Filnavn inneholder bruker-ID, så policies validerer at `userId` i filnavnet matcher `auth.uid()`.

### Storage Path Struktur
```
avatars/
  ├── {userId}-{timestamp}.jpg
  ├── {userId}-{timestamp}.png
  └── ...
```

### Metadata Lagring

Avatar URL lagres i brukerens metadata:

```typescript
user.user_metadata.avatar_url = "https://[supabase-url]/storage/v1/object/public/avatars/[filename]"
```

## Fremtidige Forbedringer

Potensielle forbedringer:

1. **Bildekomprimering**
   - Komprimer bilder før opplasting
   - Bruk browser-native canvas API eller bibliotek som `browser-image-compression`

2. **Bilderedigering**
   - Cropping til kvadratisk format
   - Filtre og justeringer
   - Zoom og pan

3. **Multiple Avatars**
   - La brukere lagre flere avatarer
   - Velg mellom flere predefinerte avatarer

4. **Placeholder Avatars**
   - Generer initialer-baserte avatarer
   - Bruk gradient-bakgrunner

5. **Caching**
   - Implementer aggressive cache headers
   - Bruk CDN for raskere lasting

## Feilsøking

### Problem: "Bucket does not exist"
**Løsning:** Kjør migration 0009 i Supabase SQL Editor

### Problem: "Permission denied"
**Løsning:** Sjekk at RLS policies er korrekt satt opp

### Problem: Bildene laster ikke
**Løsning:** 
1. Sjekk at bucket er satt til "Public"
2. Verifiser at avatar_url er lagret korrekt i user metadata
3. Sjekk browser console for CORS-feil

### Problem: "File too large"
**Løsning:** Komprimer bildet til under 5MB før opplasting

## Kodeeksempel

### Bruke ProfileImageUpload i andre komponenter:

```typescript
import ProfileImageUpload from '../components/ProfileImageUpload';

function MyComponent() {
  const [showUpload, setShowUpload] = useState(false);
  const { data: user } = useQuery({
    queryKey: ['auth-user'],
    queryFn: async () => {
      const { data } = await supabase.auth.getUser();
      return data.user;
    },
  });

  return (
    <>
      <button onClick={() => setShowUpload(true)}>
        Endre profilbilde
      </button>
      
      {showUpload && user && (
        <ProfileImageUpload
          currentImageUrl={user.user_metadata?.avatar_url}
          userId={user.id}
          onClose={() => setShowUpload(false)}
        />
      )}
    </>
  );
}
```

## API Referanse

### ProfileImageUpload Props

| Prop | Type | Beskrivelse |
|------|------|-------------|
| `currentImageUrl` | `string` (optional) | URL til nåværende profilbilde |
| `userId` | `string` (required) | Brukerens unike ID |
| `onClose` | `() => void` (required) | Callback når modal lukkes |

## Relaterte Filer

- `src/components/ProfileImageUpload.tsx` - Upload komponent
- `src/app/profile/index.tsx` - Profilside
- `supabase/migrations/0009_setup_avatars_storage.sql` - Database setup
- `src/lib/supabase.ts` - Supabase konfigurasjon

---

**Sist oppdatert:** 2025
**Versjon:** 1.0

