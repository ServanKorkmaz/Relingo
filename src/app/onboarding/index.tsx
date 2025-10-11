import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { useQuery } from '@tanstack/react-query';
import { useTranslation } from 'react-i18next';
import { getReligions } from '../../db/queries';
import { getReligionColor } from '../../utils/colors';

export default function OnboardingScreen() {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const [selectedReligion, setSelectedReligion] = useState<string | null>(null);

  const { data: religions = [], isLoading } = useQuery({
    queryKey: ['religions'],
    queryFn: getReligions,
  });

  const handleContinue = () => {
    // Save preference to localStorage
    if (selectedReligion) {
      localStorage.setItem('preferred_religion', selectedReligion);
    }
    navigate('/app/learn');
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand"></div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-brand/10 via-white to-brand/5 px-4 py-12">
      <motion.div
        className="max-w-2xl mx-auto"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
      >
        {/* Header */}
        <div className="text-center mb-12">
          <img
            src="/assets/logo.svg"
            alt="Relingo"
            className="w-28 h-28 mx-auto mb-4"
          />
          <h1 className="font-display text-4xl font-bold text-gray-900 mb-3">
            {t('onboarding.title')}
          </h1>
          <p className="text-lg text-gray-600">
            {t('onboarding.description')}
          </p>
        </div>

        {/* Religion Selection */}
        <div className="grid md:grid-cols-2 gap-4 mb-8">
          {religions.map((religion) => {
            const isSelected = selectedReligion === religion.slug;
            const color = getReligionColor(religion.slug);

            return (
              <motion.button
                key={religion.id}
                onClick={() => setSelectedReligion(religion.slug)}
                className={`p-6 rounded-2xl border-2 transition-all ${
                  isSelected
                    ? 'border-current shadow-lg'
                    : 'border-gray-200 hover:border-gray-300'
                }`}
                style={
                  isSelected
                    ? { borderColor: color, backgroundColor: `${color}10` }
                    : undefined
                }
                whileHover={{ scale: 1.02 }}
                whileTap={{ scale: 0.98 }}
              >
                <div className="flex items-center gap-4">
                  {religion.icon_url && (
                    <img
                      src={religion.icon_url}
                      alt={religion.name}
                      className="w-16 h-16"
                    />
                  )}
                  <div className="text-left">
                    <h3
                      className="font-bold text-xl mb-1"
                      style={isSelected ? { color } : undefined}
                    >
                      {t(`religions.${religion.slug}`)}
                    </h3>
                    <p className="text-sm text-gray-600">
                      {t('onboarding.learnFundamentals')}
                    </p>
                  </div>
                </div>
              </motion.button>
            );
          })}
        </div>

        {/* Skip Option */}
        <div className="text-center mb-6">
          <button
            onClick={() => setSelectedReligion(null)}
            className="text-gray-500 hover:text-gray-700 text-sm"
          >
            {t('onboarding.explore')}
          </button>
        </div>

        {/* Continue Button */}
        <button
          onClick={handleContinue}
          className="w-full py-4 bg-brand text-white font-semibold text-lg rounded-2xl hover:bg-brand-dark transition-colors"
        >
          {t('onboarding.continue')}
        </button>
      </motion.div>
    </div>
  );
}
