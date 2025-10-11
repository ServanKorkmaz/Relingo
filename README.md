# Relingo 🌍

A Duolingo-style app for learning about world religions with respect, curiosity, and cultural sensitivity.

![Relingo Logo](public/assets/logo.svg)

## ✨ Features

- **Interactive Learning Path**: Progress through lessons with a visual map interface
- **Multiple Question Types**: MCQ, True/False, and Fill-in-the-Gap questions
- **Gamification**: Earn XP, maintain streaks, collect stars, and manage hearts
- **Daily Quests**: Complete challenges to earn bonus rewards
- **Multi-Religion Support**: Learn about Islam, Christianity, Hinduism, Buddhism, Judaism, and more
- **Progress Tracking**: Monitor your learning journey with detailed stats
- **Responsive Design**: Beautiful mobile-first UI with smooth animations

## 🚀 Tech Stack

- **Frontend**: React 19, TypeScript, Vite
- **Styling**: TailwindCSS, Framer Motion
- **State Management**: TanStack Query, React Hook Form
- **Backend**: Supabase (Auth, Postgres, Row Level Security)
- **Validation**: Zod
- **Icons**: Lucide React

## 📋 Prerequisites

- Node.js 18+ and npm
- A Supabase account ([sign up free](https://supabase.com))

## 🛠️ Setup Instructions

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd relingo
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Set Up Supabase

1. Create a new project at [supabase.com](https://supabase.com)
2. **Disable Email Confirmation** (for development):
   - Go to **Authentication** → **Settings** → **Email Auth**
   - Turn OFF "Enable email confirmations"
   - Click **Save**
3. Go to **SQL Editor** in your Supabase dashboard
4. Copy and paste the contents of each migration file in order:
   - `supabase/migrations/0001_init.sql`
   - `supabase/migrations/0002_norwegian_christianity_content.sql`
   - `supabase/migrations/0003_norwegian_islam_content.sql`
   - `supabase/migrations/0004_norwegian_judaism_content.sql`
   - `supabase/migrations/0005_add_more_intro_questions.sql`
   - `supabase/migrations/0006_norwegian_hinduism_content.sql`
   - `supabase/migrations/0007_add_test_user.sql`
   - `supabase/migrations/0008_norwegian_buddhism_content.sql`
5. Run each migration (this creates tables, RLS policies, and seed data)

### 4. Configure Environment Variables

1. Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```

2. Fill in your Supabase credentials:
   - `VITE_SUPABASE_URL`: Found in Project Settings → API
   - `VITE_SUPABASE_ANON_KEY`: Found in Project Settings → API → anon/public key

### 5. Create Test User (Optional)

For quick testing, you can create a test user:

**Test Credentials:**
- Email: `test@relingo.com`
- Password: `test123456`

Simply use the sign-up form with these credentials. See [SETUP_TEST_USER.md](SETUP_TEST_USER.md) for more details.

### 6. Run the Development Server

```bash
npm run dev
```

The app will be available at `http://localhost:5173`

## 📁 Project Structure

```
relingo/
├── public/
│   └── assets/               # Static assets (SVGs, images)
│       ├── avatars/          # User avatar placeholders
│       ├── lessons/          # Lesson thumbnails
│       ├── religions/        # Religion icons
│       └── logo.svg
├── src/
│   ├── app/                  # Route/page components
│   │   ├── auth/             # Authentication
│   │   ├── learn/            # Main learning path
│   │   ├── lesson/           # Lesson detail
│   │   ├── quiz/             # Quiz player
│   │   ├── quests/           # Daily quests
│   │   ├── profile/          # User profile
│   │   └── onboarding/       # First-time user flow
│   ├── components/           # Shared UI components
│   │   ├── TopBar.tsx
│   │   └── BottomTabs.tsx
│   ├── features/             # Feature-specific components
│   │   ├── learn/            # Lesson map components
│   │   └── quiz/             # Quiz card components
│   ├── db/                   # Database queries
│   │   └── queries.ts
│   ├── hooks/                # Custom React hooks
│   │   └── useUserStats.ts
│   ├── lib/                  # Third-party integrations
│   │   └── supabase.ts
│   ├── types/                # TypeScript type definitions
│   │   └── index.ts
│   └── utils/                # Helper functions
│       ├── cn.ts             # Class name utility
│       ├── colors.ts         # Religion color mapping
│       └── date.ts           # Date utilities
├── supabase/
│   └── migrations/
│       └── 0001_init.sql     # Database schema + seeds
└── package.json
```

## 🎮 How to Use

### First Time Setup

1. **Sign Up**: Create an account with email/password
2. **Onboarding**: Choose a religion to start with (or explore all)
3. **Learn**: Navigate the lesson map and tap unlocked lessons
4. **Quiz**: Answer questions to earn stars and XP
5. **Progress**: Complete lessons to unlock new content

### Game Mechanics

- **Hearts (❤️)**: Start with 5 hearts. Lose 1 for each wrong answer. Refill daily.
- **XP (⚡)**: Earn 10 XP per quiz (+5 bonus for perfect score)
- **Stars (⭐)**: Earn 1-3 stars based on quiz performance
  - 3 stars: 100% (perfect)
  - 2 stars: 80%+
  - 1 star: 60%+
- **Streak (🔥)**: Maintain daily activity to build your streak

### Navigation

- **Learn Tab**: Browse and start lessons
- **Quests Tab**: View daily challenges and track progress
- **Profile Tab**: See your stats and manage your account

## 🗄️ Database Schema

### Tables

- `religions`: Available religions to learn about
- `lessons`: Learning modules (linked to religions)
- `quizzes`: Assessment sets (linked to lessons)
- `questions`: Individual quiz items (MCQ, True/False, Fill-gap)
- `user_progress`: Per-user lesson completion data
- `user_stats`: XP, hearts, streak tracking
- `streak_log`: Daily activity audit log

### Row Level Security (RLS)

- Public content (religions, lessons, quizzes, questions) is readable by all
- User data (progress, stats, streak logs) is only accessible by the owner
- All policies enforced at the database level

## 🎨 Design Principles

- **Respectful**: Neutral, educational content with no proselytizing
- **Accessible**: High contrast, keyboard navigation, ARIA labels
- **Mobile-First**: Optimized for touch interfaces
- **Performant**: Lazy loading, optimistic updates, query caching

## 🧪 Development Commands

```bash
# Start dev server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Run linter
npm run lint

# Fix linting issues
npm run lint:fix

# Run tests (optional)
npm run test
```

## 📝 Adding New Content

### Add a New Religion

```sql
INSERT INTO public.religions (slug, name, color, icon_url)
VALUES ('buddhism', 'Buddhism', '#EF4444', '/assets/religions/buddhism.svg');
```

### Add a New Lesson

```sql
INSERT INTO public.lessons (
  religion_id,
  slug,
  title,
  description,
  difficulty,
  thumbnail_url,
  order_index,
  published
)
SELECT 
  id,
  'intro-buddhism',
  'Introduction to Buddhism',
  'Core concepts and practices',
  1,
  '/assets/lessons/buddhism_intro.svg',
  0,
  true
FROM public.religions
WHERE slug = 'buddhism';
```

### Add Quiz Questions

See `supabase/migrations/0001_init.sql` for examples of MCQ, True/False, and Fill-in-the-Gap questions.

## 🌐 Deployment

### Vercel / Netlify

1. Connect your Git repository
2. Set environment variables (from `.env`)
3. Deploy!

### Build Command
```bash
npm run build
```

### Output Directory
```
dist/
```

## 🤝 Contributing

This is an MVP. Potential improvements:

- [ ] Audio pronunciations for religious terms
- [ ] More question types (matching, sorting)
- [ ] Leaderboards and social features
- [ ] Offline support (PWA)
- [ ] Multilingual content (i18n)
- [ ] Admin dashboard for content management
- [ ] Advanced analytics

## 📄 License

MIT License - feel free to use this project for learning and educational purposes.

## 🙏 Credits

- Built with respect for all faith traditions
- Icons and illustrations are simplified placeholders
- Content should be reviewed by religious scholars for accuracy

---

**Made with ❤️ for curious minds everywhere**
