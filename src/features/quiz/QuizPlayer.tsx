import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import { X, Heart, Trophy, Star } from 'lucide-react';
import { useQuery } from '@tanstack/react-query';
import { useTranslation } from 'react-i18next';
import { getQuestions } from '../../db/queries';
import { useUserStats } from '../../hooks/useUserStats';
import MCQCard from './MCQCard';
import TFCard from './TFCard';
import GapCard from './GapCard';
import type { Question } from '../../types';

interface QuizPlayerProps {
  quizId: string;
  lessonId: string;
  onComplete: (result: { score: number; totalQuestions: number; perfect: boolean }) => void;
}

export default function QuizPlayer({ quizId, lessonId, onComplete }: QuizPlayerProps) {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const { stats, loseHeart } = useUserStats();
  const [currentIndex, setCurrentIndex] = useState(0);
  const [correctCount, setCorrectCount] = useState(0);
  const [showResult, setShowResult] = useState(false);

  const { data: questions = [], isLoading } = useQuery<Question[]>({
    queryKey: ['questions', quizId],
    queryFn: async () => {
      console.log('Loading questions for quiz:', quizId);
      const data = await getQuestions(quizId);
      console.log('Loaded questions:', data);
      return data;
    },
  });

  const currentQuestion = questions[currentIndex];
  const progress = questions.length > 0 ? ((currentIndex + 1) / questions.length) * 100 : 0;

  // Log current state
  console.log('Quiz state:', { 
    questionsCount: questions.length, 
    currentIndex, 
    showResult,
    currentQuestion: currentQuestion?.id 
  });

  // Safety check - only show error if we have questions but can't load current one
  if (!showResult && !isLoading && questions.length > 0 && !currentQuestion) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gray-50">
        <div className="bg-white rounded-3xl p-8 shadow-xl max-w-md text-center">
          <p className="text-2xl font-bold text-gray-900 mb-4">Error Loading Question</p>
          <p className="text-gray-600 mb-6">
            Question {currentIndex + 1} of {questions.length} could not be loaded.
            <br />
            <br />
            Quiz ID: {quizId}
            <br />
            Questions in quiz: {questions.length}
          </p>
          <button
            onClick={() => {
              console.error('Quiz error details:', { quizId, questionsCount: questions.length, currentIndex, questions });
              navigate('/app/learn');
            }}
            className="w-full py-4 bg-brand text-white font-semibold text-lg rounded-2xl hover:bg-brand-dark transition-colors"
          >
            Back to Learn
          </button>
        </div>
      </div>
    );
  }

  const handleAnswer = (isCorrect: boolean) => {
    console.log('Answer submitted:', { isCorrect, currentIndex, totalQuestions: questions.length });
    
    // Calculate new correct count immediately
    const newCorrectCount = isCorrect ? correctCount + 1 : correctCount;
    
    if (!isCorrect) {
      loseHeart();
    }

    // Move to next question or show results immediately
    if (currentIndex < questions.length - 1) {
      console.log('Moving to next question:', currentIndex + 1);
      setCorrectCount(newCorrectCount);
      setCurrentIndex((prev) => prev + 1);
    } else {
      console.log('Quiz complete! Showing results...', { 
        finalCorrectCount: newCorrectCount, 
        totalQuestions: questions.length 
      });
      
      // Calculate final results
      const score = Math.round((newCorrectCount / questions.length) * 100);
      const perfect = newCorrectCount === questions.length;
      
      console.log('Final results:', { score, perfect, newCorrectCount });
      
      // Update states
      setCorrectCount(newCorrectCount);
      setShowResult(true);
      
      // Call onComplete immediately (not in useEffect to avoid infinite loop)
      onComplete({
        score,
        totalQuestions: questions.length,
        perfect,
      });
    }
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gray-50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand mx-auto mb-4"></div>
          <p className="text-gray-600">{t('quiz.loading')}</p>
        </div>
      </div>
    );
  }

  if (!questions || questions.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center min-h-screen bg-gray-50 text-center px-4">
        <div className="bg-white rounded-3xl p-8 shadow-xl max-w-md">
          <p className="text-2xl font-bold text-gray-900 mb-4">{t('quiz.noQuestions')}</p>
          <p className="text-gray-600 mb-6">
            {t('quiz.noQuestionsDescription')}
          </p>
          <button
            onClick={() => navigate('/app/learn')}
            className="w-full py-4 bg-brand text-white font-semibold text-lg rounded-2xl hover:bg-brand-dark transition-colors"
          >
            {t('quiz.backToLearn')}
          </button>
        </div>
      </div>
    );
  }

  if (showResult) {
    console.log('RENDERING RESULT SCREEN:', { correctCount, totalQuestions: questions.length, showResult });
    
    const score = Math.round((correctCount / questions.length) * 100);
    const perfect = correctCount === questions.length;
    const stars = perfect ? 3 : score >= 80 ? 2 : score >= 60 ? 1 : 0;

    console.log('Result stats:', { score, perfect, stars });

    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50 px-4 py-8">
        <motion.div
          className="w-full max-w-md"
          initial={{ opacity: 0, scale: 0.9 }}
          animate={{ opacity: 1, scale: 1 }}
        >
          <div className="bg-white rounded-3xl p-8 shadow-xl">
            <Trophy className="w-20 h-20 text-amber-500 mx-auto mb-4" />
            <h2 className="font-display text-3xl font-bold text-gray-900 mb-2 text-center">
              {perfect ? t('quiz.result.perfect') : t('quiz.result.wellDone')}
            </h2>
            <p className="text-gray-600 mb-6 text-center">
              {t('quiz.result.youGot')} {correctCount} {t('quiz.result.outOf')} {questions.length} {t('quiz.result.correct')}
            </p>

            {/* Stars */}
            <div className="flex justify-center gap-2 mb-6">
              {Array.from({ length: 3 }).map((_, i) => (
                <Star
                  key={i}
                  className={`w-10 h-10 ${
                    i < stars ? 'text-amber-400 fill-amber-400' : 'text-gray-300'
                  }`}
                />
              ))}
            </div>

            {/* Score */}
            <div className="text-5xl font-bold text-brand mb-8 text-center">{score}%</div>

            <button
              onClick={() => navigate('/app/learn')}
              className="w-full py-4 bg-brand text-white font-semibold text-lg rounded-2xl hover:bg-brand-dark transition-colors"
            >
              {t('quiz.continue')}
            </button>
          </div>
        </motion.div>
      </div>
    );
  }

  return (
    <div className="min-h-screen pb-20">
      {/* Header */}
      <div className="bg-white border-b sticky top-0 z-40">
        <div className="max-w-2xl mx-auto px-4 py-3">
          <div className="flex items-center justify-between mb-2">
            <button
              onClick={() => navigate(-1)}
              className="p-2 hover:bg-gray-100 rounded-lg transition-colors"
            >
              <X className="w-6 h-6 text-gray-600" />
            </button>

            <div className="flex items-center gap-2">
              <Heart className="w-5 h-5 text-red-500 fill-red-500" />
              <span className="font-semibold text-red-900">{stats?.hearts || 0}</span>
            </div>
          </div>

          {/* Progress Bar */}
          <div className="w-full bg-gray-200 rounded-full h-3 overflow-hidden">
            <motion.div
              className="h-full bg-brand rounded-full"
              initial={{ width: 0 }}
              animate={{ width: `${progress}%` }}
              transition={{ duration: 0.3 }}
            />
          </div>

          <p className="text-sm text-gray-600 mt-2">
            {t('quiz.question')} {currentIndex + 1} {t('quiz.of')} {questions.length}
          </p>
        </div>
      </div>

      {/* Question Card */}
      <div className="max-w-2xl mx-auto px-4 py-8">
        <AnimatePresence mode="wait">
          {currentQuestion && (
            <div key={currentQuestion.id}>
              {currentQuestion.type === 'mcq' && (
                <MCQCard question={currentQuestion} onAnswer={handleAnswer} />
              )}
              {currentQuestion.type === 'tf' && (
                <TFCard question={currentQuestion} onAnswer={handleAnswer} />
              )}
              {currentQuestion.type === 'gap' && (
                <GapCard question={currentQuestion} onAnswer={handleAnswer} />
              )}
            </div>
          )}
        </AnimatePresence>
      </div>
    </div>
  );
}
