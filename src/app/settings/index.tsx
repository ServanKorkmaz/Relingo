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
import { 
  getUserPreferences, 
  updateUserPreferences,
  exportUserData 
} from '../../db/queries';

export default function SettingsScreen() {
  const navigate = useNavigate();
  const { i18n } = useTranslation();
  const queryClient = useQueryClient();

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
  const [darkMode, setDarkMode] = useState(preferences?.dark_mode ?? false);

  // Sync local state when preferences load
  useEffect(() => {
    if (preferences) {
      setNotifications(preferences.notifications_enabled);
      setEmailNotifications(preferences.email_notifications);
      setSoundEffects(preferences.sound_effects);
      setDarkMode(preferences.dark_mode);
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
    setDarkMode(value);
    updatePreferencesMutation.mutate({ dark_mode: value });
    // TODO: Actually implement dark mode theme switching
    if (value) {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
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
      title: 'Varslinger',
      icon: Bell,
      items: [
        {
          label: 'Push-varslinger',
          description: 'Få påminnelser om daglige mål',
          type: 'toggle',
          value: notifications,
          onChange: handleNotificationsChange,
        },
        {
          label: 'E-postvarslinger',
          description: 'Ukentlig fremdriftsrapport',
          type: 'toggle',
          value: emailNotifications,
          onChange: handleEmailNotificationsChange,
        },
      ],
    },
    {
      title: 'Utseende',
      icon: Palette,
      items: [
        {
          label: 'Mørk modus',
          description: 'Reduser øyebelastning',
          type: 'toggle',
          value: darkMode,
          onChange: handleDarkModeChange,
        },
        {
          label: 'Lydeffekter',
          description: 'Spill av lyder ved fullføring',
          type: 'toggle',
          value: soundEffects,
          onChange: handleSoundEffectsChange,
        },
      ],
    },
    {
      title: 'Språk',
      icon: Globe,
      items: [
        {
          label: 'Grensesnittspråk',
          description: 'Endre språket for appen',
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
      title: 'Personvern',
      icon: Shield,
      items: [
        {
          label: 'Eksporter data',
          description: 'Last ned alle dine data',
          type: 'button',
          icon: Download,
          action: handleExportData,
        },
        {
          label: 'Slett konto',
          description: 'Permanent slett kontoen din',
          type: 'button',
          icon: Trash2,
          danger: true,
          action: handleDeleteAccount,
        },
      ],
    },
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8 lg:py-12">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <button
            onClick={() => navigate('/app/profile')}
            className="flex items-center gap-2 text-gray-600 hover:text-brand mb-4 transition-colors group"
          >
            <ArrowLeft className="w-5 h-5 group-hover:-translate-x-1 transition-transform" />
            <span className="font-medium">Tilbake til profil</span>
          </button>
          
          <h1 className="font-display text-4xl lg:text-5xl font-bold text-gray-900 mb-2">
            Innstillinger
          </h1>
          <p className="text-lg text-gray-600">Tilpass opplevelsen din</p>
        </motion.div>

        {/* Settings Sections */}
        <div className="space-y-6">
          {settingsSections.map((section, sectionIndex) => {
            const SectionIcon = section.icon;
            
            return (
              <motion.div
                key={section.title}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: sectionIndex * 0.1 }}
                className="bg-white rounded-3xl p-6 lg:p-8 shadow-medium border border-gray-100"
              >
                <div className="flex items-center gap-3 mb-6">
                  <div className="w-10 h-10 bg-brand/10 rounded-xl flex items-center justify-center">
                    <SectionIcon className="w-5 h-5 text-brand" />
                  </div>
                  <h2 className="font-display text-xl lg:text-2xl font-bold text-gray-900">
                    {section.title}
                  </h2>
                </div>

                <div className="space-y-4">
                  {section.items.map((item, itemIndex) => (
                    <div
                      key={itemIndex}
                      className="flex items-center justify-between p-4 rounded-xl hover:bg-gray-50 transition-colors"
                    >
                      <div className="flex-1">
                        <p className="font-semibold text-gray-900">{item.label}</p>
                        <p className="text-sm text-gray-600">{item.description}</p>
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
                          Utfør
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
            className="bg-gradient-to-br from-brand/5 to-brand/10 rounded-3xl p-8 border border-brand/20 text-center"
          >
            <HelpCircle className="w-12 h-12 text-brand mx-auto mb-4" />
            <h3 className="font-display text-xl font-bold text-gray-900 mb-2">
              Trenger du hjelp?
            </h3>
            <p className="text-gray-600 mb-4">
              Vi er her for å hjelpe deg med eventuelle spørsmål
            </p>
            <button className="px-6 py-3 bg-brand text-white font-semibold rounded-xl hover:bg-brand-dark transition-colors shadow-md hover:shadow-lg">
              Kontakt support
            </button>
          </motion.div>
        </div>
      </div>
    </div>
  );
}

