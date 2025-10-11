import { useParams, useNavigate } from 'react-router-dom';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { getQuizById } from '../../db/queries';
import { setProgress } from '../../db/queries';
import { useUserStats } from '../../hooks/useUserStats';
import QuizPlayer from '../../features/quiz/QuizPlayer';
import { supabase } from '../../lib/supabase';

export default function QuizScreen() {
  const { quizId } = useParams<{ quizId: string }>();
  const navigate = useNavigate();
  const queryClient = useQueryClient();
  const { awardXP, updateStreak } = useUserStats();

  const { data: user } = useQuery({
    queryKey: ['auth-user'],
    queryFn: async () => {
      const { data } = await supabase.auth.getUser();
      return data.user;
    },
  });

  const { data: quiz, isLoading } = useQuery({
    queryKey: ['quiz', quizId],
    queryFn: () => getQuizById(quizId!),
    enabled: !!quizId,
  });

  const completeQuizMutation = useMutation({
    mutationFn: async ({
      score,
      perfect,
    }: {
      score: number;
      totalQuestions: number;
      perfect: boolean;
    }) => {
      if (!user?.id || !quiz?.lesson_id) return;

      // Calculate stars (0-3)
      const stars = perfect ? 3 : score >= 80 ? 2 : score >= 60 ? 1 : 0;

      // Save progress
      await setProgress({
        userId: user.id,
        lessonId: quiz.lesson_id,
        stars,
        score,
      });

      // Award XP
      const baseXP = 10;
      const bonusXP = perfect ? 5 : 0;
      awardXP(baseXP + bonusXP);

      // Update streak
      updateStreak();
    },
    onSuccess: () => {
      // Invalidate relevant queries
      queryClient.invalidateQueries({ queryKey: ['published-lessons'] });
      queryClient.invalidateQueries({ queryKey: ['lesson'] });
      queryClient.invalidateQueries({ queryKey: ['user-progress'] });
    },
  });

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand"></div>
      </div>
    );
  }

  if (!quiz) {
    return (
      <div className="flex flex-col items-center justify-center min-h-screen px-4">
        <p className="text-xl text-gray-600 mb-4">Quiz not found</p>
        <button
          onClick={() => navigate('/app/learn')}
          className="text-brand hover:text-brand-dark font-medium"
        >
          Back to Learn
        </button>
      </div>
    );
  }

  return (
    <QuizPlayer
      quizId={quiz.id}
      lessonId={quiz.lesson_id}
      onComplete={(result) => completeQuizMutation.mutate(result)}
    />
  );
}
