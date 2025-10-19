-- Delete all content: questions, quizzes, lessons, and user progress
-- This is a clean slate migration

-- Delete all questions (this will cascade to related data)
DELETE FROM public.questions;

-- Delete all quizzes
DELETE FROM public.quizzes;

-- Delete all user progress
DELETE FROM public.user_progress;

-- Delete all lessons
DELETE FROM public.lessons;

-- Optionally, you can also delete all religions if you want to start completely fresh
-- Uncomment the line below if you want to delete religions too:
-- DELETE FROM public.religions;

