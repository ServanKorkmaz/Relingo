import { useNavigate, useLocation } from 'react-router-dom';
import { motion } from 'framer-motion';
import { 
  Home, BookOpen, Target, Trophy, User, 
  Settings, LogOut
} from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { supabase } from '../lib/supabase';

export default function Sidebar() {
  const navigate = useNavigate();
  const location = useLocation();
  const { t } = useTranslation();

  const handleSignOut = async () => {
    await supabase.auth.signOut();
    navigate('/');
  };

  const navItems = [
    { 
      icon: Home, 
      labelKey: 'sidebar.home',
      path: '/app/learn',
      color: 'text-brand',
      bgColor: 'bg-brand/10',
      hoverBg: 'hover:bg-brand/20'
    },
    { 
      icon: BookOpen, 
      labelKey: 'sidebar.learn',
      path: '/app/learn',
      color: 'text-blue-600',
      bgColor: 'bg-blue-50',
      hoverBg: 'hover:bg-blue-100'
    },
    { 
      icon: Target, 
      labelKey: 'sidebar.quests',
      path: '/app/quests',
      color: 'text-purple-600',
      bgColor: 'bg-purple-50',
      hoverBg: 'hover:bg-purple-100'
    },
    { 
      icon: Trophy, 
      labelKey: 'sidebar.achievements',
      path: '/app/profile',
      color: 'text-amber-600',
      bgColor: 'bg-amber-50',
      hoverBg: 'hover:bg-amber-100'
    },
    { 
      icon: User, 
      labelKey: 'sidebar.profile',
      path: '/app/profile',
      color: 'text-brand',
      bgColor: 'bg-brand/10',
      hoverBg: 'hover:bg-brand/20'
    },
  ];

  const isActive = (path: string) => location.pathname === path;

  return (
    <aside className="hidden lg:flex lg:flex-col lg:fixed lg:inset-y-0 lg:w-72 bg-white dark:bg-gray-800 border-r border-gray-200 dark:border-gray-700 shadow-soft pt-20 transition-colors duration-300">
      <div className="flex-1 flex flex-col px-4 py-6 overflow-y-auto">
        {/* Navigation Links */}
        <nav className="space-y-2">
          {navItems.map((item) => {
            const Icon = item.icon;
            const active = isActive(item.path);
            
            return (
              <motion.button
                key={item.path}
                onClick={() => navigate(item.path)}
                whileHover={{ x: 4 }}
                whileTap={{ scale: 0.98 }}
                className={`
                  w-full flex items-center gap-4 px-4 py-3.5 rounded-xl
                  transition-all duration-200 group
                  ${active 
                    ? `${item.bgColor} dark:bg-opacity-20 ${item.color} shadow-sm` 
                    : `text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50`
                  }
                `}
              >
                <div className={`
                  w-10 h-10 rounded-lg flex items-center justify-center
                  ${active ? item.bgColor + ' dark:bg-opacity-30' : 'bg-gray-100 dark:bg-gray-700 group-hover:bg-gray-200 dark:group-hover:bg-gray-600'}
                  transition-colors
                `}>
                  <Icon className={`w-5 h-5 ${active ? item.color : 'text-gray-600 dark:text-gray-400'}`} />
                </div>
                <span className={`font-semibold text-base ${active ? item.color : 'text-gray-700 dark:text-gray-300'}`}>
                  {t(item.labelKey)}
                </span>
              </motion.button>
            );
          })}
        </nav>

        {/* Divider */}
        <div className="my-6 border-t border-gray-200 dark:border-gray-700"></div>

        {/* Quick Stats */}
        <div className="bg-gradient-to-br from-brand/5 to-brand/10 dark:from-brand/10 dark:to-brand/20 rounded-2xl p-4 mb-4 border border-brand/10 dark:border-brand/20">
          <h3 className="font-semibold text-sm text-gray-700 dark:text-gray-300 mb-3">{t('sidebar.quickStats')}</h3>
          <div className="space-y-2">
            <div className="flex items-center justify-between">
              <span className="text-sm text-gray-600 dark:text-gray-400">{t('sidebar.dailyGoal')}</span>
              <span className="text-sm font-bold text-brand dark:text-brand-light">3/5</span>
            </div>
            <div className="h-2 bg-gray-200 dark:bg-gray-700 rounded-full overflow-hidden">
              <div className="h-full bg-gradient-to-r from-brand to-brand-dark rounded-full" style={{ width: '60%' }} />
            </div>
          </div>
        </div>

        {/* Motivational Quote */}
        <div className="bg-gradient-to-br from-amber-50 to-orange-50 dark:from-amber-900/20 dark:to-orange-900/20 rounded-2xl p-4 border border-amber-100 dark:border-amber-800">
          <p className="text-sm text-gray-700 dark:text-gray-300 italic">
            "{t('sidebar.quote')}"
          </p>
        </div>

        {/* Bottom Actions */}
        <div className="mt-auto pt-4 space-y-2">
          <button
            onClick={() => navigate('/app/settings')}
            className="w-full flex items-center gap-3 px-4 py-3 rounded-xl text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50 transition-colors group"
          >
            <Settings className="w-5 h-5 text-gray-500 dark:text-gray-400 group-hover:rotate-90 transition-transform duration-300" />
            <span className="font-medium">{t('sidebar.settings')}</span>
          </button>
          
          <button
            onClick={handleSignOut}
            className="w-full flex items-center gap-3 px-4 py-3 rounded-xl text-red-600 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/30 transition-colors"
          >
            <LogOut className="w-5 h-5" />
            <span className="font-medium">{t('sidebar.logout')}</span>
          </button>
        </div>
      </div>
    </aside>
  );
}

