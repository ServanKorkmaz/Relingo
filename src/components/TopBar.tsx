import { Heart, Zap, Flame } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { useUserStats } from '../hooks/useUserStats';
import LanguageSwitcher from './LanguageSwitcher';

export default function TopBar() {
  const { t } = useTranslation();
  const { stats } = useUserStats();

  return (
    <header className="sticky top-0 left-0 right-0 z-50 bg-white/95 dark:bg-gray-800/95 backdrop-blur-lg border-b border-gray-200 dark:border-gray-700 shadow-soft transition-colors duration-300">
      <div className="max-w-7xl mx-auto">
        <div className="flex items-center justify-between px-4 sm:px-6 lg:px-8 py-4">
          {/* Logo */}
          <div className="flex items-center gap-3 group cursor-pointer">
            <div className="relative">
              <img src="/assets/logo.svg" alt="Relingo" className="w-12 h-12 lg:w-14 lg:h-14 group-hover:scale-110 transition-transform" />
              <div className="absolute inset-0 bg-brand/20 rounded-full blur-xl opacity-0 group-hover:opacity-100 transition-opacity"></div>
            </div>
            <div className="hidden sm:block">
              <span className="font-display font-bold text-2xl text-brand dark:text-brand-light">Relingo</span>
              <p className="text-xs text-gray-500 dark:text-gray-400 -mt-1">{t('app.tagline')}</p>
            </div>
          </div>

          {/* Stats and Language */}
          <div className="flex items-center gap-2 lg:gap-3">
            {/* Streak - Hidden on mobile, shown on tablet+ */}
            <div className="hidden md:flex items-center gap-2 bg-gradient-to-br from-orange-50 to-orange-100 dark:from-orange-900/30 dark:to-orange-800/30 px-4 py-2.5 rounded-xl border border-orange-200 dark:border-orange-700 shadow-soft hover:shadow-md transition-all">
              <Flame className="w-5 h-5 text-orange-600 dark:text-orange-400" />
              <div className="flex flex-col">
                <span className="font-bold text-lg text-orange-900 dark:text-orange-200 leading-none">{stats?.streak || 0}</span>
                <span className="text-[10px] text-orange-700 dark:text-orange-400">{t('stats.days')}</span>
              </div>
            </div>

            {/* XP */}
            <div className="flex items-center gap-2 bg-gradient-to-br from-amber-50 to-amber-100 dark:from-amber-900/30 dark:to-amber-800/30 px-3 lg:px-4 py-2 lg:py-2.5 rounded-xl border border-amber-200 dark:border-amber-700 shadow-soft hover:shadow-md transition-all group">
              <Zap className="w-4 h-4 lg:w-5 lg:h-5 text-amber-600 dark:text-amber-400 fill-amber-600 dark:fill-amber-400 group-hover:scale-110 transition-transform" />
              <div className="flex flex-col">
                <span className="font-bold text-base lg:text-lg text-amber-900 dark:text-amber-200 leading-none">{stats?.xp || 0}</span>
                <span className="text-[10px] text-amber-700 dark:text-amber-400 hidden lg:block">XP</span>
              </div>
            </div>

            {/* Hearts */}
            <div className="flex items-center gap-2 bg-gradient-to-br from-red-50 to-red-100 dark:from-red-900/30 dark:to-red-800/30 px-3 lg:px-4 py-2 lg:py-2.5 rounded-xl border border-red-200 dark:border-red-700 shadow-soft hover:shadow-md transition-all group">
              <Heart className="w-4 h-4 lg:w-5 lg:h-5 text-red-600 dark:text-red-400 fill-red-600 dark:fill-red-400 group-hover:scale-110 transition-transform" />
              <div className="flex flex-col">
                <span className="font-bold text-base lg:text-lg text-red-900 dark:text-red-200 leading-none">{stats?.hearts || 0}</span>
                <span className="text-[10px] text-red-700 dark:text-red-400 hidden lg:block">liv</span>
              </div>
            </div>

            {/* Language Switcher - Always visible */}
            <LanguageSwitcher />
          </div>
        </div>
      </div>
    </header>
  );
}
