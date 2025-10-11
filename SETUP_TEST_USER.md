# Test User Setup Guide

## Disabling Email Verification

To disable email verification in Supabase:

1. Go to your Supabase project dashboard
2. Navigate to **Authentication** → **Settings**
3. Find the **Email Auth** section
4. **Disable** the option "Enable email confirmations"
5. Click **Save**

Alternatively, you can configure it via Supabase CLI:
```bash
supabase config set auth.enable_signup true
supabase config set auth.enable_email_confirmations false
```

## Test User Credentials

A test user has been configured for easy testing:

- **Email:** `test@relingo.com`
- **Password:** `test123456`

## Creating the Test User

### Option 1: Via Application UI (Recommended)
1. Start your development server
2. Go to the sign-up page
3. Enter the test credentials above
4. Sign up - you should be redirected to onboarding immediately

### Option 2: Via Supabase Dashboard
1. Go to **Authentication** → **Users**
2. Click **Add user** → **Create new user**
3. Enter:
   - Email: `test@relingo.com`
   - Password: `test123456`
   - Auto Confirm User: **YES** (check this box)
4. Click **Create user**

### Option 3: Via SQL (Advanced)
Run this in your Supabase SQL Editor after creating the user:
```sql
-- After the user is created via auth, run this to initialize their stats
SELECT create_test_user_stats();
```

## Verify Setup

1. Sign in with the test user credentials
2. You should see:
   - 100 XP
   - 5 hearts
   - 1 day streak
   - One completed lesson (Introduction to Islam)

## Additional Test Users

To create more test users, simply use the sign-up form with any email and password. The email verification has been disabled, so all new users will be auto-confirmed.

## Production Considerations

⚠️ **Important:** Before deploying to production:
1. Re-enable email confirmation in Supabase
2. Remove or disable test user accounts
3. Update the auth flow if needed


