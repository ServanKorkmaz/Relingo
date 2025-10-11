import { NavLink } from 'react-router-dom';
import { Home, Target, User, Settings } from 'lucide-react';
import { useTranslation } from 'react-i18next';

export default function MobileNav() {
  const { t } = useTranslation();
  
  const tabs = [
    { to: '/app/learn', labelKey: 'nav.learn', icon: Home },
    { to: '/app/quests', labelKey: 'nav.quests', icon: Target },
    { to: '/app/profile', labelKey: 'nav.profile', icon: User },
    { to: '/app/settings', labelKey: 'nav.settings', icon: Settings },
  ];

  return (
    <nav className="lg:hidden fixed bottom-0 left-0 right-0 z-50 bg-white/95 dark:bg-gray-800/95 backdrop-blur-lg border-t border-gray-200 dark:border-gray-700 shadow-strong transition-colors duration-300">
      <ul className="grid grid-cols-4 max-w-2xl mx-auto">
        {tabs.map(({ to, labelKey, icon: Icon }) => (
          <li key={to}>
            <NavLink
              to={to}
              className={({ isActive }) =>
                `flex flex-col items-center py-3 px-2 transition-colors ${
                  isActive 
                    ? 'text-brand dark:text-brand-light font-semibold' 
                    : 'text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-gray-200'
                }`
              }
            >
              {({ isActive }) => (
                <>
                  <div className={`relative ${isActive ? 'scale-110' : ''} transition-transform`}>
                    <Icon className="h-6 w-6" strokeWidth={isActive ? 2.5 : 2} />
                    {isActive && (
                      <div className="absolute -top-1 left-1/2 -translate-x-1/2 w-1 h-1 bg-brand dark:bg-brand-light rounded-full" />
                    )}
                  </div>
                  <span className="text-xs mt-1.5">{t(labelKey)}</span>
                </>
              )}
            </NavLink>
          </li>
        ))}
      </ul>
    </nav>
  );
}

