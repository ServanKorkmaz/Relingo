import { NavLink } from 'react-router-dom';
import { Book, Trophy, User } from 'lucide-react';
import { useTranslation } from 'react-i18next';

export default function BottomTabs() {
  const { t } = useTranslation();
  
  const tabs = [
    { to: '/app/learn', labelKey: 'nav.learn', icon: Book },
    { to: '/app/quests', labelKey: 'nav.quests', icon: Trophy },
    { to: '/app/profile', labelKey: 'nav.profile', icon: User },
  ];

  return (
    <nav className="fixed bottom-0 left-0 right-0 z-50 mx-auto max-w-screen-sm bg-white/80 backdrop-blur border-t">
      <ul className="grid grid-cols-3">
        {tabs.map(({ to, labelKey, icon: Icon }) => (
          <li key={to}>
            <NavLink
              to={to}
              className={({ isActive }) =>
                `flex flex-col items-center py-3 transition-colors ${
                  isActive 
                    ? 'text-brand font-semibold' 
                    : 'text-gray-600 hover:text-gray-900'
                }`
              }
            >
              <Icon className="h-6 w-6" />
              <span className="text-xs mt-1">{t(labelKey)}</span>
            </NavLink>
          </li>
        ))}
      </ul>
    </nav>
  );
}
