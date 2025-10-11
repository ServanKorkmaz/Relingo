import { BrowserRouter as Router, Routes, Route, Navigate, useLocation } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { ReactQueryDevtools } from '@tanstack/react-query-devtools';
import { useState, useEffect } from 'react';
import { supabase } from '../lib/supabase';
import { DarkModeProvider } from '../contexts/DarkModeContext';
import TopBar from '../components/TopBar';
import Sidebar from '../components/Sidebar';
import BottomTabs from '../components/BottomTabs';
import LearnScreen from './learn';
import QuestsScreen from './quests';
import ProfileScreen from './profile';
import SettingsScreen from './settings';
import LandingPage from './landing';
import AuthScreen from './auth';
import ResetPasswordScreen from './auth/reset-password';
import OnboardingScreen from './onboarding';
import LessonScreen from './lesson';
import QuizScreen from './quiz';

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 5 * 60 * 1000, // 5 minutes
    },
  },
});

function AppContent() {
  const location = useLocation();
  const [user, setUser] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  // Check if we're on a full-screen route (quiz or lesson)
  const isFullScreen = location.pathname.startsWith('/quiz/') || location.pathname.startsWith('/lesson/');

  useEffect(() => {
    // Get initial session
    supabase.auth.getSession().then(({ data: { session } }) => {
      setUser(session?.user ?? null);
      setLoading(false);
    });

    // Listen for auth changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      (_event, session) => {
        setUser(session?.user ?? null);
        setLoading(false);
      }
    );

    return () => subscription.unsubscribe();
  }, []);

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-brand"></div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900 transition-colors duration-300">
      {user ? (
        <>
          {!isFullScreen && <TopBar />}
          {!isFullScreen && <Sidebar />}
          <main className={`${isFullScreen ? '' : 'pt-16 pb-20 lg:pl-72'}`}>
            <Routes>
              <Route path="/app" element={<Navigate to="/app/learn" replace />} />
              <Route path="/app/learn" element={<LearnScreen />} />
              <Route path="/app/quests" element={<QuestsScreen />} />
              <Route path="/app/profile" element={<ProfileScreen />} />
              <Route path="/app/settings" element={<SettingsScreen />} />
              <Route path="/lesson/:lessonId" element={<LessonScreen />} />
              <Route path="/quiz/:quizId" element={<QuizScreen />} />
              <Route path="*" element={<Navigate to="/app/learn" replace />} />
            </Routes>
          </main>
          {!isFullScreen && <BottomTabs />}
        </>
      ) : (
        <Routes>
          <Route path="/" element={<LandingPage />} />
          <Route path="/auth" element={<AuthScreen />} />
          <Route path="/auth/update-password" element={<ResetPasswordScreen />} />
          <Route path="/onboarding" element={<OnboardingScreen />} />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      )}
    </div>
  );
}

export default function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <DarkModeProvider>
        <Router>
          <AppContent />
        </Router>
        <ReactQueryDevtools initialIsOpen={false} />
      </DarkModeProvider>
    </QueryClientProvider>
  );
}
