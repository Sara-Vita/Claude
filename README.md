# Quaderno — interfaccia Flutter (web · tablet · mobile)

Un'unica codebase Flutter che implementa la UI responsive discussa nella
conversazione di progetto: navbar a tema "quaderno" (sidebar espandibile su
desktop, compatta su tablet, bottom bar su mobile, con gli "anelletti"
decorativi presenti su tutti e tre), le sei sezioni principali (Home,
Calendario, Dispense, Studio, Gruppi, Profilo) e la sezione raggiunta "di
passaggio" (Ricerca, dall'icona sempre visibile in sidebar). Nessun
backend/JSON utente: tutte le schermate leggono da `lib/data/mock_data.dart`,
come richiesto in questa fase.

Questo branch (`react`) affianca a `lib/` una seconda implementazione della
stessa interfaccia in **React** — vedi la sezione
["Interfaccia React (branch `react`)"](#interfaccia-react-branch-react) più
sotto per dove si trova e come avviarla.

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

## Interfaccia React (branch `react`)

Questo branch aggiunge, accanto all'app Flutter, una seconda implementazione
della stessa interfaccia in **React + TypeScript + Vite**, cartella
`app-react/` (non `web/`: quel nome è riservato alla cartella piattaforma
che genera `flutter create .`, vedi `.gitignore`). È la stessa identica UI
"quaderno" **ripresa direttamente dai file `.html`** in cima a questo repo
(`anelletti_binding.html`, `dark_mode_graphite.html`,
`home_notebook_search_top.html`, `layout_tablet.html`,
`navbar_shrink_web.html`, `schermata_*.html`, `studio_tab_notebook.html`) —
non è un porting *pixel diverso*, è la stessa palette, lo stesso font
sostitutivo, la stessa navbar responsive e gli stessi sette schermi della
versione Flutter, per due tech stack che restano intercambiabili finché la
scelta definitiva dello stack di produzione (ancora aperta) non è fissata.

Nessun database/backend qui: come in `lib/data/mock_data.dart`, tutte le
schermate leggono da `app-react/src/data/mockData.ts`.

### Avviare il progetto

```bash
cd app-react
npm install
npm run dev        # server di sviluppo (http://localhost:5173)
npm run build       # build di produzione in app-react/dist/
```

Per vedere i tre layout senza tre dispositivi fisici: basta ridimensionare
la finestra del browser (breakpoint 700px/1100px, identici a quelli
Flutter — vedi `app-react/src/layout/breakpoints.ts`), oppure aprire i
DevTools del browser e simulare le dimensioni di un tablet/telefono
specifico. Ridimensionare la finestra **non perde lo stato**: sezione
aperta e preferenza tema restano quelli, cambia solo quale dei tre layout
(sidebar espandibile, sidebar compatta, bottom bar) li mostra.

### Struttura

```
app-react/
  index.html                     # entry HTML, carica il font Lora
  src/
    main.tsx                     # bootstrap React
    App.tsx                      # ThemeProvider + RouterProvider
    theme/
      colors.ts                  # token di colore chiaro/scuro (porting di app_colors.dart)
      ThemeContext.tsx           # Context che scrive i token come CSS custom properties
      global.css                 # reset, font, valori di default delle CSS variable
    layout/
      breakpoints.ts             # soglie mobile/tablet/desktop + hook useDeviceType
      useElementWidth.ts         # hook di larghezza-del-contenitore (per Calendario/Dispense)
    navigation/
      sections.ts                # le 7 "schermate" (6 principali + Ricerca secondaria)
      router.tsx                 # UNICO file con le route (React Router) — punto di ingresso
                                  # per aggiungere una nuova pagina
    models/
      types.ts                   # interfacce TypeScript (porting di lib/models/*.dart)
    data/
      mockData.ts                # dati statici per popolare la UI (porting di mock_data.dart)
    widgets/
      shell/                     # AppShell + sidebar/bottom-bar/anelletti/overlay ricerca
      common/                    # widget riusati da più schermate (SectionHeader, PillChip, AvatarStack)
    screens/                     # una schermata per ciascuna sezione, ciascuna con il proprio .module.css
```

Ogni cartella rispecchia 1:1 quella Flutter (`theme/`, `layout/`,
`navigation/`, `models/`, `data/`, `widgets/shell/`, `widgets/common/`,
`screens/`): chi conosce già la struttura di `lib/` trova subito il
corrispondente file qui, e viceversa. Ogni widget/schermata ha un file
`.tsx` (markup + logica) e — quando ha uno stile proprio non condiviso —
un file `.module.css` con lo stesso nome accanto: aggiungere un'ottava
sezione significa aggiungere uno screen in `screens/`, una voce in
`navigation/sections.ts` e una route in `navigation/router.tsx`, senza
toccare nient'altro.

### Decisioni prese in fase di traduzione da mockup/Flutter a React

- **CSS custom properties invece di ThemeExtension**: `ThemeContext`
  scrive i colori del tema attivo come variabili CSS su `:root`
  (`--q-page-background`, `--q-text-primary`, ...) a ogni cambio di tema;
  i componenti le leggono con `var(--q-...)` nei loro CSS Modules. È
  l'equivalente React/web del meccanismo Flutter (`context.colors.xyz`):
  un solo punto scrive i colori, tutti i widget colorati a valle si
  aggiornano senza dover ricevere `colors` via prop.
- **Sezione aperta = URL** (React Router), non stato locale della shell:
  in Flutter `AppShell` teneva `_section` in memoria; qui ogni schermata
  ha una route propria (`/`, `/calendario`, `/dispense`, ...), così è
  linkabile e il tasto indietro del browser funziona gratis. Lo stato che
  resta locale ad `AppShell` è solo quello "di shell" (sidebar espansa/
  compressa, overlay di ricerca visibile) — la sezione a cui torna il
  pulsante "indietro" da Ricerca si deduce dall'URL precedente.
- **Font**: stessa scelta di `pubspec.yaml` lato Flutter — Georgia (dei
  mockup `.html`) non è garantito fuori da macOS/Windows, sostituito con
  **Lora** (Google Fonts, licenza SIL Open Font License), caricato in
  `index.html` con fallback `Georgia, 'Times New Roman', serif`.
- **Icone**: `@tabler/icons-react`, la versione React della stessa
  libreria di icone (`ti ti-*`) già usata nei mockup `.html` — nessuna
  dipendenza da una webfont esterna da caricare a runtime.
- **Anelletti su tutto il lato della navbar**: la richiesta esplicita era
  che occupassero l'intero lato della sidebar, non solo un gruppetto in
  alto come nei primi screenshot. `RingsDivider` usa
  `justify-content: space-evenly` su un contenitore alto/largo il 100% del
  contenitore padre, invece di un passo fisso in pixel: gli anelli restano
  sempre distribuiti su tutta l'altezza (verticale, desktop/tablet) o
  larghezza (orizzontale, mobile) disponibile, qualunque essa sia — vedi
  `app-react/src/widgets/shell/RingsDivider.module.css`.
- **Tema "auto"**: segue `prefers-color-scheme` del sistema finché
  l'utente non sceglie esplicitamente Chiaro/Scuro da Profilo, esattamente
  come il `ThemeMode.system` di Flutter. Nessuna persistenza (stato in
  memoria): coerente con lo scope "niente JSON utente" di questa fase.

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
    app_section.dart           # le 7 "schermate" (6 principali + Ricerca secondaria)
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
- **Calendario** è stato promosso a voce fissa di navigazione (sesta voce in
  sidebar/bottom bar). **Ricerca** resta l'unica sezione "di passaggio",
  raggiunta dall'icona di ricerca sempre visibile: un pulsante "indietro"
  compare solo quando si è dentro Ricerca.
- **Anelletti su mobile**: non nascosti come da bozza iniziale di CLAUDE.md,
  ma mostrati come striscia orizzontale (`RingsDivider(direzione:
  Axis.horizontal)`) appena sopra la bottom bar, per richiesta esplicita —
  la metafora "bordo forato accanto alla navbar" vale in tutti e tre i
  layout, cambia solo l'orientamento.
- **Generazione immagini in tre stili** (richiesta esplicita per evitare
  l'estetica "riconoscibile" delle immagini AI generiche): implementata come
  scelta dello stile (bottom sheet) da "Genera immagine" in Studio — la
  generazione vera e propria richiede un backend/servizio AI, fuori scope
  qui.
