import { useParams, useNavigate } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import { motion } from 'framer-motion';
import { ArrowLeft, Play, Star, Trophy } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { getLessonById, getQuizzesForLesson } from '../../db/queries';
import { getReligionColor } from '../../utils/colors';

export default function LessonScreen() {
  const { lessonId } = useParams<{ lessonId: string }>();
  const navigate = useNavigate();
  const { t } = useTranslation();

  const { data: lesson, isLoading: lessonLoading } = useQuery({
    queryKey: ['lesson', lessonId],
    queryFn: () => getLessonById(lessonId!),
    enabled: !!lessonId,
  });

  const { data: quizzes = [], isLoading: quizzesLoading } = useQuery({
    queryKey: ['quizzes', lessonId],
    queryFn: () => getQuizzesForLesson(lessonId!),
    enabled: !!lessonId,
  });

  if (lessonLoading || quizzesLoading) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand"></div>
      </div>
    );
  }

  if (!lesson) {
    return (
      <div className="flex flex-col items-center justify-center min-h-[60vh] px-4">
        <p className="text-xl text-gray-600 mb-4">{t('lesson.notFound')}</p>
        <button
          onClick={() => navigate('/app/learn')}
          className="text-brand hover:text-brand-dark font-medium"
        >
          {t('quiz.backToLearn')}
        </button>
      </div>
    );
  }

  const color = lesson.religion ? getReligionColor(lesson.religion.slug) : '#2ED573';
  const stars = lesson.user_progress?.stars || 0;
  const bestScore = lesson.user_progress?.best_score || 0;

  const handleStartQuiz = () => {
    if (quizzes.length > 0) {
      navigate(`/quiz/${quizzes[0].id}`);
    }
  };

  return (
    <div className="max-w-2xl mx-auto px-4 py-8">
      {/* Back Button */}
      <button
        onClick={() => navigate('/app/learn')}
        className="flex items-center gap-2 text-gray-600 hover:text-gray-900 mb-6 transition-colors"
      >
        <ArrowLeft className="w-5 h-5" />
        <span className="font-medium">{t('lesson.back')}</span>
      </button>

      {/* Lesson Card */}
      <motion.div
        className="bg-white rounded-3xl shadow-xl overflow-hidden"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
      >
        {/* Header with Thumbnail */}
        <div
          className="h-48 flex items-center justify-center relative"
          style={{ backgroundColor: `${color}20` }}
        >
          {lesson.thumbnail_url ? (
            <img
              src={lesson.thumbnail_url}
              alt={lesson.title}
              className="h-full w-full object-cover"
            />
          ) : (
            <div
              className="w-24 h-24 rounded-full flex items-center justify-center text-white text-4xl font-bold"
              style={{ backgroundColor: color }}
            >
              {lesson.title.charAt(0)}
            </div>
          )}

          {/* Progress Badge */}
          {stars > 0 && (
            <div className="absolute top-4 right-4 bg-white rounded-full px-3 py-1.5 shadow-lg flex items-center gap-1">
              {Array.from({ length: stars }).map((_, i) => (
                <Star
                  key={i}
                  className="w-4 h-4 text-amber-400 fill-amber-400"
                />
              ))}
            </div>
          )}
        </div>

        {/* Content */}
        <div className="p-8">
          {/* Religion Badge */}
          {lesson.religion && (
            <div className="inline-flex items-center gap-2 mb-4">
              {lesson.religion.icon_url && (
                <img
                  src={lesson.religion.icon_url}
                  alt={lesson.religion.name}
                  className="w-6 h-6"
                />
              )}
              <span
                className="font-semibold text-sm"
                style={{ color }}
              >
                {lesson.religion.name}
              </span>
            </div>
          )}

          {/* Title */}
          <h1 className="font-display text-3xl font-bold text-gray-900 mb-3">
            {lesson.title}
          </h1>

          {/* Description */}
          {lesson.description && (
            <p className="text-gray-600 mb-6 text-lg">{lesson.description}</p>
          )}

          {/* Stats */}
            <div className="flex gap-4 mb-8">
            <div className="flex items-center gap-2 bg-gray-50 px-4 py-2 rounded-xl">
              <Trophy className="w-5 h-5 text-gray-600" />
              <span className="text-sm font-medium text-gray-700">
                {t('lesson.bestScore')}: {bestScore}%
              </span>
            </div>
            <div className="flex items-center gap-2 bg-gray-50 px-4 py-2 rounded-xl">
              <Star className="w-5 h-5 text-amber-500" />
              <span className="text-sm font-medium text-gray-700">
                {stars}/3 {t('lesson.stars')}
              </span>
            </div>
          </div>

          {/* Start Button */}
          <button
            onClick={handleStartQuiz}
            disabled={quizzes.length === 0}
            className="w-full py-4 bg-brand text-white font-semibold text-lg rounded-2xl hover:bg-brand-dark transition-colors disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
          >
            <Play className="w-5 h-5" />
            <span>{stars > 0 ? t('lesson.practiceAgain') : t('lesson.startLesson')}</span>
          </button>
        </div>
      </motion.div>
    </div>
  );
}
