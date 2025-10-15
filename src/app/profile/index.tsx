import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { 
  LogOut, Zap, Heart, Flame, Trophy, Star, Camera, 
  Award, Target, TrendingUp, ChevronRight, Calendar,
  BookOpen, Settings, Share2, Download
} from 'lucide-react';
import { useQuery } from '@tanstack/react-query';
import { useTranslation } from 'react-i18next';
import { supabase } from '../../lib/supabase';
import { useUserStats } from '../../hooks/useUserStats';
import { getUserProgress } from '../../db/queries';
import ProfileImageUpload from '../../components/ProfileImageUpload';
import StreakCalendar from '../../components/StreakCalendar';
import ProgressChart from '../../components/ProgressChart';
import { shareProgress, generateShareImage } from '../../utils/shareProgress';

export default function ProfileScreen() {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const { stats } = useUserStats();
  const [showImageUpload, setShowImageUpload] = useState(false);

  const { data: user } = useQuery({
    queryKey: ['auth-user'],
    queryFn: async () => {
      const { data } = await supabase.auth.getUser();
      return data.user;
    },
  });

  const { data: userProgress = [] } = useQuery({
    queryKey: ['user-progress', user?.id || 'guest'],
    queryFn: () => (user?.id ? getUserProgress(user.id) : Promise.resolve([])),
    enabled: true,
  });

  const handleSignOut = async () => {
    if (user) {
      await supabase.auth.signOut();
    }
    navigate('/');
  };

  const handleShareProgress = async () => {
    await shareProgress({
      xp: stats?.xp || 0,
      streak: stats?.streak || 0,
      lessonsCompleted: totalLessonsCompleted,
      totalStars: totalStars,
      level: userLevel,
    });
  };

  const handleDownloadCertificate = async () => {
    try {
      const image = await generateShareImage({
        xp: stats?.xp || 0,
        streak: stats?.streak || 0,
        lessonsCompleted: totalLessonsCompleted,
        totalStars: totalStars,
        level: userLevel,
      });
      
      const url = URL.createObjectURL(image);
      const a = document.createElement('a');
      a.href = url;
      a.download = `relingo-certificate-${new Date().toISOString().split('T')[0]}.png`;
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
      URL.revokeObjectURL(url);
      alert('📜 Sertifikatet ditt er lastet ned!');
    } catch (error) {
      console.error('Error generating certificate:', error);
      alert('Kunne ikke generere sertifikat. Prøv igjen senere.');
    }
  };

  const totalLessonsCompleted = userProgress.filter((p) => p.stars > 0).length;
  const totalStars = userProgress.reduce((sum, p) => sum + p.stars, 0);
  const userLevel = Math.floor((stats?.xp || 0) / 100);
  const xpToNextLevel = 100 - ((stats?.xp || 0) % 100);
  const xpProgress = ((stats?.xp || 0) % 100);

  // Animation variants
  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        delayChildren: 0.1,
        staggerChildren: 0.08
      }
    }
  };

  const itemVariants = {
    hidden: { y: 20, opacity: 0 },
    visible: {
      y: 0,
      opacity: 1,
      transition: {
        type: "spring" as const,
        stiffness: 300,
        damping: 24
      }
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100 dark:from-gray-900 dark:to-gray-800 transition-colors duration-300">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 lg:py-12">
        <motion.div
          variants={containerVariants}
          initial="hidden"
          animate="visible"
          className="space-y-8"
        >
          {/* Hero Section - Profile Header */}
          <motion.div
            variants={itemVariants}
            className="bg-gradient-to-br from-brand via-brand-dark to-emerald-700 rounded-3xl p-8 lg:p-12 text-white shadow-strong relative overflow-hidden"
          >
            {/* Background Pattern */}
            <div className="absolute inset-0 opacity-10">
              <div className="absolute top-0 right-0 w-64 h-64 bg-white rounded-full -translate-y-32 translate-x-32"></div>
              <div className="absolute bottom-0 left-0 w-96 h-96 bg-white rounded-full translate-y-48 -translate-x-48"></div>
            </div>

            <div className="relative z-10">
              <div className="flex flex-col lg:flex-row items-center lg:items-start gap-8">
                {/* Avatar - Much Larger */}
                <div className="relative group flex-shrink-0">
                  <div className="w-40 h-40 lg:w-48 lg:h-48 rounded-full border-4 border-white/30 overflow-hidden shadow-strong bg-white/20 backdrop-blur">
                    <img
                      src={user?.user_metadata?.avatar_url || '/assets/avatars/avatar1.svg'}
                      alt="Avatar"
                      className="w-full h-full object-cover"
                    />
                  </div>
                  {/* Hover Overlay with Text */}
                  <button
                    onClick={() => setShowImageUpload(true)}
                    className="absolute inset-0 w-40 h-40 lg:w-48 lg:h-48 rounded-full bg-black/60 backdrop-blur-sm flex flex-col items-center justify-center opacity-0 group-hover:opacity-100 transition-all duration-300 cursor-pointer"
                  >
                    <Camera className="w-8 h-8 text-white mb-2" />
                    <span className="text-white font-semibold text-sm">{t('profileExtended.changePhoto')}</span>
                  </button>
                </div>

                {/* User Info */}
                <div className="flex-1 text-center lg:text-left">
                  <h1 className="font-display text-4xl lg:text-5xl font-bold mb-2">
                    {user?.email?.split('@')[0] || 'Guest Learner'}
                  </h1>
                  <p className="text-white/90 text-lg mb-4">{user?.email || 'Guest Mode'}</p>
                  
                  {/* Level Badge */}
                  <div className="inline-flex items-center gap-2 bg-white/20 backdrop-blur px-5 py-2.5 rounded-full border border-white/30 shadow-md">
                    <Trophy className="w-5 h-5 text-amber-300" />
                    <span className="font-bold text-lg">{t('profileExtended.level')} {userLevel}</span>
                  </div>

                  {/* XP Progress */}
                  <div className="mt-6 max-w-md mx-auto lg:mx-0">
                    <div className="flex justify-between text-sm mb-2">
                      <span className="text-white/80">{t('profileExtended.progressToLevel')} {userLevel + 1}</span>
                      <span className="font-semibold">{xpProgress}/100 XP</span>
                    </div>
                    <div className="h-3 bg-white/20 rounded-full overflow-hidden backdrop-blur">
                      <motion.div
                        initial={{ width: 0 }}
                        animate={{ width: `${xpProgress}%` }}
                        transition={{ duration: 1, ease: "easeOut" }}
                        className="h-full bg-gradient-to-r from-amber-300 to-amber-500 rounded-full shadow-glow"
                      />
                    </div>
                    <p className="text-white/70 text-xs mt-2">{xpToNextLevel} {t('profileExtended.xpToNext')}</p>
                  </div>
                </div>
              </div>
            </div>
          </motion.div>

          {/* Stats Grid - 4 Columns on Desktop */}
          <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 lg:gap-6">
            {/* Total XP */}
            <motion.div
              variants={itemVariants}
              className="bg-white dark:bg-gray-800 rounded-2xl lg:rounded-3xl p-6 lg:p-8 shadow-medium hover:shadow-strong transition-all duration-300 border border-gray-100 dark:border-gray-700 hover:border-amber-200 dark:hover:border-amber-700 group cursor-default"
            >
              <div className="w-14 h-14 lg:w-16 lg:h-16 bg-gradient-to-br from-amber-400 to-amber-600 rounded-2xl flex items-center justify-center mb-4 shadow-md group-hover:scale-110 transition-transform">
                <Zap className="w-7 h-7 lg:w-8 lg:h-8 text-white" />
              </div>
              <p className="text-4xl lg:text-5xl font-bold text-gray-900 dark:text-white mb-2">{stats?.xp || 0}</p>
              <p className="text-gray-600 dark:text-gray-400 font-medium text-sm lg:text-base">{t('profileExtended.totalXP')}</p>
              <div className="mt-4 h-2 bg-gray-100 dark:bg-gray-700 rounded-full overflow-hidden">
                <div className="h-full bg-gradient-to-r from-amber-400 to-amber-600 rounded-full" style={{ width: `${xpProgress}%` }} />
              </div>
            </motion.div>

            {/* Streak */}
            <motion.div
              variants={itemVariants}
              className="bg-white dark:bg-gray-800 rounded-2xl lg:rounded-3xl p-6 lg:p-8 shadow-medium hover:shadow-strong transition-all duration-300 border border-gray-100 dark:border-gray-700 hover:border-orange-200 dark:hover:border-orange-700 group cursor-default"
            >
              <div className="w-14 h-14 lg:w-16 lg:h-16 bg-gradient-to-br from-orange-400 to-orange-600 rounded-2xl flex items-center justify-center mb-4 shadow-md group-hover:scale-110 transition-transform">
                <Flame className="w-7 h-7 lg:w-8 lg:h-8 text-white" />
              </div>
              <p className="text-4xl lg:text-5xl font-bold text-gray-900 dark:text-white mb-2">{stats?.streak || 0}</p>
              <p className="text-gray-600 dark:text-gray-400 font-medium text-sm lg:text-base">{t('profileExtended.daysStreak')}</p>
              <p className="text-xs text-gray-500 dark:text-gray-400 mt-2">🔥 {t('profileExtended.keepGoing')}</p>
            </motion.div>

            {/* Lessons */}
            <motion.div
              variants={itemVariants}
              className="bg-white dark:bg-gray-800 rounded-2xl lg:rounded-3xl p-6 lg:p-8 shadow-medium hover:shadow-strong transition-all duration-300 border border-gray-100 dark:border-gray-700 hover:border-brand-light group cursor-default"
            >
              <div className="w-14 h-14 lg:w-16 lg:h-16 bg-gradient-to-br from-brand to-brand-dark rounded-2xl flex items-center justify-center mb-4 shadow-md group-hover:scale-110 transition-transform">
                <Award className="w-7 h-7 lg:w-8 lg:h-8 text-white" />
              </div>
              <p className="text-4xl lg:text-5xl font-bold text-gray-900 dark:text-white mb-2">{totalLessonsCompleted}</p>
              <p className="text-gray-600 dark:text-gray-400 font-medium text-sm lg:text-base">{t('profileExtended.lessons')}</p>
              <p className="text-xs text-gray-500 dark:text-gray-400 mt-2">{t('profileExtended.completed')}</p>
            </motion.div>

            {/* Stars */}
            <motion.div
              variants={itemVariants}
              className="bg-white dark:bg-gray-800 rounded-2xl lg:rounded-3xl p-6 lg:p-8 shadow-medium hover:shadow-strong transition-all duration-300 border border-gray-100 dark:border-gray-700 hover:border-amber-200 dark:hover:border-amber-700 group cursor-default"
            >
              <div className="w-14 h-14 lg:w-16 lg:h-16 bg-gradient-to-br from-amber-300 to-amber-500 rounded-2xl flex items-center justify-center mb-4 shadow-md group-hover:scale-110 transition-transform">
                <Star className="w-7 h-7 lg:w-8 lg:h-8 text-white fill-white" />
              </div>
              <p className="text-4xl lg:text-5xl font-bold text-gray-900 dark:text-white mb-2">{totalStars}</p>
              <p className="text-gray-600 dark:text-gray-400 font-medium text-sm lg:text-base">{t('profileExtended.stars')}</p>
              <p className="text-xs text-gray-500 dark:text-gray-400 mt-2">{t('profileExtended.collected')}</p>
            </motion.div>
          </div>

          {/* Two Column Layout on Desktop */}
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 lg:gap-8">
            {/* Left Column - Achievements (2/3 width) */}
            <motion.div
              variants={itemVariants}
              className="lg:col-span-2 bg-white dark:bg-gray-800 rounded-3xl p-8 lg:p-10 shadow-medium border border-gray-100 dark:border-gray-700 transition-colors duration-300"
            >
              <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between mb-8">
                <h2 className="font-display text-2xl lg:text-3xl font-bold flex items-center gap-3 mb-4 sm:mb-0 text-gray-900 dark:text-white">
                  <Trophy className="w-7 h-7 lg:w-8 lg:h-8 text-amber-500 dark:text-amber-400" />
                  {t('profile.achievements')}
                </h2>
                <button className="text-brand dark:text-brand-light hover:text-brand-dark dark:hover:text-brand font-semibold flex items-center gap-1 transition-colors group">
                  {t('profileExtended.seeAll')}
                  <ChevronRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                </button>
              </div>

              <div className="grid grid-cols-2 lg:grid-cols-2 gap-6">
              {/* Hearts */}
              <div className="bg-gradient-to-br from-red-50 to-red-100/50 dark:from-red-900/20 dark:to-red-800/20 rounded-2xl p-6 hover:shadow-md transition-all cursor-default group border border-transparent dark:border-red-800/30">
                <div className="w-14 h-14 bg-white dark:bg-gray-700 rounded-xl flex items-center justify-center mb-4 shadow-sm group-hover:shadow-lg group-hover:scale-110 transition-all">
                  <Heart className="w-7 h-7 text-red-500 dark:text-red-400 fill-red-500 dark:fill-red-400" />
                </div>
                <p className="text-3xl lg:text-4xl font-bold text-gray-900 dark:text-white mb-1">{stats?.hearts || 0}</p>
                <p className="text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">{t('profile.hearts')}</p>
                <p className="text-xs text-gray-600 dark:text-gray-400">{t('profileExtended.remainingLives')}</p>
              </div>

              {/* XP */}
              <div className="bg-gradient-to-br from-amber-50 to-amber-100/50 dark:from-amber-900/20 dark:to-amber-800/20 rounded-2xl p-6 hover:shadow-md transition-all cursor-default group border border-transparent dark:border-amber-800/30">
                <div className="w-14 h-14 bg-white dark:bg-gray-700 rounded-xl flex items-center justify-center mb-4 shadow-sm group-hover:shadow-lg group-hover:scale-110 transition-all">
                  <TrendingUp className="w-7 h-7 text-amber-600 dark:text-amber-400" />
                </div>
                <p className="text-3xl lg:text-4xl font-bold text-gray-900 dark:text-white mb-1">{stats?.xp || 0}</p>
                <p className="text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">{t('profile.xp')}</p>
                <p className="text-xs text-gray-600 dark:text-gray-400">{t('profileExtended.xp')}</p>
              </div>

              {/* Perfect Scores */}
              <div className="bg-gradient-to-br from-purple-50 to-purple-100/50 dark:from-purple-900/20 dark:to-purple-800/20 rounded-2xl p-6 hover:shadow-md transition-all cursor-default group border border-transparent dark:border-purple-800/30">
                <div className="w-14 h-14 bg-white dark:bg-gray-700 rounded-xl flex items-center justify-center mb-4 shadow-sm group-hover:shadow-lg group-hover:scale-110 transition-all">
                  <Target className="w-7 h-7 text-purple-600 dark:text-purple-400" />
                </div>
                <p className="text-3xl lg:text-4xl font-bold text-gray-900 dark:text-white mb-1">
                  {userProgress.filter(p => p.stars === 3).length}
                </p>
                <p className="text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">{t('profileExtended.perfect')}</p>
                <p className="text-xs text-gray-600 dark:text-gray-400">{t('profileExtended.threeStars')}</p>
              </div>

              {/* Lessons */}
              <div className="bg-gradient-to-br from-brand/10 to-brand/20 dark:from-brand/20 dark:to-brand/30 rounded-2xl p-6 hover:shadow-md transition-all cursor-default group border border-transparent dark:border-brand/30">
                <div className="w-14 h-14 bg-white dark:bg-gray-700 rounded-xl flex items-center justify-center mb-4 shadow-sm group-hover:shadow-lg group-hover:scale-110 transition-all">
                  <Trophy className="w-7 h-7 text-brand dark:text-brand-light" />
                </div>
                <p className="text-3xl lg:text-4xl font-bold text-gray-900 dark:text-white mb-1">{totalLessonsCompleted}</p>
                <p className="text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">{t('profile.lessons')}</p>
                <p className="text-xs text-gray-600 dark:text-gray-400">{t('profileExtended.completed')}</p>
              </div>
            </div>
            </motion.div>

            {/* Right Column - Streak Calendar & Chart (1/3 width) */}
            <motion.div variants={itemVariants} className="space-y-6">
              <StreakCalendar streak={stats?.streak || 0} userId={user?.id} />
              <ProgressChart xp={stats?.xp || 0} userId={user?.id} />
            </motion.div>
          </div>

          {/* Recent Activity */}
          <motion.div
            variants={itemVariants}
            className="bg-white dark:bg-gray-800 rounded-3xl p-8 lg:p-10 shadow-medium border border-gray-100 dark:border-gray-700 transition-colors duration-300"
          >
            <div className="flex items-center justify-between mb-6">
              <h2 className="font-display text-2xl lg:text-3xl font-bold flex items-center gap-3 text-gray-900 dark:text-white">
                <Calendar className="w-7 h-7 lg:w-8 lg:h-8 text-brand dark:text-brand-light" />
                {t('profileExtended.recentActivity')}
              </h2>
            </div>

            {userProgress.length > 0 ? (
              <div className="space-y-3">
                {userProgress
                  .sort((a, b) => {
                    const dateA = a.last_completed_at ? new Date(a.last_completed_at).getTime() : 0;
                    const dateB = b.last_completed_at ? new Date(b.last_completed_at).getTime() : 0;
                    return dateB - dateA;
                  })
                  .slice(0, 5)
                  .map((progress, index) => (
                    <motion.div
                      key={progress.id}
                      initial={{ opacity: 0, x: -20 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ delay: index * 0.05 }}
                      className="flex items-center gap-4 p-4 rounded-xl hover:bg-gray-50 dark:hover:bg-gray-700/50 transition-colors cursor-pointer group"
                    >
                      <div className="w-12 h-12 bg-brand/10 dark:bg-brand/20 rounded-xl flex items-center justify-center group-hover:bg-brand/20 dark:group-hover:bg-brand/30 transition-colors">
                        <BookOpen className="w-6 h-6 text-brand dark:text-brand-light" />
                      </div>
                      <div className="flex-1">
                        <p className="font-semibold text-gray-900 dark:text-white">{t('profileExtended.lessonCompleted')}</p>
                        <p className="text-sm text-gray-600 dark:text-gray-400">
                          {progress.stars} {progress.stars === 1 ? t('profileExtended.star') : t('profileExtended.stars_plural')} • {progress.best_score}%
                        </p>
                      </div>
                      <div className="flex gap-1">
                        {[...Array(3)].map((_, i) => (
                          <Star
                            key={i}
                            className={`w-5 h-5 ${
                              i < progress.stars
                                ? 'text-amber-400 fill-amber-400'
                                : 'text-gray-300'
                            }`}
                          />
                        ))}
                      </div>
                    </motion.div>
                  ))}
              </div>
            ) : (
              <div className="text-center py-8">
                <BookOpen className="w-12 h-12 text-gray-300 dark:text-gray-600 mx-auto mb-3" />
                <p className="text-gray-600 dark:text-gray-400">{t('profileExtended.noActivity')}</p>
                <p className="text-sm text-gray-500 dark:text-gray-500 mt-1">{t('profileExtended.noActivityDesc')}</p>
              </div>
            )}
          </motion.div>

          {/* Quick Actions */}
          <motion.div
            variants={itemVariants}
            className="bg-white dark:bg-gray-800 rounded-3xl p-8 lg:p-10 shadow-medium border border-gray-100 dark:border-gray-700 transition-colors duration-300"
          >
            <h2 className="font-display text-2xl lg:text-3xl font-bold mb-6 text-gray-900 dark:text-white">{t('profileExtended.quickActions')}</h2>
            
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {/* Share Progress */}
              <button 
                onClick={handleShareProgress}
                className="flex flex-col items-center gap-3 p-6 rounded-2xl bg-gradient-to-br from-blue-50 to-blue-100 hover:shadow-md transition-all group"
              >
                <div className="w-14 h-14 bg-white rounded-xl flex items-center justify-center shadow-sm group-hover:scale-110 transition-transform">
                  <Share2 className="w-7 h-7 text-blue-600" />
                </div>
                <span className="font-semibold text-gray-900">{t('profileExtended.shareProgress')}</span>
              </button>

              {/* Download Certificate */}
              <button 
                onClick={handleDownloadCertificate}
                className="flex flex-col items-center gap-3 p-6 rounded-2xl bg-gradient-to-br from-purple-50 to-purple-100 hover:shadow-md transition-all group"
              >
                <div className="w-14 h-14 bg-white rounded-xl flex items-center justify-center shadow-sm group-hover:scale-110 transition-transform">
                  <Download className="w-7 h-7 text-purple-600" />
                </div>
                <span className="font-semibold text-gray-900">{t('profileExtended.downloadCertificate')}</span>
              </button>

              {/* Settings */}
              <button 
                onClick={() => navigate('/app/settings')}
                className="flex flex-col items-center gap-3 p-6 rounded-2xl bg-gradient-to-br from-gray-50 to-gray-100 hover:shadow-md transition-all group"
              >
                <div className="w-14 h-14 bg-white rounded-xl flex items-center justify-center shadow-sm group-hover:scale-110 transition-transform">
                  <Settings className="w-7 h-7 text-gray-700 group-hover:rotate-90 transition-transform duration-300" />
                </div>
                <span className="font-semibold text-gray-900">{t('sidebar.settings')}</span>
              </button>
            </div>
          </motion.div>

          {/* Settings Card */}
          <motion.div
            variants={itemVariants}
            className="bg-white dark:bg-gray-800 rounded-3xl shadow-medium border border-gray-100 dark:border-gray-700 overflow-hidden transition-colors duration-300"
          >
            <button
              onClick={handleSignOut}
              className="w-full p-6 lg:p-8 flex items-center justify-between hover:bg-red-50 dark:hover:bg-red-900/30 transition-colors group"
            >
              <div className="flex items-center gap-4">
                <div className="w-12 h-12 bg-red-100 dark:bg-red-900/30 rounded-xl flex items-center justify-center group-hover:bg-red-200 dark:group-hover:bg-red-900/50 transition-colors">
                  <LogOut className="w-6 h-6 text-red-600 dark:text-red-400" />
                </div>
                <div className="text-left">
                  <span className="font-semibold text-lg text-red-600 dark:text-red-400 block">
                    {user ? t('profile.signOut') : t('landing.hero.cta')}
                  </span>
                  <span className="text-sm text-gray-600 dark:text-gray-400">
                    {user ? t('profileExtended.signOutDesc') : 'Go back to landing page'}
                  </span>
                </div>
              </div>
              <ChevronRight className="w-6 h-6 text-red-600 dark:text-red-400 group-hover:translate-x-1 transition-transform" />
            </button>
          </motion.div>
        </motion.div>
      </div>

      {/* Profile Image Upload Modal */}
      {showImageUpload && user && (
        <ProfileImageUpload
          currentImageUrl={user.user_metadata?.avatar_url}
          userId={user.id}
          onClose={() => setShowImageUpload(false)}
        />
      )}
    </div>
  );
}
