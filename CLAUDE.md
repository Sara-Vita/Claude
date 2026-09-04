# Contesto di progetto — App note universitarie

Questo file riassume le decisioni di design/architettura prese finora. Leggilo prima di scrivere codice.

## Stack scelto
- **Flutter** (Dart) per web + tablet + mobile, single codebase.
- Canvas infinito nativo (no Excalidraw diretto, non compatibile con Flutter). Base di partenza valutata: `infinite_canvas` (rodydavis) su `InteractiveViewer` + `CustomMultiChildLayout`; considerare comunque un motore di viewport/culling scritto ad hoc per non dipendere da un package a bassa adozione sul cuore dell'app.

## Identità visiva — stile "Quaderno"
- Font: serif (Georgia / Times New Roman in prototipo, valutare un serif con licenza commerciale in produzione).
- Palette chiara: navbar `#C1502E` (terracotta), sfondo `#F2EBDD` (beige), testo `#4A3323` (marrone), accento `#7C8A4E` (oliva).
- Dark mode scelta: **grafite neutro** — sfondo `#1C1B19`, card `#262523`, testo `#E8E4DC`, accento terracotta `#E2643A`, accento oliva `#8FA05C`, bordo `#35332F`.
- Dettaglio distintivo: colonna di "anelletti" (cerchi vuoti, decorativi, `aria-hidden`) tra sidebar e contenuto, a simulare la rilegatura di un quaderno. Solo desktop/tablet largo, nascosto sotto un certo breakpoint mobile.
- Sistema temi futuro (piano Pro): catalogo `Temi` separato (non annidato nell'utente), ogni tema ha varianti chiaro/scuro, flag `richiedePro`, e campi opzionali `disponibileDal`/`disponibileAl` per temi stagionali a tempo.

## Architettura informativa (navbar)
Voci: **Home, Dispense, Studio, Gruppi, Profilo**.
- Barra di ricerca pubblica ("cerca dispense") **fissa in cima alla sidebar**, sopra i tab — non è una voce di navigazione ma un elemento di primo livello sempre visibile.
- **Libretto** trattato come sezione distinta dal Profilo anagrafico (dati ad alta frequenza di consultazione vs dati statici); tab/dropdown separato dal Profilo.
- **Studio**: hub di creazione (note, registrazioni, immagini generate, upload) e generazione flashcard (manuale gratis / AI con badge Pro). I mazzi generati confluiscono qui, non dentro le singole materie.
- **Dispense** (ex "Materiale"): elenco materie con bottone "Aggiungi materia" sempre visibile, card per materia con bordo colorato = `materia.colore`, conteggio contenuti (note/registrazioni/flashcard).
- **Gruppi**: storage/calendario condiviso, non necessariamente chat (funzionalità messaggistica ancora da decidere).

## Navbar responsive (shrinkable)
Stato salvato **per breakpoint**, non globale:
```
preferenze.navbar = { desktop: "espansa"|"compatta", tablet: "compatta", mobile: "bottom_bar" }
```
- Desktop: toggle esplicito (freccia in cima alla sidebar), stato compatto = solo icone, ricerca diventa icona con overlay.
- Tablet: compatta di default, nessun toggle (spazio limitato).
- Mobile: sidebar sostituita da bottom tab bar; ricerca torna come icona in-content.

## Modello dati (bozza, da normalizzare in tabelle relazionali)

**Utente**: id, email, nome, cognome, piano (`free`/`pro`), libretto (1:1, o tabella a parte se serve interrogarlo separatamente), preferenze (navbar per breakpoint, aspetto: temaId + modalita chiaro/scuro/auto).

**Materia**: id, utenteId (FK), nome, colore, docente, dataEsame. NON contiene array annidati di contenuti.

**Contenuto** (tabella polimorfica unica, scelta deliberata per semplificare il feed cronologico per materia): id, materiaId (FK), tipo (`nota`|`registrazione`|`foto`|`flashcardDeck`), origine (`studio`|`dispense_import_locale`), titolo, corpo, urlFile, createdAt. Se in futuro un tipo (es. registrazioni con trascrizione) accumula troppi campi specifici, valutare di spostarlo in una tabella satellite collegata da `contenutoId` (ibrido).

**FlashcardDeck / Flashcard**: deck ha materiaId + generatoCon (`ai`|`manuale`); le singole carte sono in tabella separata con deckId (FK) — mai annidate nel deck.

**Calendario**: id, nome, proprietarioId, colore. Un utente può avere calendari multipli (Personale, Lezioni, Gruppo X) — non un unico calendario con soli colori per evento, perché il calendario è l'unità di condivisione/visibilità.

**Evento**: id, calendarioId (FK), materiaId (FK nullable), titolo, inizio, fine, colore (nullable = eredita dal calendario), ricorrenza (nullable, formato RRULE quando implementata).

**CalendarioCondivisioni**: id, calendarioId (FK), targetTipo (`gruppo`|`utente`), targetId, permesso (`sola_lettura`|`modifica`).

**Tema** (catalogo globale, non per-utente): id, nome, richiedePro, disponibileDal, disponibileAl, chiaro{navbar,sfondo,testo,accento}, scuro{...}.

## Filosofia del piano Pro (vincolante per ogni feature futura)
Nessuna funzione che riduce la capacità di studiare deve essere a pagamento. Il Pro monetizza solo:
- comodità (generazione AI oltre una quota gratuita mensile — mai generazione AI=0 sul free),
- estetica (temi, non funzione),
- scala (storage cloud, limite calendari/gruppi più alto, non uno zero per il free),
- convenienza di tempo (priorità di elaborazione, cronologia versioni, statistiche avanzate).
L'esportazione dei propri dati in formato semplice deve restare **sempre gratuita**, senza eccezioni.

## Decisioni ancora aperte
- Messaggistica dentro Gruppi: sì/no, non ancora deciso.
- Font di produzione (licenza serif alternativa a Georgia).
- Nome definitivo del brand/app.
