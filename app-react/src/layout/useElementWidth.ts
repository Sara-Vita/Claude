import { useEffect, useRef, useState } from "react";

/**
 * Larghezza dell'elemento (non della finestra) a cui è agganciato il ref
 * restituito — l'equivalente React di avvolgere un pezzo di UI in un
 * `LayoutBuilder` Flutter quando serve reagire alla larghezza del proprio
 * contenitore invece che a quella della finestra intera (es. su desktop con
 * sidebar espansa il contenuto è più stretto della finestra: vedi
 * CalendarioScreen e DispenseScreen, che ne hanno bisogno esattamente come
 * le loro controparti Dart).
 *
 * Usa ResizeObserver invece di un listener su `window.resize`: cambia anche
 * quando la sidebar si espande/comprime senza che la finestra stessa cambi
 * dimensione.
 */
export function useElementWidth<T extends HTMLElement>() {
  const ref = useRef<T>(null);
  const [width, setWidth] = useState(0);

  useEffect(() => {
    const el = ref.current;
    if (!el) return;
    const observer = new ResizeObserver(([entry]) => {
      setWidth(entry.contentRect.width);
    });
    observer.observe(el);
    return () => observer.disconnect();
  }, []);

  return { ref, width };
}
