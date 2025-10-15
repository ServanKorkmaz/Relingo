-- Add multilingual support to questions table
-- This allows storing translations directly in the database instead of using Google Translate API

-- Add columns for English and Turkish translations
ALTER TABLE public.questions 
ADD COLUMN prompt_en TEXT,
ADD COLUMN prompt_tr TEXT,
ADD COLUMN meta_en JSONB,
ADD COLUMN meta_tr JSONB;

-- Add comments for documentation
COMMENT ON COLUMN public.questions.prompt IS 'Question prompt in Norwegian (default/source language)';
COMMENT ON COLUMN public.questions.prompt_en IS 'Question prompt in English';
COMMENT ON COLUMN public.questions.prompt_tr IS 'Question prompt in Turkish';
COMMENT ON COLUMN public.questions.meta IS 'Question metadata (choices, answer) in Norwegian';
COMMENT ON COLUMN public.questions.meta_en IS 'Question metadata (choices, answer) in English';
COMMENT ON COLUMN public.questions.meta_tr IS 'Question metadata (choices, answer) in Turkish';

