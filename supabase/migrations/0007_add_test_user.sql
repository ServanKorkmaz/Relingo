-- Add test user
-- Note: In production Supabase, you need to disable email confirmation from the dashboard:
-- Authentication > Settings > Enable email confirmations (turn OFF)

-- This migration assumes email confirmation is disabled
-- Test user credentials:
-- Email: test@relingo.com
-- Password: test123456

-- The actual user creation needs to be done via Supabase Auth API or dashboard
-- This is a placeholder to document the test user
-- You can create it via the Supabase dashboard or using the signUp function

-- Create a function to help with test user setup
CREATE OR REPLACE FUNCTION create_test_user_stats()
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  test_user_id uuid;
BEGIN
  -- Try to find the test user by email
  -- Note: This assumes you've already created the user via Supabase Auth
  SELECT id INTO test_user_id
  FROM auth.users
  WHERE email = 'test@relingo.com'
  LIMIT 1;

  -- If test user exists, create stats for them
  IF test_user_id IS NOT NULL THEN
    INSERT INTO public.user_stats (user_id, xp, hearts, streak, last_active_date)
    VALUES (test_user_id, 100, 5, 1, CURRENT_DATE)
    ON CONFLICT (user_id) DO NOTHING;

    -- Add some sample progress
    INSERT INTO public.user_progress (user_id, lesson_id, stars, best_score, last_completed_at)
    SELECT test_user_id, l.id, 3, 100, NOW()
    FROM public.lessons l
    WHERE l.slug = 'intro-islam'
    ON CONFLICT (user_id, lesson_id) DO NOTHING;
  END IF;
END;
$$;

-- Note: To create the test user, use the sign-up form in your app with:
-- Email: test@relingo.com
-- Password: test123456
-- 
-- Or use the Supabase dashboard to create the user manually


