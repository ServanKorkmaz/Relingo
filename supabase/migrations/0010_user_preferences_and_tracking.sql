-- User Preferences and Activity Tracking Migration
-- Adds tables for storing user settings, daily XP tracking, and enhanced functionality

-- User Preferences Table
CREATE TABLE IF NOT EXISTS public.user_preferences (
  user_id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  notifications_enabled boolean DEFAULT true,
  email_notifications boolean DEFAULT true,
  sound_effects boolean DEFAULT true,
  dark_mode boolean DEFAULT false,
  language varchar(5) DEFAULT 'no',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Daily XP Log (for progress chart)
CREATE TABLE IF NOT EXISTS public.daily_xp_log (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  date date NOT NULL,
  xp_earned integer NOT NULL DEFAULT 0,
  lessons_completed integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, date)
);

-- User Achievements (for tracking milestones)
CREATE TABLE IF NOT EXISTS public.user_achievements (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  achievement_type varchar(50) NOT NULL,
  achievement_value integer NOT NULL,
  earned_at timestamptz DEFAULT now(),
  metadata jsonb DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE public.user_preferences ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.daily_xp_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_achievements ENABLE ROW LEVEL SECURITY;

-- RLS Policies for user_preferences
CREATE POLICY "Users can view own preferences"
  ON public.user_preferences
  FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can update own preferences"
  ON public.user_preferences
  FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can insert own preferences"
  ON public.user_preferences
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- RLS Policies for daily_xp_log
CREATE POLICY "Users can view own xp log"
  ON public.daily_xp_log
  FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own xp log"
  ON public.daily_xp_log
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own xp log"
  ON public.daily_xp_log
  FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- RLS Policies for user_achievements
CREATE POLICY "Users can view own achievements"
  ON public.user_achievements
  FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own achievements"
  ON public.user_achievements
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Function to automatically create user preferences on signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.user_stats (user_id, xp, hearts, streak, last_active_date)
  VALUES (NEW.id, 0, 5, 0, NULL)
  ON CONFLICT (user_id) DO NOTHING;
  
  INSERT INTO public.user_preferences (user_id)
  VALUES (NEW.id)
  ON CONFLICT (user_id) DO NOTHING;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger on new user creation
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- Function to update daily XP log
CREATE OR REPLACE FUNCTION public.log_daily_xp(
  p_user_id uuid,
  p_xp_earned integer,
  p_lessons_completed integer DEFAULT 1
)
RETURNS void AS $$
BEGIN
  INSERT INTO public.daily_xp_log (user_id, date, xp_earned, lessons_completed)
  VALUES (p_user_id, CURRENT_DATE, p_xp_earned, p_lessons_completed)
  ON CONFLICT (user_id, date)
  DO UPDATE SET
    xp_earned = daily_xp_log.xp_earned + EXCLUDED.xp_earned,
    lessons_completed = daily_xp_log.lessons_completed + EXCLUDED.lessons_completed;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_daily_xp_log_user_date ON public.daily_xp_log(user_id, date DESC);
CREATE INDEX IF NOT EXISTS idx_user_achievements_user ON public.user_achievements(user_id, earned_at DESC);
CREATE INDEX IF NOT EXISTS idx_streak_log_user_date ON public.streak_log(user_id, date DESC);

-- Add some comment documentation
COMMENT ON TABLE public.user_preferences IS 'Stores user app preferences and settings';
COMMENT ON TABLE public.daily_xp_log IS 'Tracks daily XP earnings for progress charts';
COMMENT ON TABLE public.user_achievements IS 'Records user achievements and milestones';

