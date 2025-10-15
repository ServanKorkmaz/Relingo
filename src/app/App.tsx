import { BrowserRouter as Router, Routes, Route, Navigate, useLocation } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { ReactQueryDevtools } from '@tanstack/react-query-devtools';
import { DarkModeProvider } from '../contexts/DarkModeContext';
import TopBar from '../components/TopBar';
import Sidebar from '../components/Sidebar';
import MobileNav from '../components/MobileNav';
import LearnScreen from './learn';
import QuestsScreen from './quests';
import ProfileScreen from './profile';
import SettingsScreen from './settings';
import LandingPage from './landing';
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

  // Check if we're on a full-screen route (quiz or lesson)
  const isFullScreen = location.pathname.startsWith('/quiz/') || location.pathname.startsWith('/lesson/');

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900 transition-colors duration-300">
      {!isFullScreen && location.pathname !== '/onboarding' && location.pathname !== '/' && <TopBar />}
      {!isFullScreen && location.pathname !== '/onboarding' && location.pathname !== '/' && <Sidebar />}
      {!isFullScreen && location.pathname !== '/onboarding' && location.pathname !== '/' && <MobileNav />}
      <main className={`${isFullScreen || location.pathname === '/onboarding' || location.pathname === '/' ? '' : 'pt-16 lg:pl-72 pb-20 lg:pb-4'}`}>
        <Routes>
          <Route path="/" element={<LandingPage />} />
          <Route path="/app" element={<Navigate to="/app/learn" replace />} />
          <Route path="/app/learn" element={<LearnScreen />} />
          <Route path="/app/quests" element={<QuestsScreen />} />
          <Route path="/app/profile" element={<ProfileScreen />} />
          <Route path="/app/settings" element={<SettingsScreen />} />
          <Route path="/lesson/:lessonId" element={<LessonScreen />} />
          <Route path="/quiz/:quizId" element={<QuizScreen />} />
          <Route path="/onboarding" element={<OnboardingScreen />} />
          <Route path="*" element={<Navigate to="/app/learn" replace />} />
        </Routes>
      </main>
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
