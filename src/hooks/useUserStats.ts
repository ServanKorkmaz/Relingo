import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { supabase } from '../lib/supabase';
import { 
  getUserStats, 
  updateUserStats, 
  awardXP, 
  loseHeart, 
  refillHearts,
  updateStreak 
} from '../db/queries';
import type { UserStats } from '../types';

// Default guest stats
const GUEST_STATS: UserStats = {
  user_id: 'guest',
  xp: 0,
  hearts: 5,
  streak: 0,
  last_active_date: new Date().toISOString(),
};

export function useUserStats() {
  const queryClient = useQueryClient();
  
  const { data: user } = useQuery({
    queryKey: ['auth-user'],
    queryFn: async () => {
      const { data } = await supabase.auth.getUser();
      return data.user;
    },
  });

  const { data: stats, isLoading } = useQuery<UserStats | null>({
    queryKey: ['user-stats', user?.id || 'guest'],
    queryFn: () => user?.id ? getUserStats(user.id) : Promise.resolve(GUEST_STATS),
    enabled: true,
  });

  const updateStatsMutation = useMutation<UserStats, Error, Partial<Omit<UserStats, 'user_id'>>>({
    mutationFn: async (updates: Partial<Omit<UserStats, 'user_id'>>) => {
      if (user?.id) {
        return updateUserStats(user.id, updates);
      }
      return GUEST_STATS;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['user-stats', user?.id || 'guest'] });
    },
  });

  const awardXPMutation = useMutation<number, Error, number, { previous: UserStats | undefined }>({
    mutationFn: async (amount: number) => {
      if (user?.id) {
        return awardXP(user.id, amount);
      }
      return 0;
    },
    onMutate: async (amount) => {
      // Optimistic update
      const userId = user?.id || 'guest';
      await queryClient.cancelQueries({ queryKey: ['user-stats', userId] });
      const previous = queryClient.getQueryData<UserStats>(['user-stats', userId]);
      
      if (previous) {
        queryClient.setQueryData<UserStats>(['user-stats', userId], {
          ...previous,
          xp: previous.xp + amount,
        });
      }
      
      return { previous };
    },
    onError: (_err, _variables, context) => {
      const userId = user?.id || 'guest';
      if (context?.previous) {
        queryClient.setQueryData(['user-stats', userId], context.previous);
      }
    },
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: ['user-stats', user?.id || 'guest'] });
    },
  });

  const loseHeartMutation = useMutation<number, Error, void, { previous: UserStats | undefined }>({
    mutationFn: async () => {
      if (user?.id) {
        return loseHeart(user.id);
      }
      return 0;
    },
    onMutate: async () => {
      const userId = user?.id || 'guest';
      await queryClient.cancelQueries({ queryKey: ['user-stats', userId] });
      const previous = queryClient.getQueryData<UserStats>(['user-stats', userId]);
      
      if (previous) {
        queryClient.setQueryData<UserStats>(['user-stats', userId], {
          ...previous,
          hearts: Math.max(0, previous.hearts - 1),
        });
      }
      
      return { previous };
    },
    onError: (_err, _variables, context) => {
      const userId = user?.id || 'guest';
      if (context?.previous) {
        queryClient.setQueryData(['user-stats', userId], context.previous);
      }
    },
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: ['user-stats', user?.id || 'guest'] });
    },
  });

  const refillHeartsMutation = useMutation<number, Error, void>({
    mutationFn: async () => {
      if (user?.id) {
        return refillHearts(user.id);
      }
      return 0;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['user-stats', user?.id || 'guest'] });
    },
  });

  const updateStreakMutation = useMutation<number, Error, void>({
    mutationFn: async () => {
      if (user?.id) {
        return updateStreak(user.id);
      }
      return 0;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['user-stats', user?.id || 'guest'] });
    },
  });

  return {
    stats,
    isLoading,
    updateStats: updateStatsMutation.mutate,
    awardXP: awardXPMutation.mutate,
    loseHeart: loseHeartMutation.mutate,
    refillHearts: refillHeartsMutation.mutate,
    updateStreak: updateStreakMutation.mutate,
  };
}
