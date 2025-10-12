import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import './lib/i18n'
import App from './app/App.tsx'
import { initTranslation, loadTranslationCache } from './services/translation'

// Initialize Google Translate API (if API key is provided)
const apiKey = import.meta.env.VITE_GOOGLE_TRANSLATE_API_KEY;
if (apiKey) {
  initTranslation(apiKey);
  console.log('✅ Automatic translation enabled');
} else {
  console.warn('⚠️ Google Translate API key not found. Running without automatic translation.');
}

// Load cached translations from localStorage
loadTranslationCache();

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <App />
  </StrictMode>,
)
