import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { fileURLToPath, URL } from 'node:url';
import { mysqlApiPlugin } from './server/vite-plugin-mysql-api';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react(), mysqlApiPlugin()],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
  optimizeDeps: {
    exclude: ['lucide-react', '@electric-sql/pglite'],
  },
});
