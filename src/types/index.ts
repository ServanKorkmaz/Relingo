export interface Religion {
  id: string;
  slug: string;
  name: string;
  color: string;
  icon_url?: string;
  created_at: string;
}

export interface Lesson {
  id: string;
  religion_id: string;
  slug: string;
  title: string;
  title_key?: string;
  description?: string;
  description_key?: string;
  difficulty: number;
  thumbnail_url?: string;
  order_index: number;
  published: boolean;
  created_at: string;
  religion?: Religion;
  user_progress?: UserProgress;
}

export interface Quiz {
  id: string;
  lesson_id: string;
  title: string;
  order_index: number;
  published: boolean;
  created_at: string;
  lesson?: Lesson;
}

export interface Question {
  id: string;
  quiz_id: string;
  type: 'mcq' | 'tf' | 'gap' | 'match';
  prompt: string;
  media_url?: string;
  order_index: number;
  meta: {
    choices?: Array<{
      id: string;
      text: string;
      correct?: boolean;
    }>;
    answer?: boolean | string;
    matches?: Array<{
      id: string;
      left: string;
      right: string;
    }>;
    gaps?: Array<{
      id: string;
      text: string;
      answer: string;
    }>;
  };
  created_at: string;
}

export interface UserProgress {
  id: string;
  user_id: string;
  lesson_id: string;
  stars: number;
  best_score: number;
  last_completed_at?: string;
  created_at: string;
}

export interface UserStats {
  user_id: string;
  xp: number;
  hearts: number;
  streak: number;
  last_active_date?: string;
}

export interface StreakLog {
  id: string;
  user_id: string;
  date: string;
  delta: number;
}

export interface QuizAnswer {
  questionId: string;
  answer: string | boolean;
  isCorrect: boolean;
}

export interface QuizResult {
  score: number;
  totalQuestions: number;
  xpEarned: number;
  heartsLost: number;
  perfect: boolean;
}
