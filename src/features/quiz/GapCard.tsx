import { useState } from 'react';
import { motion } from 'framer-motion';
import { Check, X } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import type { Question } from '../../types';

interface GapCardProps {
  question: Question;
  onAnswer: (isCorrect: boolean) => void;
}

export default function GapCard({ question, onAnswer }: GapCardProps) {
  const { t } = useTranslation();
  const [answer, setAnswer] = useState('');
  const [submitted, setSubmitted] = useState(false);
  
  // Questions are now pre-translated in the database
  const translatedPrompt = question.prompt;
  
  const correctAnswer = (question.meta.answer as string)?.toLowerCase().trim();

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (submitted || !answer.trim()) return;
    
    setSubmitted(true);
  };

  const handleContinue = () => {
    const userAnswer = answer.toLowerCase().trim();
    const isCorrect = userAnswer === correctAnswer;
    onAnswer(isCorrect);
  };

  const isCorrect = submitted && answer.toLowerCase().trim() === correctAnswer;
  const isIncorrect = submitted && answer.toLowerCase().trim() !== correctAnswer;

  return (
    <motion.div
      className="quiz-card max-w-2xl mx-auto"
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
    >
      {/* Prompt */}
      <h2 className="font-display text-2xl md:text-3xl font-bold text-gray-900 mb-6">
        {translatedPrompt}
      </h2>

      {/* Media */}
      {question.media_url && (
        <div className="mb-6">
          <img
            src={question.media_url}
            alt="Question media"
            className="w-full max-h-64 object-cover rounded-xl"
          />
        </div>
      )}

      {/* Input Form */}
      <form onSubmit={handleSubmit} className="space-y-4">
        <div className="relative">
          <input
            type="text"
            value={answer}
            onChange={(e) => setAnswer(e.target.value)}
            disabled={submitted}
            placeholder={t('quiz.typeAnswer')}
            className={`w-full px-6 py-4 text-lg rounded-2xl border-2 transition-all focus:outline-none ${
              isCorrect
                ? 'border-green-500 bg-green-50'
                : isIncorrect
                ? 'border-red-500 bg-red-50'
                : 'border-gray-200 focus:border-brand bg-white'
            }`}
            autoFocus
          />
          {submitted && (
            <div className="absolute right-4 top-1/2 -translate-y-1/2">
              {isCorrect ? (
                <Check className="w-6 h-6 text-green-600" />
              ) : (
                <X className="w-6 h-6 text-red-600" />
              )}
            </div>
          )}
        </div>

        {!submitted ? (
          <motion.button
            type="submit"
            disabled={!answer.trim()}
            className="w-full py-4 bg-brand text-white font-semibold text-lg rounded-2xl disabled:opacity-50 disabled:cursor-not-allowed hover:bg-brand-dark transition-colors"
            whileHover={{ scale: answer.trim() ? 1.02 : 1 }}
            whileTap={{ scale: answer.trim() ? 0.98 : 1 }}
          >
            {t('quiz.checkAnswer')}
          </motion.button>
        ) : (
          <motion.button
            type="button"
            onClick={handleContinue}
            className="w-full py-4 bg-brand text-white font-semibold text-lg rounded-2xl hover:bg-brand-dark transition-colors"
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
          >
            {t('quiz.continue')}
          </motion.button>
        )}

        {isIncorrect && (
          <div className="text-center mt-3">
            <p className="text-red-700 font-medium">
              {t('quiz.correctAnswer')}: <span className="font-bold">{question.meta.answer as string}</span>
            </p>
          </div>
        )}
      </form>
    </motion.div>
  );
}
