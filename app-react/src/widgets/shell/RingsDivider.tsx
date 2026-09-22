import styles from "./RingsDivider.module.css";

/**
 * Gli "anelletti" decorativi che corrono accanto alla navbar, a simulare la
 * rilegatura di un quaderno — porting di lib/widgets/shell/rings_divider.dart.
 * Colonna verticale tra sidebar e contenuto su desktop/tablet, striscia
 * orizzontale sopra la bottom bar su mobile. Presente su tutti e tre i
 * breakpoint (requisito esplicito di progetto), e qui — a differenza dei
 * primi screenshot — allungata su TUTTO il lato della navbar tramite
 * `justify-content: space-evenly` (vedi il commento nel .module.css) invece
 * di fermarsi a un gruppetto di cerchi vicino alla cima.
 *
 * `aria-hidden` (equivalente dell'ExcludeSemantics di Flutter) perché è
 * puro elemento decorativo: nessun ruolo, nessun'interazione, non deve
 * essere annunciato da uno screen reader né raggiungibile da tastiera.
 */
export function RingsDivider({
  direction = "vertical",
  count = 8,
}: {
  direction?: "vertical" | "horizontal";
  count?: number;
}) {
  return (
    <div
      aria-hidden="true"
      className={direction === "vertical" ? styles.vertical : styles.horizontal}
    >
      {Array.from({ length: count }, (_, i) => (
        <span key={i} className={styles.ring} />
      ))}
    </div>
  );
}
