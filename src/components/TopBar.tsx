import { Heart, Zap } from 'lucide-react';
import { useUserStats } from '../hooks/useUserStats';
import LanguageSwitcher from './LanguageSwitcher';

export default function TopBar() {
  const { stats } = useUserStats();

  return (
    <header className="fixed top-0 left-0 right-0 z-50 mx-auto max-w-screen-sm bg-white/80 backdrop-blur border-b">
      <div className="flex items-center justify-between px-4 py-3">
        {/* Logo */}
        <div className="flex items-center gap-2">
          <img src="/assets/logo.svg" alt="Relingo" className="w-12 h-12" />
          <span className="font-display font-bold text-xl text-brand">Relingo</span>
        </div>

        {/* Stats and Language */}
        <div className="flex items-center gap-2">
          {/* XP */}
          <div className="flex items-center gap-1.5 bg-amber-50 px-3 py-1.5 rounded-full border border-amber-200">
            <Zap className="w-4 h-4 text-amber-600 fill-amber-600" />
            <span className="font-semibold text-sm text-amber-900">
              {stats?.xp || 0}
            </span>
          </div>

          {/* Hearts */}
          <div className="flex items-center gap-1.5 bg-red-50 px-3 py-1.5 rounded-full border border-red-200">
            <Heart className="w-4 h-4 text-red-600 fill-red-600" />
            <span className="font-semibold text-sm text-red-900">
              {stats?.hearts || 0}
            </span>
          </div>

          {/* Language Switcher */}
          <LanguageSwitcher />
        </div>
      </div>
    </header>
  );
}
