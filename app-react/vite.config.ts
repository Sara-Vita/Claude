import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// Config Vite minimale: un solo plugin (JSX + Fast Refresh), nessun alias
// di percorso "furbo" — gli import restano relativi (../../theme/...) come
// in lib/ del progetto Flutter, per poter aprire un file e capire subito
// da dove viene ogni import senza consultare una mappa di alias.
export default defineConfig({
  plugins: [react()],
});
