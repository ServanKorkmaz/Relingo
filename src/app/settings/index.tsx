import { motion } from 'framer-motion';
import { useNavigate } from 'react-router-dom';
import { 
  ArrowLeft, Bell, Globe, Palette, Shield, 
  Trash2, Download, HelpCircle 
} from 'lucide-react';
import { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { supabase } from '../../lib/supabase';
import { useDarkMode } from '../../contexts/DarkModeContext';
import { 
  getUserPreferences, 
  updateUserPreferences,
  exportUserData 
} from '../../db/queries';

export default function SettingsScreen() {
  const navigate = useNavigate();
  const { t, i18n } = useTranslation();
  const queryClient = useQueryClient();
  const { isDarkMode, setDarkMode: setDarkModeContext } = useDarkMode();

  // Get current user
  const { data: user } = useQuery({
    queryKey: ['auth-user'],
    queryFn: async () => {
      const { data } = await supabase.auth.getUser();
      return data.user;
    },
  });

  // Get user preferences
  const { data: preferences } = useQuery({
    queryKey: ['user-preferences', user?.id],
    queryFn: () => user?.id ? getUserPreferences(user.id) : Promise.resolve(null),
    enabled: !!user?.id,
  });

  // Local state synced with DB
  const [notifications, setNotifications] = useState(preferences?.notifications_enabled ?? true);
  const [emailNotifications, setEmailNotifications] = useState(preferences?.email_notifications ?? true);
  const [soundEffects, setSoundEffects] = useState(preferences?.sound_effects ?? true);

  // Sync local state when preferences load
  useEffect(() => {
    if (preferences) {
      setNotifications(preferences.notifications_enabled);
      setEmailNotifications(preferences.email_notifications);
      setSoundEffects(preferences.sound_effects);
    }
  }, [preferences]);

  // Mutation to update preferences
  const updatePreferencesMutation = useMutation({
    mutationFn: (prefs: any) => user?.id ? updateUserPreferences(user.id, prefs) : Promise.reject(),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['user-preferences'] });
    },
  });

  // Handlers
  const handleNotificationsChange = (value: boolean) => {
    setNotifications(value);
    updatePreferencesMutation.mutate({ notifications_enabled: value });
  };

  const handleEmailNotificationsChange = (value: boolean) => {
    setEmailNotifications(value);
    updatePreferencesMutation.mutate({ email_notifications: value });
  };

  const handleSoundEffectsChange = (value: boolean) => {
    setSoundEffects(value);
    updatePreferencesMutation.mutate({ sound_effects: value });
  };

  const handleDarkModeChange = (value: boolean) => {
    setDarkModeContext(value);
    updatePreferencesMutation.mutate({ dark_mode: value });
  };

  const handleLanguageChange = (lang: string) => {
    i18n.changeLanguage(lang);
    if (user?.id) {
      updatePreferencesMutation.mutate({ language: lang });
    }
  };

  const handleExportData = async () => {
    if (!user?.id) return;
    
    try {
      const data = await exportUserData(user.id);
      const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `relingo-data-${new Date().toISOString().split('T')[0]}.json`;
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
      URL.revokeObjectURL(url);
      alert('Dataene dine er lastet ned!');
    } catch (error) {
      console.error('Error exporting data:', error);
      alert('Kunne ikke eksportere data. Prøv igjen senere.');
    }
  };

  const handleDeleteAccount = async () => {
    if (!user?.id) return;
    
    const confirmed = window.confirm(
      'Er du sikker på at du vil slette kontoen din permanent?\n\n' +
      'Dette vil slette:\n' +
      '• All fremgang og statistikk\n' +
      '• Alle innstillinger\n' +
      '• Din bruker-konto\n\n' +
      'Dette kan IKKE angres!'
    );
    
    if (!confirmed) return;
    
    const doubleConfirm = window.prompt(
      'Skriv "SLETT" for å bekrefte sletting av kontoen din:'
    );
    
    if (doubleConfirm !== 'SLETT') {
      alert('Kontosletting avbrutt.');
      return;
    }
    
    try {
      await supabase.auth.signOut();
      alert('Kontoen din er slettet. Du blir nå logget ut.');
      navigate('/auth');
    } catch (error) {
      console.error('Error deleting account:', error);
      alert('Kunne ikke slette konto. Kontakt support for hjelp.');
    }
  };

  const settingsSections = [
    {
      titleKey: 'settings.notifications.title',
      icon: Bell,
      items: [
        {
          labelKey: 'settings.notifications.push',
          descKey: 'settings.notifications.pushDesc',
          type: 'toggle',
          value: notifications,
          onChange: handleNotificationsChange,
        },
        {
          labelKey: 'settings.notifications.email',
          descKey: 'settings.notifications.emailDesc',
          type: 'toggle',
          value: emailNotifications,
          onChange: handleEmailNotificationsChange,
        },
      ],
    },
    {
      titleKey: 'settings.appearance.title',
      icon: Palette,
      items: [
        {
          labelKey: 'settings.appearance.darkMode',
          descKey: 'settings.appearance.darkModeDesc',
          type: 'toggle',
          value: isDarkMode,
          onChange: handleDarkModeChange,
        },
        {
          labelKey: 'settings.appearance.soundEffects',
          descKey: 'settings.appearance.soundEffectsDesc',
          type: 'toggle',
          value: soundEffects,
          onChange: handleSoundEffectsChange,
        },
      ],
    },
    {
      titleKey: 'settings.language.title',
      icon: Globe,
      items: [
        {
          labelKey: 'settings.language.interface',
          descKey: 'settings.language.interfaceDesc',
          type: 'select',
          value: i18n.language,
          options: [
            { value: 'no', label: 'Norsk' },
            { value: 'en', label: 'English' },
            { value: 'tr', label: 'Türkçe' },
          ],
          onChange: handleLanguageChange,
        },
      ],
    },
    {
      titleKey: 'settings.privacy.title',
      icon: Shield,
      items: [
        {
          labelKey: 'settings.privacy.exportData',
          descKey: 'settings.privacy.exportDataDesc',
          type: 'button',
          icon: Download,
          action: handleExportData,
        },
        {
          labelKey: 'settings.privacy.deleteAccount',
          descKey: 'settings.privacy.deleteAccountDesc',
          type: 'button',
          icon: Trash2,
          danger: true,
          action: handleDeleteAccount,
        },
      ],
    },
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100 dark:from-gray-900 dark:to-gray-800 transition-colors duration-300">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8 lg:py-12">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <button
            onClick={() => navigate('/app/profile')}
            className="flex items-center gap-2 text-gray-600 dark:text-gray-400 hover:text-brand dark:hover:text-brand-light mb-4 transition-colors group"
          >
            <ArrowLeft className="w-5 h-5 group-hover:-translate-x-1 transition-transform" />
            <span className="font-medium">{t('settings.backToProfile')}</span>
          </button>
          
          <h1 className="font-display text-4xl lg:text-5xl font-bold text-gray-900 dark:text-white mb-2">
            {t('settings.title')}
          </h1>
          <p className="text-lg text-gray-600 dark:text-gray-400">{t('settings.subtitle')}</p>
        </motion.div>

        {/* Settings Sections */}
        <div className="space-y-6">
          {settingsSections.map((section, sectionIndex) => {
            const SectionIcon = section.icon;
            
            return (
              <motion.div
                key={section.titleKey}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: sectionIndex * 0.1 }}
                className="bg-white dark:bg-gray-800 rounded-3xl p-6 lg:p-8 shadow-medium border border-gray-100 dark:border-gray-700 transition-colors duration-300"
              >
                <div className="flex items-center gap-3 mb-6">
                  <div className="w-10 h-10 bg-brand/10 dark:bg-brand/20 rounded-xl flex items-center justify-center">
                    <SectionIcon className="w-5 h-5 text-brand dark:text-brand-light" />
                  </div>
                  <h2 className="font-display text-xl lg:text-2xl font-bold text-gray-900 dark:text-white">
                    {t(section.titleKey)}
                  </h2>
                </div>

                <div className="space-y-4">
                  {section.items.map((item, itemIndex) => (
                    <div
                      key={itemIndex}
                      className="flex items-center justify-between p-4 rounded-xl hover:bg-gray-50 dark:hover:bg-gray-700/50 transition-colors"
                    >
                      <div className="flex-1">
                        <p className="font-semibold text-gray-900 dark:text-white">
                          {t('labelKey' in item ? item.labelKey : '')}
                        </p>
                        <p className="text-sm text-gray-600 dark:text-gray-400">
                          {t('descKey' in item ? item.descKey : '')}
                        </p>
                      </div>

                      {item.type === 'toggle' && 'onChange' in item && 'value' in item && typeof item.value === 'boolean' && (
                        <button
                          onClick={() => typeof item.onChange === 'function' && item.onChange(!item.value)}
                          className={`
                            relative w-14 h-8 rounded-full transition-colors duration-200
                            ${item.value ? 'bg-brand' : 'bg-gray-300'}
                          `}
                        >
                          <div
                            className={`
                              absolute top-1 w-6 h-6 bg-white rounded-full shadow-md transition-transform duration-200
                              ${item.value ? 'translate-x-7' : 'translate-x-1'}
                            `}
                          />
                        </button>
                      )}

                      {item.type === 'select' && 'onChange' in item && 'value' in item && 'options' in item && (
                        <select
                          value={item.value as string}
                          onChange={(e) => item.onChange(e.target.value)}
                          className="px-4 py-2 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-brand focus:border-transparent font-medium"
                        >
                          {item.options?.map((opt: any) => (
                            <option key={opt.value} value={opt.value}>
                              {opt.label}
                            </option>
                          ))}
                        </select>
                      )}

                      {item.type === 'button' && 'action' in item && (
                        <button
                          onClick={item.action}
                          className={`
                            flex items-center gap-2 px-4 py-2 rounded-xl font-semibold transition-colors
                            ${'danger' in item && item.danger
                              ? 'bg-red-100 text-red-600 hover:bg-red-200' 
                              : 'bg-brand/10 text-brand hover:bg-brand/20'
                            }
                          `}
                        >
                          {'icon' in item && item.icon && <item.icon className="w-4 h-4" />}
                          {t('settings.privacy.execute')}
                        </button>
                      )}
                    </div>
                  ))}
                </div>
              </motion.div>
            );
          })}

          {/* Help Section */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.4 }}
            className="bg-gradient-to-br from-brand/5 to-brand/10 dark:from-brand/10 dark:to-brand/20 rounded-3xl p-8 border border-brand/20 dark:border-brand/30 text-center transition-colors duration-300"
          >
            <HelpCircle className="w-12 h-12 text-brand dark:text-brand-light mx-auto mb-4" />
            <h3 className="font-display text-xl font-bold text-gray-900 dark:text-white mb-2">
              {t('settings.help.title')}
            </h3>
            <p className="text-gray-600 dark:text-gray-400 mb-4">
              {t('settings.help.description')}
            </p>
            <button className="px-6 py-3 bg-brand text-white font-semibold rounded-xl hover:bg-brand-dark transition-colors shadow-md hover:shadow-lg">
              {t('settings.help.contactSupport')}
            </button>
          </motion.div>
        </div>
      </div>
    </div>
  );
}

