import { Lock, Star, BookOpen, CheckCircle2 } from 'lucide-react';
import { motion } from 'framer-motion';
import { useTranslation } from 'react-i18next';
import type { Lesson } from '../../types';
import { getReligionColor } from '../../utils/colors';

interface LessonNodeProps {
  lesson: Lesson;
  isLocked: boolean;
  onClick: () => void;
}

export default function LessonNode({ lesson, isLocked, onClick }: LessonNodeProps) {
  const { t } = useTranslation();
  const color = lesson.religion ? getReligionColor(lesson.religion.slug) : '#2ED573';
  const stars = lesson.user_progress?.stars || 0;
  const isCompleted = stars > 0;

  return (
    <motion.button
      onClick={onClick}
      disabled={isLocked}
      className={`
        relative w-full max-w-md mx-auto
        ${isLocked ? 'cursor-not-allowed' : 'cursor-pointer'}
      `}
      whileHover={!isLocked ? { scale: 1.02, y: -4 } : undefined}
      whileTap={!isLocked ? { scale: 0.98 } : undefined}
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
    >
      <div 
        className={`
          bg-white dark:bg-gray-800 rounded-2xl shadow-medium hover:shadow-strong
          border-2 transition-all duration-300 overflow-hidden
          ${isLocked 
            ? 'border-gray-300 dark:border-gray-700 opacity-60' 
            : isCompleted
            ? 'border-amber-300 dark:border-amber-600'
            : 'border-gray-200 dark:border-gray-700 hover:border-purple-300 dark:hover:border-purple-600'
          }
        `}
        style={!isLocked && !isCompleted ? { borderColor: `${color}40` } : undefined}
      >
        {/* Thumbnail Section */}
        <div className="relative h-32 overflow-hidden" style={{
          background: isLocked 
            ? '#f3f4f6' 
            : `linear-gradient(135deg, ${color}15, ${color}05)`
        }}>
          {lesson.thumbnail_url && !isLocked && (
            <img
              src={lesson.thumbnail_url}
              alt={lesson.title}
              className="w-full h-full object-contain p-4"
            />
          )}
          
          {isLocked && (
            <div className="absolute inset-0 flex items-center justify-center">
              <div className="w-16 h-16 rounded-full bg-gray-300 dark:bg-gray-700 flex items-center justify-center">
                <Lock className="w-8 h-8 text-gray-500 dark:text-gray-400" />
              </div>
            </div>
          )}

          {/* Completed badge */}
          {isCompleted && (
            <div className="absolute top-3 right-3 bg-amber-400 rounded-full p-1.5 shadow-lg">
              <CheckCircle2 className="w-5 h-5 text-white" />
            </div>
          )}

          {/* Stars overlay */}
          {!isLocked && stars > 0 && (
            <div className="absolute top-3 left-3 flex gap-1 bg-white/90 dark:bg-gray-800/90 px-2 py-1 rounded-full shadow-md">
              {Array.from({ length: 3 }).map((_, i) => (
                <Star
                  key={i}
                  className={`w-4 h-4 ${
                    i < stars 
                      ? 'text-amber-400 fill-amber-400' 
                      : 'text-gray-300 dark:text-gray-600'
                  }`}
                />
              ))}
            </div>
          )}
        </div>

        {/* Content Section */}
        <div className="p-4">
          <h3 className="font-bold text-base text-gray-900 dark:text-white mb-2 line-clamp-2 text-left">
            {lesson.title_key ? t(lesson.title_key) : lesson.title}
          </h3>
          
          {(lesson.description_key || lesson.description) && (
            <p className="text-sm text-gray-600 dark:text-gray-400 mb-3 line-clamp-2 text-left">
              {lesson.description_key ? t(lesson.description_key) : lesson.description}
            </p>
          )}

          {/* Bottom info */}
          <div className="flex items-center justify-between text-xs">
            <div className="flex items-center gap-1.5">
              <BookOpen className="w-4 h-4" style={{ color }} />
              <span className="text-gray-600 dark:text-gray-400">
                {t('lesson.level')} {lesson.difficulty}
              </span>
            </div>

            {isCompleted && lesson.user_progress && (
              <div className="flex items-center gap-1.5">
                <span className="font-semibold text-amber-600 dark:text-amber-400">
                  {lesson.user_progress.best_score}%
                </span>
              </div>
            )}

            {!isCompleted && !isLocked && (
              <span className="text-gray-500 dark:text-gray-400 font-medium">
                {t('lesson.startLesson')}
              </span>
            )}
          </div>
        </div>
      </div>
    </motion.button>
  );
}
