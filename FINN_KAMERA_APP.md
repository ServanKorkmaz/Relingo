# Finn hvilken app som bruker kameraet

## Metode 1: Task Manager (Detaljert)

1. Trykk `Ctrl + Shift + Esc` for å åpne Task Manager
2. Klikk på "Detaljer" eller "Details" fanen
3. Høyreklikk på kolonneoverskriftene
4. Velg "Velg kolonner" / "Select columns"
5. Huk av for "Kamera" / "Camera"
6. Se etter hvilke prosesser som har "Kamera: Aktiv"

## Metode 2: Windows Kamera-innstillinger

1. Trykk `Windows + I` (Innstillinger)
2. Gå til **Personvern og sikkerhet** → **Kamera**
3. Rull ned til "La apper få tilgang til kamera"
4. Se hvilke apper som har brukt kameraet "Nylig"

## Vanlige syndere:

- **Zoom** - Lukk helt (ikke bare minimer)
- **Microsoft Teams** - Lukk helt
- **Skype** - Lukk helt
- **Discord** - Hvis du har vært på videochat
- **OBS Studio** - Streaming software
- **Windows Kamera-app** - Kan kjøre i bakgrunnen
- **Andre nettleser-faner** - Andre nettsteder som bruker kamera
- **FaceTime** / **Messenger** / **WhatsApp Desktop**

## Rask fix:

### Lukk alt og restart:
```
1. Lukk ALLE programmer (ikke bare minimer)
2. Lukk ALLE nettleser-vinduer
3. Restart PC (hvis det ikke hjelper)
4. Åpne kun Chrome/Edge
5. Gå til localhost:5173
6. Prøv kamera igjen
```

## Hvis ingenting hjelper:

**Restart Kamera-driveren:**
1. Trykk `Windows + X`
2. Velg "Enhetsbehandling" / "Device Manager"
3. Finn "Kameraer" / "Cameras"
4. Høyreklikk på ditt kamera
5. Velg "Deaktiver enhet" → Vent 5 sekunder → "Aktiver enhet"
6. Prøv på nytt

## Test med Windows Kamera:

Søk etter "Kamera" i Start-menyen og åpne Windows Kamera-app.
Hvis den sier "Kamera er i bruk", er det definitivt et annet program.

