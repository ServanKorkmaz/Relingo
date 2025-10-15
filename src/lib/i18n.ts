import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import LanguageDetector from 'i18next-browser-languagedetector';

// Import translations
import en from '../locales/en.json';
import no from '../locales/no.json';
import tr from '../locales/tr.json';

const resources = {
  en: { translation: en },
  no: { translation: no },
  tr: { translation: tr },
};

i18n
  .use(LanguageDetector)
  .use(initReactI18next)
  .init({
    resources,
    lng: 'tr', // Set Norwegian as default language (where content exists)
    fallbackLng: 'tr',
    supportedLngs: ['en', 'no', 'tr'],
    detection: {
      order: ['localStorage', 'navigator'],
      caches: ['localStorage'],
    },
    interpolation: {
      escapeValue: false,
    },
  });

export default i18n;


