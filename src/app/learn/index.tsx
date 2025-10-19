import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import { motion, AnimatePresence } from 'framer-motion';
import { ChevronDown, ChevronRight } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { getPublishedLessons, getReligions } from '../../db/queries';
import LessonNode from '../../features/learn/LessonNode';
import { getReligionColor } from '../../utils/colors';

export default function LearnScreen() {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const [expandedReligions, setExpandedReligions] = useState<string[]>([]);

  const { data: lessons = [], isLoading: lessonsLoading } = useQuery({
    queryKey: ['published-lessons'],
    queryFn: getPublishedLessons,
  });

  const { data: religions = [], isLoading: religionsLoading } = useQuery({
    queryKey: ['religions'],
    queryFn: getReligions,
  });

  const handleLessonClick = (lessonId: string, isLocked: boolean) => {
    if (!isLocked) {
      navigate(`/lesson/${lessonId}`);
    }
  };

  const toggleReligion = (slug: string) => {
    setExpandedReligions((prev) =>
      prev.includes(slug)
        ? prev.filter((s) => s !== slug)
        : [...prev, slug]
    );
  };

  if (lessonsLoading || religionsLoading) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand"></div>
      </div>
    );
  }

  // Group lessons by religion and sort by religion size
  const religionOrder = ['islam', 'christianity', 'hinduism', 'buddhism', 'judaism'];
  
  const groupedLessons = religionOrder.map((slug) => {
    const religion = religions.find((r) => r.slug === slug);
    const religionLessons = lessons.filter(
      (l) => l.religion?.slug === slug
    ).sort((a, b) => a.order_index - b.order_index);
    
    // Calculate progress
    const completedLessons = religionLessons.filter(l => l.user_progress?.stars && l.user_progress.stars > 0).length;
    const totalStars = religionLessons.reduce((sum, l) => sum + (l.user_progress?.stars || 0), 0);
    
    return {
      religion,
      lessons: religionLessons,
      completedLessons,
      totalStars,
    };
  }).filter((group) => group.lessons.length > 0);

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100 dark:from-gray-900 dark:to-gray-800 transition-colors duration-300">
      <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8 lg:py-12">
        {/* Header */}
        <motion.div
          className="text-center mb-10 lg:mb-12"
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
        >
          <h1 className="font-display text-4xl lg:text-5xl font-bold text-gray-900 dark:text-white mb-3">
            {t('learn.title')}
          </h1>
          <p className="text-lg lg:text-xl text-gray-600 dark:text-gray-400 max-w-2xl mx-auto">
            {t('learn.description')}
          </p>
        </motion.div>

        {/* Accordion: Grouped by Religion */}
        <div className="space-y-4 lg:space-y-6">
        {groupedLessons.map((group, groupIndex) => {
          if (!group.religion) return null;
          
          const color = getReligionColor(group.religion.slug);
          const isExpanded = expandedReligions.includes(group.religion.slug);
          
          return (
            <motion.div
              key={group.religion.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: groupIndex * 0.05 }}
              className="bg-white dark:bg-gray-800 rounded-3xl shadow-medium hover:shadow-strong border border-gray-100 dark:border-gray-700 overflow-hidden transition-all duration-300"
            >
              {/* Accordion Header */}
              <button
                onClick={() => toggleReligion(group.religion!.slug)}
                className="w-full p-6 lg:p-8 flex items-center justify-between hover:bg-gray-50 dark:hover:bg-gray-700/50 transition-all duration-200 group"
              >
                <div className="flex items-center gap-5 lg:gap-6">
                  {/* Religion Icon */}
                  {group.religion.icon_url && (
                    <div
                      className="w-16 h-16 lg:w-20 lg:h-20 rounded-2xl flex items-center justify-center shadow-soft group-hover:scale-105 transition-transform"
                      style={{ backgroundColor: `${color}15` }}
                    >
                      <img
                        src={group.religion.icon_url}
                        alt={group.religion.name}
                        className="w-12 h-12 lg:w-14 lg:h-14"
                      />
                    </div>
                  )}
                  
                  {/* Religion Info */}
                  <div className="text-left">
                    <h2
                      className="font-display text-2xl lg:text-3xl font-bold mb-2"
                      style={{ color }}
                    >
                      {t(`religions.${group.religion.slug}`)}
                    </h2>
                    <div className="flex flex-wrap items-center gap-3 lg:gap-4 text-sm lg:text-base text-gray-600 dark:text-gray-400">
                      <span className="font-medium">
                        {group.lessons.length} {group.lessons.length === 1 ? t('learn.lesson') : t('learn.lessons')}
                      </span>
                      {group.completedLessons > 0 && (
                        <>
                          <span className="text-gray-400 dark:text-gray-500">•</span>
                          <span className="text-brand dark:text-brand-light font-semibold">
                            {group.completedLessons} {t('learn.completed')}
                          </span>
                        </>
                      )}
                      {group.totalStars > 0 && (
                        <>
                          <span className="text-gray-400 dark:text-gray-500">•</span>
                          <span className="text-amber-600 dark:text-amber-400 font-semibold flex items-center gap-1">
                            {group.totalStars} stjerner
                          </span>
                        </>
                      )}
                    </div>
                    {/* Progress Bar */}
                    {group.lessons.length > 0 && (
                      <div className="mt-3 lg:mt-4">
                        <div className="h-2 bg-gray-200 dark:bg-gray-700 rounded-full overflow-hidden w-48 lg:w-64">
                          <div
                            className="h-full rounded-full transition-all duration-500"
                            style={{
                              width: `${(group.completedLessons / group.lessons.length) * 100}%`,
                              backgroundColor: color
                            }}
                          />
                        </div>
                        <p className="text-xs text-gray-500 dark:text-gray-400 mt-1">
                          {Math.round((group.completedLessons / group.lessons.length) * 100)}% {t('learn.completed')}
                        </p>
                      </div>
                    )}
                  </div>
                </div>

                {/* Expand/Collapse Icon */}
                <div className="flex-shrink-0">
                  {isExpanded ? (
                    <ChevronDown className="w-7 h-7 text-gray-400 dark:text-gray-500 group-hover:text-gray-600 dark:group-hover:text-gray-400 transition-colors" />
                  ) : (
                    <ChevronRight className="w-7 h-7 text-gray-400 dark:text-gray-500 group-hover:text-gray-600 dark:group-hover:text-gray-400 transition-colors" />
                  )}
                </div>
              </button>

              {/* Accordion Content */}
              <AnimatePresence>
                {isExpanded && (
                  <motion.div
                    initial={{ height: 0, opacity: 0 }}
                    animate={{ height: 'auto', opacity: 1 }}
                    exit={{ height: 0, opacity: 0 }}
                    transition={{ duration: 0.3 }}
                    className="overflow-hidden"
                  >
                    <div
                      className="px-5 pb-6 pt-4"
                      style={{ backgroundColor: `${color}05` }}
                    >
                      {/* Lessons grid */}
                      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                        {group.lessons.map((lesson) => {
                          const isLocked = false;

                          return (
                            <motion.div
                              key={lesson.id}
                              initial={{ opacity: 0, scale: 0.9 }}
                              animate={{ opacity: 1, scale: 1 }}
                              transition={{ duration: 0.3 }}
                            >
                              <LessonNode
                                lesson={lesson}
                                isLocked={isLocked}
                                onClick={() => handleLessonClick(lesson.id, isLocked)}
                              />
                            </motion.div>
                          );
                        })}
                      </div>
                    </div>
                  </motion.div>
                )}
              </AnimatePresence>
            </motion.div>
          );
        })}
      </div>

        {/* Empty State */}
        {groupedLessons.length === 0 && (
          <div className="text-center py-16 lg:py-20">
            <p className="text-lg lg:text-xl text-gray-600 dark:text-gray-400">{t('learn.noLessons')}</p>
          </div>
        )}
      </div>
    </div>
  );
}
