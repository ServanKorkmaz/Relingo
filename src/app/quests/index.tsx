import { motion } from 'framer-motion';
import { CheckCircle2, Circle, Trophy, Flame, Target } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { useUserStats } from '../../hooks/useUserStats';
import { useQuery } from '@tanstack/react-query';
import { getUserProgress } from '../../db/queries';
import { supabase } from '../../lib/supabase';
import { getUTCDateString } from '../../utils/date';

interface Quest {
  id: string;
  titleKey: string;
  descriptionKey: string;
  icon: React.ComponentType<{ className?: string }>;
  target: number;
  current: number;
  xpReward: number;
}

export default function QuestsScreen() {
  const { t } = useTranslation();
  const { stats } = useUserStats();

  const { data: user } = useQuery({
    queryKey: ['auth-user'],
    queryFn: async () => {
      const { data } = await supabase.auth.getUser();
      return data.user;
    },
  });

  const { data: userProgress = [] } = useQuery({
    queryKey: ['user-progress', user?.id],
    queryFn: () => (user?.id ? getUserProgress(user.id) : Promise.resolve([])),
    enabled: !!user?.id,
  });

  // Calculate quest progress
  const today = getUTCDateString();
  const completedToday = userProgress.filter(
    (p) => p.last_completed_at && p.last_completed_at.startsWith(today)
  ).length;

  const totalCompleted = userProgress.filter((p) => p.stars > 0).length;

  const quests: Quest[] = [
    {
      id: 'daily-lesson',
      titleKey: 'quests.dailyLearner.title',
      descriptionKey: 'quests.dailyLearner.description',
      icon: Target,
      target: 1,
      current: completedToday,
      xpReward: 10,
    },
    {
      id: 'streak',
      titleKey: 'quests.keepStreak.title',
      descriptionKey: 'quests.keepStreak.description',
      icon: Flame,
      target: stats?.streak || 0,
      current: stats?.streak || 0,
      xpReward: (stats?.streak || 0) * 5,
    },
    {
      id: 'complete-three',
      titleKey: 'quests.tripleThreat.title',
      descriptionKey: 'quests.tripleThreat.description',
      icon: Trophy,
      target: 3,
      current: Math.min(totalCompleted, 3),
      xpReward: 25,
    },
  ];

  return (
    <div className="max-w-2xl mx-auto px-4 py-8">
      {/* Header */}
      <motion.div
        className="text-center mb-8"
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
      >
        <h1 className="font-display text-3xl font-bold text-gray-900 mb-2">
          {t('quests.title')}
        </h1>
        <p className="text-gray-600">{t('quests.description')}</p>
      </motion.div>

      {/* Streak Card */}
      <motion.div
        className="bg-gradient-to-br from-orange-500 to-red-500 rounded-3xl p-6 mb-8 text-white shadow-xl"
        initial={{ opacity: 0, scale: 0.95 }}
        animate={{ opacity: 1, scale: 1 }}
      >
        <div className="flex items-center justify-between">
          <div>
            <p className="text-white/80 text-sm font-medium mb-1">
              {t('quests.currentStreak')}
            </p>
            <div className="flex items-center gap-2">
              <Flame className="w-8 h-8" />
              <span className="text-4xl font-bold">{stats?.streak || 0}</span>
              <span className="text-xl">{t('quests.days')}</span>
            </div>
          </div>
          <div className="text-right">
            <p className="text-white/80 text-sm mb-1">{t('quests.totalXP')}</p>
            <p className="text-3xl font-bold">{stats?.xp || 0}</p>
          </div>
        </div>
      </motion.div>

      {/* Quests List */}
      <div className="space-y-4">
        {quests.map((quest, index) => {
          const isCompleted = quest.current >= quest.target;
          const progress = Math.min((quest.current / quest.target) * 100, 100);

          return (
            <motion.div
              key={quest.id}
              className="bg-white rounded-2xl p-6 shadow-md border border-gray-100"
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: index * 0.1 }}
            >
              <div className="flex items-start gap-4">
                {/* Icon */}
                <div
                  className={`w-12 h-12 rounded-full flex items-center justify-center ${
                    isCompleted
                      ? 'bg-green-100 text-green-600'
                      : 'bg-gray-100 text-gray-600'
                  }`}
                >
                  <quest.icon className="w-6 h-6" />
                </div>

                {/* Content */}
                <div className="flex-1">
                  <div className="flex items-start justify-between mb-2">
                    <div>
                      <h3 className="font-bold text-lg text-gray-900">
                        {t(quest.titleKey)}
                      </h3>
                      <p className="text-sm text-gray-600">
                        {t(quest.descriptionKey)}
                      </p>
                    </div>
                    {isCompleted ? (
                      <CheckCircle2 className="w-6 h-6 text-green-600 flex-shrink-0" />
                    ) : (
                      <Circle className="w-6 h-6 text-gray-300 flex-shrink-0" />
                    )}
                  </div>

                  {/* Progress Bar */}
                  <div className="mb-2">
                    <div className="w-full bg-gray-200 rounded-full h-2 overflow-hidden">
                      <motion.div
                        className={`h-full rounded-full ${
                          isCompleted ? 'bg-green-500' : 'bg-brand'
                        }`}
                        initial={{ width: 0 }}
                        animate={{ width: `${progress}%` }}
                        transition={{ duration: 0.5, delay: index * 0.1 + 0.2 }}
                      />
                    </div>
                  </div>

                  {/* Stats */}
                  <div className="flex items-center justify-between text-sm">
                    <span className="text-gray-600">
                      {quest.current}/{quest.target}
                    </span>
                    <span className="font-semibold text-amber-600">
                      +{quest.xpReward} XP
                    </span>
                  </div>
                </div>
              </div>
            </motion.div>
          );
        })}
      </div>
    </div>
  );
}
