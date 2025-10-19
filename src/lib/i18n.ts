import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';

// Import Turkish translations
import tr from '../locales/tr.json';

const resources = {
  tr: { translation: tr },
};

i18n
  .use(initReactI18next)
  .init({
    resources,
    lng: 'tr', // Turkish as the only language
    fallbackLng: 'tr',
    supportedLngs: ['tr'],
    interpolation: {
      escapeValue: false,
    },
  });

export default i18n;


