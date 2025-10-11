import { supabase } from '../lib/supabase';
import type { 
  Religion, 
  Lesson, 
  Quiz, 
  Question, 
  UserProgress, 
  UserStats 
} from '../types';
import { getUTCDateString, isToday } from '../utils/date';

// ============ Public Content ============

export async function getReligions(): Promise<Religion[]> {
  const { data, error } = await supabase
    .from('religions')
    .select('*')
    .order('slug');
  
  if (error) throw error;
  return data || [];
}

export async function getPublishedLessons(): Promise<Lesson[]> {
  const { data, error } = await supabase
    .from('lessons')
    .select(`
      *,
      religion:religions(*),
      user_progress(*)
    `)
    .eq('published', true)
    .order('order_index');
  
  if (error) throw error;
  
  // Flatten user_progress array to single object
  return (data || []).map(lesson => ({
    ...lesson,
    user_progress: lesson.user_progress?.[0] || null
  }));
}

export async function getLessonById(id: string): Promise<Lesson | null> {
  const { data, error } = await supabase
    .from('lessons')
    .select(`
      *,
      religion:religions(*),
      user_progress(*)
    `)
    .eq('id', id)
    .eq('published', true)
    .single();
  
  if (error) {
    if (error.code === 'PGRST116') return null;
    throw error;
  }
  
  return {
    ...data,
    user_progress: data.user_progress?.[0] || null
  };
}

export async function getQuizzesForLesson(lessonId: string): Promise<Quiz[]> {
  const { data, error } = await supabase
    .from('quizzes')
    .select('*')
    .eq('lesson_id', lessonId)
    .eq('published', true)
    .order('order_index');
  
  if (error) throw error;
  return data || [];
}

export async function getQuizById(id: string): Promise<Quiz | null> {
  const { data, error } = await supabase
    .from('quizzes')
    .select(`
      *,
      lesson:lessons(*)
    `)
    .eq('id', id)
    .eq('published', true)
    .single();
  
  if (error) {
    if (error.code === 'PGRST116') return null;
    throw error;
  }
  
  return data;
}

export async function getQuestions(quizId: string): Promise<Question[]> {
  const { data, error } = await supabase
    .from('questions')
    .select('*')
    .eq('quiz_id', quizId)
    .order('order_index');
  
  if (error) throw error;
  return data || [];
}

// ============ User Stats ============

export async function getUserStats(userId: string): Promise<UserStats | null> {
  const { data, error } = await supabase
    .from('user_stats')
    .select('*')
    .eq('user_id', userId)
    .single();
  
  if (error) {
    if (error.code === 'PGRST116') {
      // Create initial stats if they don't exist
      return await createUserStats(userId);
    }
    throw error;
  }
  
  return data;
}

export async function createUserStats(userId: string): Promise<UserStats> {
  const { data, error } = await supabase
    .from('user_stats')
    .insert({
      user_id: userId,
      xp: 0,
      hearts: 5,
      streak: 0,
      last_active_date: null
    })
    .select()
    .single();
  
  if (error) throw error;
  return data;
}

export async function updateUserStats(
  userId: string, 
  updates: Partial<Omit<UserStats, 'user_id'>>
): Promise<UserStats> {
  const { data, error } = await supabase
    .from('user_stats')
    .update(updates)
    .eq('user_id', userId)
    .select()
    .single();
  
  if (error) throw error;
  return data;
}

export async function updateStreak(userId: string): Promise<number> {
  // Get current stats
  const stats = await getUserStats(userId);
  if (!stats) throw new Error('User stats not found');
  
  const today = getUTCDateString();
  
  // Check if already logged today
  const { data: existingLog } = await supabase
    .from('streak_log')
    .select('*')
    .eq('user_id', userId)
    .eq('date', today)
    .single();
  
  if (existingLog) {
    return stats.streak;
  }
  
  // Insert today's log
  await supabase
    .from('streak_log')
    .insert({
      user_id: userId,
      date: today,
      delta: 1
    });
  
  // Calculate new streak
  let newStreak = 1;
  
  if (stats.last_active_date) {
    const lastDate = new Date(stats.last_active_date);
    const todayDate = new Date(today);
    const diffDays = Math.floor((todayDate.getTime() - lastDate.getTime()) / (1000 * 60 * 60 * 24));
    
    if (diffDays === 1) {
      // Consecutive day
      newStreak = stats.streak + 1;
    } else if (diffDays === 0) {
      // Same day
      newStreak = stats.streak;
    }
    // else: streak broken, reset to 1
  }
  
  // Update stats
  await updateUserStats(userId, {
    streak: newStreak,
    last_active_date: today
  });
  
  return newStreak;
}

export async function awardXP(userId: string, amount: number): Promise<number> {
  const stats = await getUserStats(userId);
  if (!stats) throw new Error('User stats not found');
  
  const newXP = stats.xp + amount;
  await updateUserStats(userId, { xp: newXP });
  
  return newXP;
}

export async function loseHeart(userId: string): Promise<number> {
  const stats = await getUserStats(userId);
  if (!stats) throw new Error('User stats not found');
  
  const newHearts = Math.max(0, stats.hearts - 1);
  await updateUserStats(userId, { hearts: newHearts });
  
  return newHearts;
}

export async function refillHearts(userId: string): Promise<number> {
  await updateUserStats(userId, { hearts: 5 });
  return 5;
}

// ============ User Progress ============

export async function getUserProgress(userId: string): Promise<UserProgress[]> {
  const { data, error } = await supabase
    .from('user_progress')
    .select('*')
    .eq('user_id', userId);
  
  if (error) throw error;
  return data || [];
}

export async function setProgress(params: {
  userId: string;
  lessonId: string;
  stars: number;
  score: number;
}): Promise<UserProgress> {
  const { userId, lessonId, stars, score } = params;
  
  // Check if progress exists
  const { data: existing } = await supabase
    .from('user_progress')
    .select('*')
    .eq('user_id', userId)
    .eq('lesson_id', lessonId)
    .single();
  
  if (existing) {
    // Update if new score is better
    const updates: any = {
      last_completed_at: new Date().toISOString()
    };
    
    if (score > existing.best_score) {
      updates.best_score = score;
    }
    
    if (stars > existing.stars) {
      updates.stars = stars;
    }
    
    const { data, error } = await supabase
      .from('user_progress')
      .update(updates)
      .eq('id', existing.id)
      .select()
      .single();
    
    if (error) throw error;
    return data;
  } else {
    // Create new progress
    const { data, error } = await supabase
      .from('user_progress')
      .insert({
        user_id: userId,
        lesson_id: lessonId,
        stars,
        best_score: score,
        last_completed_at: new Date().toISOString()
      })
      .select()
      .single();
    
    if (error) throw error;
    return data;
  }
}
