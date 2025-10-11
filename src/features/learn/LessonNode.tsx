import { Lock, Star } from 'lucide-react';
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

  return (
    <motion.button
      onClick={onClick}
      disabled={isLocked}
      className="relative flex flex-col items-center gap-2"
      whileHover={!isLocked ? { scale: 1.05 } : undefined}
      whileTap={!isLocked ? { scale: 0.95 } : undefined}
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
    >
      {/* Node Circle */}
      <div
        className={`w-20 h-20 rounded-full border-4 flex items-center justify-center transition-all ${
          isLocked
            ? 'bg-gray-300 border-gray-400 cursor-not-allowed'
            : 'shadow-lg cursor-pointer'
        }`}
        style={
          !isLocked
            ? {
                backgroundColor: color,
                borderColor: color,
                boxShadow: `0 4px 12px ${color}40`,
              }
            : undefined
        }
      >
        {isLocked ? (
          <Lock className="w-8 h-8 text-gray-500" />
        ) : lesson.thumbnail_url ? (
          <img
            src={lesson.thumbnail_url}
            alt={lesson.title}
            className="w-full h-full rounded-full object-cover"
          />
        ) : (
          <span className="text-2xl font-bold text-white">
            {lesson.title.charAt(0)}
          </span>
        )}
      </div>

      {/* Stars */}
      {!isLocked && stars > 0 && (
        <div className="absolute -top-2 -right-2 flex gap-0.5">
          {Array.from({ length: Math.min(3, stars) }).map((_, i) => (
            <Star
              key={i}
              className="w-4 h-4 text-amber-400 fill-amber-400"
            />
          ))}
        </div>
      )}

      {/* Title */}
      <div className="text-center max-w-[120px]">
        <p className="font-semibold text-sm text-gray-900 line-clamp-2">
          {lesson.title}
        </p>
        {lesson.difficulty && (
          <p className="text-xs text-gray-500 mt-0.5">
            {t('lesson.level')} {lesson.difficulty}
          </p>
        )}
      </div>
    </motion.button>
  );
}
