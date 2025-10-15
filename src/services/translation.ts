// Cache for translations to avoid repeated API calls
const translationCache = new Map<string, Map<string, string>>();

// Store API key
let API_KEY: string | null = null;

/**
 * Initialize the translation client with API key
 */
export function initTranslation(apiKey?: string) {
  if (apiKey) {
    API_KEY = apiKey;
    console.log('✅ Google Translate API initialized');
  }
}

/**
 * Get cached translation or fetch from API
 */
async function getCachedTranslation(
  text: string,
  targetLang: string,
  sourceLang: string = 'no'
): Promise<string> {
  // Create cache key
  const cacheKey = `${sourceLang}-${targetLang}`;
  
  // Check if translation exists in cache
  if (!translationCache.has(cacheKey)) {
    translationCache.set(cacheKey, new Map());
  }
  
  const langCache = translationCache.get(cacheKey)!;
  
  if (langCache.has(text)) {
    return langCache.get(text)!;
  }
  
  // If no API key, return original text
  if (!API_KEY) {
    console.warn('Translation API key not found. Returning original text.');
    return text;
  }
  
  try {
    // Use Google Cloud Translation REST API
    const url = `https://translation.googleapis.com/language/translate/v2?key=${API_KEY}`;
    const response = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        q: text,
        source: sourceLang,
        target: targetLang,
        format: 'text',
      }),
    });

    if (!response.ok) {
      throw new Error(`Translation API error: ${response.status}`);
    }

    const data = await response.json();
    const translation = data.data.translations[0].translatedText;
    
    // Cache the result
    langCache.set(text, translation);
    
    return translation;
  } catch (error) {
    console.error('Translation error:', error);
    return text; // Return original text on error
  }
}

/**
 * Translate text to target language
 * @param text - Text to translate
 * @param targetLang - Target language code (en, no, tr)
 * @param sourceLang - Source language code (default: no)
 */
export async function translateText(
  text: string,
  targetLang: string,
  sourceLang: string = 'no'
): Promise<string> {
  // If target is same as source, return original
  if (targetLang === sourceLang) {
    return text;
  }
  
  // If text is empty, return empty
  if (!text || text.trim() === '') {
    return text;
  }
  
  return getCachedTranslation(text, targetLang, sourceLang);
}

/**
 * Translate multiple texts at once (batch translation)
 */
export async function translateBatch(
  texts: string[],
  targetLang: string,
  sourceLang: string = 'no'
): Promise<string[]> {
  if (targetLang === sourceLang) {
    return texts;
  }
  
  if (!API_KEY) {
    console.warn('Translation API key not found. Returning original texts.');
    return texts;
  }
  
  try {
    // Use Google Cloud Translation REST API for batch
    const url = `https://translation.googleapis.com/language/translate/v2?key=${API_KEY}`;
    const response = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        q: texts,
        source: sourceLang,
        target: targetLang,
        format: 'text',
      }),
    });

    if (!response.ok) {
      throw new Error(`Translation API error: ${response.status}`);
    }

    const data = await response.json();
    const translations = data.data.translations.map((t: any) => t.translatedText);
    
    // Cache all translations
    const cacheKey = `${sourceLang}-${targetLang}`;
    if (!translationCache.has(cacheKey)) {
      translationCache.set(cacheKey, new Map());
    }
    const langCache = translationCache.get(cacheKey)!;
    
    texts.forEach((text, index) => {
      langCache.set(text, translations[index]);
    });
    
    return translations;
  } catch (error) {
    console.error('Batch translation error:', error);
    return texts;
  }
}

/**
 * Clear translation cache
 */
export function clearTranslationCache() {
  translationCache.clear();
}

/**
 * Save cache to localStorage for persistence
 */
export function saveTranslationCache() {
  const cacheObj: Record<string, Record<string, string>> = {};
  
  translationCache.forEach((langCache, key) => {
    cacheObj[key] = Object.fromEntries(langCache);
  });
  
  localStorage.setItem('translation_cache', JSON.stringify(cacheObj));
}

/**
 * Load cache from localStorage
 */
export function loadTranslationCache() {
  try {
    const cached = localStorage.getItem('translation_cache');
    if (cached) {
      const cacheObj = JSON.parse(cached);
      
      Object.entries(cacheObj).forEach(([key, value]) => {
        translationCache.set(key, new Map(Object.entries(value as Record<string, string>)));
      });
    }
  } catch (error) {
    console.error('Failed to load translation cache:', error);
  }
}

