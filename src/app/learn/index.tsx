import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import { motion, AnimatePresence } from 'framer-motion';
import { ChevronDown, ChevronRight } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { getPublishedLessons, getReligions } from '../../db/queries';
import LessonNode from '../../features/learn/LessonNode';
import LessonPath from '../../features/learn/LessonPath';
import { getReligionColor } from '../../utils/colors';

export default function LearnScreen() {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const [expandedReligions, setExpandedReligions] = useState<string[]>(['christianity']);

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
  const religionOrder = ['christianity', 'islam', 'hinduism', 'judaism'];
  
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
    <div className="max-w-screen-sm mx-auto px-4 py-8">
      {/* Header */}
      <motion.div
        className="text-center mb-8"
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
      >
        <h1 className="font-display text-3xl font-bold text-gray-900 mb-2">
          {t('learn.title')}
        </h1>
        <p className="text-gray-600">
          {t('learn.description')}
        </p>
      </motion.div>

      {/* Accordion: Grouped by Religion */}
      <div className="space-y-3">
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
              className="bg-white rounded-2xl shadow-md border border-gray-100 overflow-hidden"
            >
              {/* Accordion Header */}
              <button
                onClick={() => toggleReligion(group.religion.slug)}
                className="w-full p-5 flex items-center justify-between hover:bg-gray-50 transition-colors"
              >
                <div className="flex items-center gap-4">
                  {/* Religion Icon */}
                  {group.religion.icon_url && (
                    <div
                      className="w-14 h-14 rounded-xl flex items-center justify-center"
                      style={{ backgroundColor: `${color}15` }}
                    >
                      <img
                        src={group.religion.icon_url}
                        alt={group.religion.name}
                        className="w-10 h-10"
                      />
                    </div>
                  )}
                  
                  {/* Religion Info */}
                  <div className="text-left">
                    <h2
                      className="font-display text-xl font-bold mb-0.5"
                      style={{ color }}
                    >
                      {t(`religions.${group.religion.slug}`)}
                    </h2>
                    <div className="flex items-center gap-3 text-sm text-gray-600">
                      <span>
                        {group.lessons.length} {group.lessons.length === 1 ? t('learn.lesson') : t('learn.lessons')}
                      </span>
                      {group.completedLessons > 0 && (
                        <>
                          <span className="text-gray-400">•</span>
                          <span className="text-brand font-medium">
                            {group.completedLessons} {t('learn.completed')}
                          </span>
                        </>
                      )}
                      {group.totalStars > 0 && (
                        <>
                          <span className="text-gray-400">•</span>
                          <span className="text-amber-600 font-medium">
                            ⭐ {group.totalStars}
                          </span>
                        </>
                      )}
                    </div>
                  </div>
                </div>

                {/* Expand/Collapse Icon */}
                <div className="flex-shrink-0">
                  {isExpanded ? (
                    <ChevronDown className="w-6 h-6 text-gray-400" />
                  ) : (
                    <ChevronRight className="w-6 h-6 text-gray-400" />
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
                      className="px-5 pb-5 pt-2"
                      style={{ backgroundColor: `${color}05` }}
                    >
                      {/* Lessons for this religion */}
                      <div className="space-y-0">
                        {group.lessons.map((lesson, index) => {
                          const isLocked = false;

                          return (
                            <div key={lesson.id}>
                              <div className="flex justify-center">
                                <LessonNode
                                  lesson={lesson}
                                  isLocked={isLocked}
                                  onClick={() => handleLessonClick(lesson.id, isLocked)}
                                />
                              </div>
                              {index < group.lessons.length - 1 && (
                                <LessonPath color={`${color}40`} />
                              )}
                            </div>
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
        <div className="text-center py-12">
          <p className="text-gray-600">{t('learn.noLessons')}</p>
        </div>
      )}
    </div>
  );
}
