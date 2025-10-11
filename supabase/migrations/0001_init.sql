-- religions (public read)
create table public.religions (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  name text not null,
  color text not null,
  icon_url text,
  created_at timestamptz default now()
);

-- lessons (public read if published)
create table public.lessons (
  id uuid primary key default gen_random_uuid(),
  religion_id uuid references public.religions(id) on delete cascade,
  slug text unique not null,
  title text not null,
  description text,
  difficulty int not null default 1,
  thumbnail_url text,
  order_index int not null default 0,
  published boolean not null default false,
  created_at timestamptz default now()
);

-- quizzes (public read if published + references lessons)
create table public.quizzes (
  id uuid primary key default gen_random_uuid(),
  lesson_id uuid references public.lessons(id) on delete cascade,
  title text not null,
  order_index int not null default 0,
  published boolean not null default false,
  created_at timestamptz default now()
);

-- questions (MCQ, True/False, match, fill-the-gap)
create table public.questions (
  id uuid primary key default gen_random_uuid(),
  quiz_id uuid references public.quizzes(id) on delete cascade,
  type text not null check (type in ('mcq','tf','match','gap')),
  prompt text not null,
  media_url text,
  order_index int not null default 0,
  meta jsonb not null default '{}'::jsonb, -- choices, matches, gaps
  created_at timestamptz default now()
);

-- user_progress (per user)
create table public.user_progress (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  lesson_id uuid references public.lessons(id) on delete cascade,
  stars int not null default 0,
  best_score int not null default 0,
  last_completed_at timestamptz,
  created_at timestamptz default now(),
  unique(user_id, lesson_id)
);

-- user_stats (hearts, xp, streak, last_login)
create table public.user_stats (
  user_id uuid primary key references auth.users(id) on delete cascade,
  xp int not null default 0,
  hearts int not null default 5,          -- max 5
  streak int not null default 0,
  last_active_date date
);

-- streak_log (for audit)
create table public.streak_log (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  date date not null,
  delta int not null default 1,
  unique(user_id, date)
);

-- Enable RLS
alter table public.religions enable row level security;
alter table public.lessons enable row level security;
alter table public.quizzes enable row level security;
alter table public.questions enable row level security;
alter table public.user_progress enable row level security;
alter table public.user_stats enable row level security;
alter table public.streak_log enable row level security;

-- Public read for published content
create policy "public_read_religions" on public.religions
  for select using (true);

create policy "public_read_lessons" on public.lessons
  for select using (published = true);

create policy "public_read_quizzes" on public.quizzes
  for select using (published = true);

create policy "public_read_questions" on public.questions
  for select using (
    exists (
      select 1 from public.quizzes q
      join public.lessons l on l.id = q.lesson_id
      where q.id = questions.quiz_id and q.published = true and l.published = true
    )
  );

-- User-owned data
create policy "own_progress_rw" on public.user_progress
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own_stats_rw" on public.user_stats
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own_streak_log_rw" on public.streak_log
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Seed data
insert into public.religions (slug,name,color,icon_url) values
('islam','Islam','#0EA5E9','/assets/religions/islam.svg'),
('christianity','Christianity','#8B5CF6','/assets/religions/christianity.svg'),
('hinduism','Hinduism','#F59E0B','/assets/religions/hinduism.svg');

-- Example lesson per religion
insert into public.lessons (religion_id,slug,title,description,difficulty,thumbnail_url,order_index,published)
select id,'intro-islam','Introduction to Islam','Core terms and practices',1,'/assets/lessons/islam_intro.svg',0,true
from public.religions where slug='islam';

insert into public.lessons (religion_id,slug,title,description,difficulty,thumbnail_url,order_index,published)
select id,'intro-christianity','Introduction to Christianity','Core terms and practices',1,'/assets/lessons/christianity_intro.svg',0,true
from public.religions where slug='christianity';

insert into public.lessons (religion_id,slug,title,description,difficulty,thumbnail_url,order_index,published)
select id,'intro-hinduism','Introduction to Hinduism','Core terms and practices',1,'/assets/lessons/hinduism_intro.svg',0,true
from public.religions where slug='hinduism';

-- Quizzes and questions (one quiz each)
insert into public.quizzes (lesson_id,title,order_index,published)
select l.id,'Basics A',0,true from public.lessons l;

-- Example MCQ (Islam)
insert into public.questions (quiz_id,type,prompt,order_index,meta)
select q.id,'mcq','What does "Allah" mean?',0,
'{"choices":[
 {"id":"a","text":"The Prophet"},
 {"id":"b","text":"God","correct":true},
 {"id":"c","text":"Prayer time"}]}'::jsonb
from public.quizzes q
join public.lessons l on l.id=q.lesson_id
join public.religions r on r.id=l.religion_id and r.slug='islam'
limit 1;

-- Example TF (Christianity)
insert into public.questions (quiz_id,type,prompt,order_index,meta)
select q.id,'tf','The New Testament is part of the Christian Bible.',1,'{"answer": true}'::jsonb
from public.quizzes q join public.lessons l on l.id=q.lesson_id
join public.religions r on r.id=l.religion_id and r.slug='christianity'
limit 1;

-- Example gap (Hinduism)
insert into public.questions (quiz_id,type,prompt,order_index,meta)
select q.id,'gap','In Hinduism, "___" refers to duty/ethical responsibility.',2,'{"answer":"dharma"}'::jsonb
from public.quizzes q join public.lessons l on l.id=q.lesson_id
join public.religions r on r.id=l.religion_id and r.slug='hinduism'
limit 1;
