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
    queryKey: ['user-stats', user?.id],
    queryFn: () => user?.id ? getUserStats(user.id) : Promise.resolve(null),
    enabled: !!user?.id,
  });

  const updateStatsMutation = useMutation({
    mutationFn: (updates: Partial<Omit<UserStats, 'user_id'>>) => 
      updateUserStats(user!.id, updates),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['user-stats', user?.id] });
    },
  });

  const awardXPMutation = useMutation({
    mutationFn: (amount: number) => awardXP(user!.id, amount),
    onMutate: async (amount) => {
      // Optimistic update
      await queryClient.cancelQueries({ queryKey: ['user-stats', user?.id] });
      const previous = queryClient.getQueryData<UserStats>(['user-stats', user?.id]);
      
      if (previous) {
        queryClient.setQueryData<UserStats>(['user-stats', user?.id], {
          ...previous,
          xp: previous.xp + amount,
        });
      }
      
      return { previous };
    },
    onError: (_err, _variables, context) => {
      if (context?.previous) {
        queryClient.setQueryData(['user-stats', user?.id], context.previous);
      }
    },
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: ['user-stats', user?.id] });
    },
  });

  const loseHeartMutation = useMutation({
    mutationFn: () => loseHeart(user!.id),
    onMutate: async () => {
      await queryClient.cancelQueries({ queryKey: ['user-stats', user?.id] });
      const previous = queryClient.getQueryData<UserStats>(['user-stats', user?.id]);
      
      if (previous) {
        queryClient.setQueryData<UserStats>(['user-stats', user?.id], {
          ...previous,
          hearts: Math.max(0, previous.hearts - 1),
        });
      }
      
      return { previous };
    },
    onError: (_err, _variables, context) => {
      if (context?.previous) {
        queryClient.setQueryData(['user-stats', user?.id], context.previous);
      }
    },
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: ['user-stats', user?.id] });
    },
  });

  const refillHeartsMutation = useMutation({
    mutationFn: () => refillHearts(user!.id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['user-stats', user?.id] });
    },
  });

  const updateStreakMutation = useMutation({
    mutationFn: () => updateStreak(user!.id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['user-stats', user?.id] });
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
