import { useEffect, useState } from "react";

/**
 * Porting di lib/layout/breakpoints.dart. Stessa scelta: guardiamo solo la
 * larghezza della finestra, non il tipo di dispositivo — ridimensionare la
 * finestra del browser deve bastare per vedere i tre layout, come richiesto.
 */
export type DeviceType = "mobile" | "tablet" | "desktop";

export const Breakpoints = {
  /** Sotto questa larghezza: layout mobile (bottom bar). */
  tablet: 700,
  /** Sotto questa (e sopra `tablet`): layout tablet (sidebar sempre
   * compatta). Da qui in su: layout desktop (sidebar espandibile). */
  desktop: 1100,
} as const;

export function deviceTypeOf(width: number): DeviceType {
  if (width >= Breakpoints.desktop) return "desktop";
  if (width >= Breakpoints.tablet) return "tablet";
  return "mobile";
}

/**
 * Hook che espone il DeviceType corrente e si aggiorna a ogni resize della
 * finestra — l'equivalente React di avvolgere la shell in un `LayoutBuilder`
 * in Flutter. Usa `window.innerWidth` (la larghezza del viewport), non quella
 * di un singolo elemento: è la shell dell'app che deve reagire al resize
 * della finestra, non un layout interno a un componente.
 */
export function useDeviceType(): DeviceType {
  const [deviceType, setDeviceType] = useState<DeviceType>(() =>
    deviceTypeOf(window.innerWidth),
  );

  useEffect(() => {
    const onResize = () => setDeviceType(deviceTypeOf(window.innerWidth));
    window.addEventListener("resize", onResize);
    return () => window.removeEventListener("resize", onResize);
  }, []);

  return deviceType;
}
