import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { translateText } from '../services/translation';

/**
 * Hook for translating dynamic content from database
 * @param text - Text to translate (in Norwegian)
 * @param enabled - Whether to enable translation (default: true)
 */
export function useTranslate(text: string | undefined, enabled: boolean = true) {
  const { i18n } = useTranslation();
  const [translatedText, setTranslatedText] = useState(text || '');
  const [isTranslating, setIsTranslating] = useState(false);

  useEffect(() => {
    if (!enabled || !text || text.trim() === '') {
      setTranslatedText(text || '');
      return;
    }

    const currentLang = i18n.language;

    // If Norwegian, no translation needed
    if (currentLang === 'no') {
      setTranslatedText(text);
      return;
    }

    // Translate to current language
    setIsTranslating(true);
    translateText(text, currentLang, 'no')
      .then((translated) => {
        setTranslatedText(translated);
      })
      .catch((error) => {
        console.error('Translation failed:', error);
        setTranslatedText(text);
      })
      .finally(() => {
        setIsTranslating(false);
      });
  }, [text, i18n.language, enabled]);

  return { translatedText, isTranslating };
}

/**
 * Hook for translating multiple texts
 */
export function useTranslateBatch(texts: string[], enabled: boolean = true) {
  const { i18n } = useTranslation();
  const [translatedTexts, setTranslatedTexts] = useState<string[]>(texts);
  const [isTranslating, setIsTranslating] = useState(false);

  useEffect(() => {
    if (!enabled || texts.length === 0) {
      setTranslatedTexts(texts);
      return;
    }

    const currentLang = i18n.language;

    if (currentLang === 'no') {
      setTranslatedTexts(texts);
      return;
    }

    setIsTranslating(true);
    
    // Import batch translation dynamically to avoid circular deps
    import('../services/translation').then(({ translateBatch }) => {
      return translateBatch(texts, currentLang, 'no');
    })
      .then((translated) => {
        setTranslatedTexts(translated);
      })
      .catch((error) => {
        console.error('Batch translation failed:', error);
        setTranslatedTexts(texts);
      })
      .finally(() => {
        setIsTranslating(false);
      });
  }, [JSON.stringify(texts), i18n.language, enabled]);

  return { translatedTexts, isTranslating };
}

