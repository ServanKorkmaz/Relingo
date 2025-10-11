import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { LogOut, Zap, Heart, Flame, Trophy, Star } from 'lucide-react';
import { useQuery } from '@tanstack/react-query';
import { useTranslation } from 'react-i18next';
import { supabase } from '../../lib/supabase';
import { useUserStats } from '../../hooks/useUserStats';
import { getUserProgress } from '../../db/queries';

export default function ProfileScreen() {
  const navigate = useNavigate();
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

  const handleSignOut = async () => {
    await supabase.auth.signOut();
    navigate('/auth');
  };

  const totalLessonsCompleted = userProgress.filter((p) => p.stars > 0).length;
  const totalStars = userProgress.reduce((sum, p) => sum + p.stars, 0);

  return (
    <div className="max-w-2xl mx-auto px-4 py-8">
      {/* Profile Header */}
      <motion.div
        className="bg-gradient-to-br from-brand to-brand-dark rounded-3xl p-8 text-white mb-8 shadow-xl"
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
      >
        <div className="flex items-center gap-6 mb-6">
          {/* Avatar */}
          <div className="w-24 h-24 rounded-full bg-white/20 backdrop-blur flex items-center justify-center">
            <img
              src="/assets/avatars/avatar1.svg"
              alt="Avatar"
              className="w-20 h-20 rounded-full"
            />
          </div>

          {/* Info */}
          <div className="flex-1">
            <h1 className="font-display text-2xl font-bold mb-1">
              {user?.email?.split('@')[0] || 'Learner'}
            </h1>
            <p className="text-white/80 text-sm">{user?.email}</p>
          </div>
        </div>

        {/* Stats Grid */}
        <div className="grid grid-cols-2 gap-4">
          <div className="bg-white/10 backdrop-blur rounded-xl p-4">
            <div className="flex items-center gap-2 mb-1">
              <Zap className="w-5 h-5 text-amber-300" />
              <span className="text-white/80 text-sm">Total XP</span>
            </div>
            <p className="text-3xl font-bold">{stats?.xp || 0}</p>
          </div>

          <div className="bg-white/10 backdrop-blur rounded-xl p-4">
            <div className="flex items-center gap-2 mb-1">
              <Flame className="w-5 h-5 text-orange-300" />
              <span className="text-white/80 text-sm">Streak</span>
            </div>
            <p className="text-3xl font-bold">{stats?.streak || 0}</p>
          </div>
        </div>
      </motion.div>

      {/* Achievements */}
      <motion.div
        className="bg-white rounded-2xl p-6 shadow-md border border-gray-100 mb-8"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.1 }}
      >
        <h2 className="font-bold text-xl text-gray-900 mb-4 flex items-center gap-2">
          <Trophy className="w-6 h-6 text-amber-500" />
          {t('profile.achievements')}
        </h2>

        <div className="grid grid-cols-2 gap-4">
          {/* Lessons Completed */}
          <div className="bg-gray-50 rounded-xl p-4 text-center">
            <div className="w-12 h-12 bg-brand/10 rounded-full flex items-center justify-center mx-auto mb-2">
              <Trophy className="w-6 h-6 text-brand" />
            </div>
            <p className="text-2xl font-bold text-gray-900">
              {totalLessonsCompleted}
            </p>
            <p className="text-sm text-gray-600">{t('profile.lessons')}</p>
          </div>

          {/* Stars Earned */}
          <div className="bg-gray-50 rounded-xl p-4 text-center">
            <div className="w-12 h-12 bg-amber-50 rounded-full flex items-center justify-center mx-auto mb-2">
              <Star className="w-6 h-6 text-amber-500" />
            </div>
            <p className="text-2xl font-bold text-gray-900">{totalStars}</p>
            <p className="text-sm text-gray-600">{t('profile.stars')}</p>
          </div>

          {/* Hearts */}
          <div className="bg-gray-50 rounded-xl p-4 text-center">
            <div className="w-12 h-12 bg-red-50 rounded-full flex items-center justify-center mx-auto mb-2">
              <Heart className="w-6 h-6 text-red-500 fill-red-500" />
            </div>
            <p className="text-2xl font-bold text-gray-900">
              {stats?.hearts || 0}
            </p>
            <p className="text-sm text-gray-600">{t('profile.hearts')}</p>
          </div>

          {/* XP */}
          <div className="bg-gray-50 rounded-xl p-4 text-center">
            <div className="w-12 h-12 bg-amber-50 rounded-full flex items-center justify-center mx-auto mb-2">
              <Zap className="w-6 h-6 text-amber-600" />
            </div>
            <p className="text-2xl font-bold text-gray-900">{stats?.xp || 0}</p>
            <p className="text-sm text-gray-600">{t('profile.xp')}</p>
          </div>
        </div>
      </motion.div>

      {/* Settings */}
      <motion.div
        className="bg-white rounded-2xl shadow-md border border-gray-100"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.2 }}
      >
        <button
          onClick={handleSignOut}
          className="w-full p-4 flex items-center justify-between hover:bg-gray-50 rounded-2xl transition-colors"
        >
          <div className="flex items-center gap-3">
            <LogOut className="w-5 h-5 text-red-600" />
            <span className="font-medium text-red-600">{t('profile.signOut')}</span>
          </div>
        </button>
      </motion.div>
    </div>
  );
}
