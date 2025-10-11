# Relingo

Relingo is an interactive educational platform for learning about world religions through gamified lessons and quizzes. The application provides structured content about major world religions including Islam, Christianity, Hinduism, Buddhism, and Judaism, presented in an accessible and engaging format.

## Overview

The platform employs gamification mechanics similar to language learning applications, featuring experience points, achievement tracking, daily streaks, and progressive lesson unlocking. Users can learn at their own pace while maintaining motivation through game-like elements.

## Features

- Interactive learning path with progressive lesson unlocking
- Multiple question types: multiple choice, true/false, and fill-in-the-gap
- Gamification system with XP, hearts, stars, and daily streaks
- Multi-language support (English, Norwegian, Turkish)
- Progress tracking and statistics
- Custom profile pictures with camera and file picker support
- Responsive design optimized for mobile and desktop
- Daily quests and challenges

## Technology Stack

### Frontend
- React 19.1 with TypeScript 5.9
- Vite 7.1 for build tooling and development server
- TailwindCSS 3.4 for styling
- Framer Motion for animations
- React Router 7.9 for navigation

### State Management & Data Fetching
- TanStack Query (React Query) for server state management
- React Hook Form with Zod validation

### Backend & Infrastructure
- Supabase for authentication and database
- PostgreSQL with Row Level Security policies
- Supabase Storage for file uploads
- Real-time capabilities

### Internationalization
- i18next with react-i18next for multi-language support

## Project Structure

```
relingo/
├── src/
│   ├── app/              # Route components
│   ├── components/       # Shared UI components
│   ├── features/         # Feature-specific components
│   ├── hooks/            # Custom React hooks
│   ├── lib/              # Third-party integrations
│   ├── utils/            # Utility functions
│   ├── types/            # TypeScript type definitions
│   └── locales/          # Translation files
├── supabase/
│   └── migrations/       # Database schema and seed data
└── public/
    └── assets/           # Static assets
```

## Prerequisites

- Node.js 18 or higher
- npm or yarn package manager
- Supabase account (free tier available)

## Setup Instructions

### 1. Install Dependencies

```bash
npm install
```

### 2. Configure Supabase

1. Create a new project at supabase.com
2. Navigate to Authentication > Settings > Email Auth
3. Disable "Enable email confirmations" for development
4. Execute each migration file in the SQL Editor in sequential order:
   - `0001_init.sql`
   - `0002_norwegian_christianity_content.sql`
   - `0003_norwegian_islam_content.sql`
   - `0004_norwegian_judaism_content.sql`
   - `0005_add_more_intro_questions.sql`
   - `0006_norwegian_hinduism_content.sql`
   - `0007_add_test_user.sql`
   - `0008_norwegian_buddhism_content.sql`
   - `0009_setup_avatars_storage.sql`

### 3. Environment Configuration

Copy the example environment file and add your Supabase credentials:

```bash
cp env.example .env
```

Add your Supabase project URL and anonymous key to the `.env` file.

### 4. Development Server

```bash
npm run dev
```

The application will be available at http://localhost:5173

## Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run preview` - Preview production build
- `npm run lint` - Run ESLint
- `npm run lint:fix` - Fix ESLint issues
- `npm run test` - Run tests

## Database Schema

The application uses the following main tables:

- **religions** - Available religions
- **lessons** - Learning modules linked to religions
- **quizzes** - Assessment sets linked to lessons
- **questions** - Individual quiz items (MCQ, True/False, Fill-in-the-gap)
- **user_progress** - Per-user lesson completion tracking
- **user_stats** - XP, hearts, and streak tracking
- **streak_log** - Daily activity audit trail

All user data is protected by Row Level Security policies ensuring users can only access their own information.

## Storage

The application uses Supabase Storage for:

- **avatars** - User profile pictures
  - Public bucket with RLS policies
  - Users can upload, update, and delete their own images
  - Maximum file size: 5MB
  - Supported formats: JPG, PNG, GIF

See [PROFILE_IMAGE_SETUP.md](PROFILE_IMAGE_SETUP.md) for detailed setup instructions.

## Content Management

The application currently supports five major world religions with comprehensive lesson content in multiple languages. Content is structured into six main categories per religion:

1. Historical origins and background
2. Core beliefs and teachings
3. Practices and rituals
4. Holidays and celebrations
5. Sacred texts and symbols
6. Modern expressions and diversity

## Deployment

The application can be deployed to any static hosting service:

**Build Command:**
```bash
npm run build
```

**Output Directory:**
```
dist/
```

Recommended platforms: Vercel, Netlify, or similar static hosting services.

## Documentation

- [Test User Setup](SETUP_TEST_USER.md) - Guide for setting up test accounts
- [Buddhism Content](BUDDHISM_CONTENT_ADDED.md) - Details about Buddhism curriculum
- [Profile Images](PROFILE_IMAGE_SETUP.md) - Setup and usage guide for profile pictures

## License

MIT License - Free for educational and non-commercial use.

## Acknowledgments

Content is sourced from reputable educational institutions and encyclopedias. All religious content is presented with respect, accuracy, and cultural sensitivity. This is an educational tool designed for learning about world religions in a non-proselytizing manner.
