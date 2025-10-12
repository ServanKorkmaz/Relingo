-- Restore Hinduism Religion
-- This will add Hinduism back with the correct icon

-- Insert Hinduism (exactly like Islam and other religions)
INSERT INTO public.religions (slug, name, color, icon_url)
VALUES ('hinduism', 'Hinduism', '#F59E0B', '/assets/religions/hinduism.svg');

-- Verify it's back
SELECT slug, name, color, icon_url 
FROM public.religions 
ORDER BY slug;

