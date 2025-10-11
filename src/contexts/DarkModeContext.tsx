import { createContext, useContext, useState, useEffect, type ReactNode } from 'react';
import { useQuery } from '@tanstack/react-query';
import { supabase } from '../lib/supabase';
import { getUserPreferences } from '../db/queries';

interface DarkModeContextType {
  isDarkMode: boolean;
  toggleDarkMode: () => void;
  setDarkMode: (value: boolean) => void;
}

const DarkModeContext = createContext<DarkModeContextType | undefined>(undefined);

export function DarkModeProvider({ children }: { children: ReactNode }) {
  const [isDarkMode, setIsDarkMode] = useState(false);
  const [userId, setUserId] = useState<string | null>(null);

  // Get current user
  useEffect(() => {
    supabase.auth.getUser().then(({ data }) => {
      setUserId(data.user?.id || null);
    });

    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      setUserId(session?.user?.id || null);
    });

    return () => subscription.unsubscribe();
  }, []);

  // Load dark mode preference from database
  const { data: preferences } = useQuery({
    queryKey: ['user-preferences', userId],
    queryFn: () => userId ? getUserPreferences(userId) : Promise.resolve(null),
    enabled: !!userId,
  });

  // Apply dark mode when preference loads
  useEffect(() => {
    if (preferences?.dark_mode !== undefined) {
      setIsDarkMode(preferences.dark_mode);
      applyDarkMode(preferences.dark_mode);
    }
  }, [preferences]);

  const applyDarkMode = (enabled: boolean) => {
    if (enabled) {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  };

  const toggleDarkMode = () => {
    const newValue = !isDarkMode;
    setIsDarkMode(newValue);
    applyDarkMode(newValue);
  };

  const setDarkModeValue = (value: boolean) => {
    setIsDarkMode(value);
    applyDarkMode(value);
  };

  return (
    <DarkModeContext.Provider value={{ isDarkMode, toggleDarkMode, setDarkMode: setDarkModeValue }}>
      {children}
    </DarkModeContext.Provider>
  );
}

export function useDarkMode() {
  const context = useContext(DarkModeContext);
  if (context === undefined) {
    throw new Error('useDarkMode must be used within a DarkModeProvider');
  }
  return context;
}

