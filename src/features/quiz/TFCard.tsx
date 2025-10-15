import { useState } from 'react';
import { motion } from 'framer-motion';
import { Check, X } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import type { Question } from '../../types';

interface TFCardProps {
  question: Question;
  onAnswer: (isCorrect: boolean) => void;
}

export default function TFCard({ question, onAnswer }: TFCardProps) {
  const { t } = useTranslation();
  const [selected, setSelected] = useState<boolean | null>(null);
  const [answered, setAnswered] = useState(false);
  
  // Questions are now pre-translated in the database
  const translatedPrompt = question.prompt;
  
  const correctAnswer = question.meta.answer as boolean;

  const handleChoice = (choice: boolean) => {
    if (answered) return;
    
    setSelected(choice);
    setAnswered(true);
  };

  const handleContinue = () => {
    onAnswer(selected === correctAnswer);
  };

  const getButtonClass = (value: boolean) => {
    if (!answered) {
      return selected === value ? 'selected' : '';
    }
    
    if (value === correctAnswer) return 'correct';
    if (selected === value && value !== correctAnswer) return 'incorrect';
    return '';
  };

  return (
    <motion.div
      className="quiz-card max-w-2xl mx-auto"
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
    >
      {/* Prompt */}
      <h2 className="font-display text-2xl md:text-3xl font-bold text-gray-900 mb-8 text-center">
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

      {/* True/False Buttons */}
      <div className="grid grid-cols-2 gap-4 mb-6">
        <motion.button
          onClick={() => handleChoice(true)}
          disabled={answered}
          className={`choice-button py-8 text-lg font-semibold ${getButtonClass(true)}`}
          whileHover={!answered ? { scale: 1.02 } : undefined}
          whileTap={!answered ? { scale: 0.98 } : undefined}
        >
          <div className="flex flex-col items-center gap-2">
            {answered && correctAnswer === true && (
              <Check className="w-6 h-6 text-green-600" />
            )}
            {answered && selected === true && correctAnswer === false && (
              <X className="w-6 h-6 text-red-600" />
            )}
            <span>{t('quiz.true')}</span>
          </div>
        </motion.button>

        <motion.button
          onClick={() => handleChoice(false)}
          disabled={answered}
          className={`choice-button py-8 text-lg font-semibold ${getButtonClass(false)}`}
          whileHover={!answered ? { scale: 1.02 } : undefined}
          whileTap={!answered ? { scale: 0.98 } : undefined}
        >
          <div className="flex flex-col items-center gap-2">
            {answered && correctAnswer === false && (
              <Check className="w-6 h-6 text-green-600" />
            )}
            {answered && selected === false && correctAnswer === true && (
              <X className="w-6 h-6 text-red-600" />
            )}
            <span>{t('quiz.false')}</span>
          </div>
        </motion.button>
      </div>

      {/* Continue Button */}
      {answered && (
        <motion.button
          onClick={handleContinue}
          className="w-full py-4 bg-brand text-white font-semibold text-lg rounded-2xl hover:bg-brand-dark transition-colors"
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
        >
          {t('quiz.continue')}
        </motion.button>
      )}
    </motion.div>
  );
}
