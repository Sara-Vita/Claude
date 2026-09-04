# Quaderno — interfaccia Flutter (web · tablet · mobile)

Un'unica codebase Flutter che implementa la UI responsive discussa nella
conversazione di progetto: navbar a tema "quaderno" (sidebar espandibile su
desktop, compatta su tablet, bottom bar su mobile), le cinque sezioni
principali (Home, Dispense, Studio, Gruppi, Profilo) e le due sezioni
raggiunte "di passaggio" (Ricerca, Calendario). Nessun backend/JSON utente:
tutte le schermate leggono da `lib/data/mock_data.dart`, come richiesto in
questa fase.

## Avviare il progetto

Questo repository contiene solo il codice Dart (`lib/`) e `pubspec.yaml`,
non le cartelle piattaforma (`android/`, `ios/`, `web/`, ...): quelle sono
boilerplate generato da Flutter stesso e non ha senso versionarle a mano.
Per ottenerle:

```bash
flutter create --project-name quaderno_app --org com.example .
flutter pub get
flutter run -d chrome      # web
flutter run                # dispositivo/emulatore collegato (mobile/tablet)
```

`flutter create .` su una cartella già esistente aggiunge solo le cartelle
piattaforma mancanti, senza toccare `lib/` o `pubspec.yaml`.

Per vedere i tre layout senza tre dispositivi fisici: su web/desktop basta
ridimensionare la finestra del browser (i breakpoint sono 700px e 1100px,
vedi `lib/layout/breakpoints.dart`); il DevTools di Flutter permette anche
di simulare le dimensioni di un tablet/telefono specifico.

## Struttura

```
lib/
  main.dart                    # MaterialApp, ThemeMode in memoria
  theme/
    app_colors.dart            # token di colore custom (ThemeExtension)
    app_theme.dart             # ThemeData chiaro/scuro costruiti dai token
  layout/
    breakpoints.dart           # soglie mobile/tablet/desktop
  navigation/
    app_section.dart           # le 7 "schermate" (5 principali + 2 secondarie)
  models/                      # classi dati semplici (niente JSON, vedi CLAUDE.md)
  data/
    mock_data.dart             # dati statici per popolare la UI
  widgets/
    shell/                     # AppShell + sidebar/bottom-bar/anelletti/overlay ricerca
    common/                    # widget riusati da più schermate
  screens/                     # una schermata per ciascuna sezione
```

## Decisioni prese in fase di traduzione da mockup a codice

- **Font**: i mockup usano Georgia, non disponibile di default su
  Android/Linux/Web. Sostituito con **Lora** (Google Fonts, licenza SIL Open
  Font License libera), stessa famiglia "serif da lettura schermo". Da
  rivalutare quando si sceglierà il font di produzione definitivo (punto
  ancora aperto in CLAUDE.md).
- **Colori dark mode per anelletti e avatar gruppo**: non specificati nei
  mockup (che mostrano solo Home in dark). Estrapolati dalla stessa formula
  "grafite neutro desaturato" usata per il resto della palette scura — sono
  documentati come tali nei commenti di `app_colors.dart` e vanno rifiniti a
  occhio quando ci sarà uno schermo reale.
- **Ricerca e Calendario** non hanno una voce fissa in sidebar (restano 5
  voci come da CLAUDE.md): si raggiungono dall'icona di ricerca sempre
  visibile e da un bottone "Calendario completo" in Home. Un pulsante
  "indietro" compare quando si è dentro una di queste sezioni secondarie.
- **Generazione immagini in tre stili** (richiesta esplicita per evitare
  l'estetica "riconoscibile" delle immagini AI generiche): implementata come
  scelta dello stile (bottom sheet) da "Genera immagine" in Studio — la
  generazione vera e propria richiede un backend/servizio AI, fuori scope
  qui.
