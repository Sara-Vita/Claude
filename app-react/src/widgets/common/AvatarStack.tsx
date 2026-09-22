import type { MembroGruppo } from "../../models/types";
import styles from "./AvatarStack.module.css";

/**
 * Fila di avatar "a iniziali" sovrapposti, come i membri di un gruppo nel
 * mockup schermata_gruppi.html — porting di
 * lib/widgets/common/avatar_stack.dart. Oltre `maxVisible` membri, gli
 * ultimi si comprimono in un unico cerchio "+N" invece di allungare la fila
 * all'infinito.
 *
 * I colori ciclano su --q-avatar-0/1/2 (la palette a 3 colori di
 * theme/colors.ts, scritta su :root da ThemeContext) invece di leggere un
 * array in JS: così il cerchio "+N" può sempre usare l'ultimo colore della
 * palette senza dover importare AppColors qui.
 */
export function AvatarStack({
  members,
  maxVisible = 2,
}: {
  members: MembroGruppo[];
  maxVisible?: number;
}) {
  const visible = members.slice(0, maxVisible);
  const remaining = members.length - visible.length;
  const paletteSize = 3;

  return (
    <div className={styles.stack}>
      {visible.map((member, i) => (
        <span
          key={i}
          className={styles.circle}
          style={{ background: `var(--q-avatar-${i % paletteSize})` }}
        >
          {member.iniziali}
        </span>
      ))}
      {remaining > 0 && (
        <span
          className={styles.circle}
          style={{ background: `var(--q-avatar-${paletteSize - 1})` }}
        >
          +{remaining}
        </span>
      )}
    </div>
  );
}
