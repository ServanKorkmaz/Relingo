import { useState } from 'react';
import { motion } from 'framer-motion';
import { Check, X } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import type { Question } from '../../types';

interface MCQCardProps {
  question: Question;
  onAnswer: (isCorrect: boolean) => void;
}

export default function MCQCard({ question, onAnswer }: MCQCardProps) {
  const { t } = useTranslation();
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [answered, setAnswered] = useState(false);
  const [isCorrect, setIsCorrect] = useState(false);
  
  // Questions are now pre-translated in the database, no need for useTranslate
  const translatedPrompt = question.prompt;
  const choices = question.meta.choices || [];

  const handleChoice = (choice: { id: string; correct?: boolean }) => {
    if (answered) return;
    
    setSelectedId(choice.id);
    setAnswered(true);
    setIsCorrect(!!choice.correct);
  };

  const handleContinue = () => {
    onAnswer(isCorrect);
  };

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

      {/* Choices */}
      <div className="grid gap-3 mb-6">
        {choices.map((choice) => {
          const isSelected = selectedId === choice.id;
          const showCorrect = answered && choice.correct;
          const showIncorrect = answered && isSelected && !choice.correct;

          return (
            <motion.button
              key={choice.id}
              onClick={() => handleChoice(choice)}
              disabled={answered}
              className={`choice-button ${
                isSelected && !answered ? 'selected' : ''
              } ${showCorrect ? 'correct' : ''} ${
                showIncorrect ? 'incorrect' : ''
              }`}
              whileHover={!answered ? { scale: 1.02 } : undefined}
              whileTap={!answered ? { scale: 0.98 } : undefined}
            >
              <div className="flex items-center justify-between">
                <span className="text-base">{choice.text}</span>
                {showCorrect && <Check className="w-5 h-5 text-green-600" />}
                {showIncorrect && <X className="w-5 h-5 text-red-600" />}
              </div>
            </motion.button>
          );
        })}
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
