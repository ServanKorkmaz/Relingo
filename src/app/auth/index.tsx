import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { useTranslation } from 'react-i18next';
import { supabase } from '../../lib/supabase';
import { motion, AnimatePresence } from 'framer-motion';
import LanguageSwitcher from '../../components/LanguageSwitcher';

export default function AuthScreen() {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const [isSignUp, setIsSignUp] = useState(false);
  const [showResetPassword, setShowResetPassword] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  const authSchema = z.object({
    email: z.string().email(t('auth.errors.invalidEmail')),
    password: z.string().min(6, t('auth.errors.passwordTooShort')),
  });

  const resetSchema = z.object({
    email: z.string().email(t('auth.errors.invalidEmail')),
  });

  type AuthForm = z.infer<typeof authSchema>;
  type ResetForm = z.infer<typeof resetSchema>;

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<AuthForm>({
    resolver: zodResolver(authSchema),
  });

  const {
    register: registerReset,
    handleSubmit: handleSubmitReset,
    formState: { errors: resetErrors },
    reset: resetForm,
  } = useForm<ResetForm>({
    resolver: zodResolver(resetSchema),
  });

  const onSubmit = async (data: AuthForm) => {
    setError(null);
    setSuccess(null);
    setLoading(true);

    try {
      if (isSignUp) {
        const { error: signUpError } = await supabase.auth.signUp({
          email: data.email,
          password: data.password,
          options: {
            emailRedirectTo: `${window.location.origin}/onboarding`,
            data: {
              // Additional user metadata if needed
            }
          },
        });

        if (signUpError) throw signUpError;

        // Navigate to onboarding page
        navigate('/onboarding');
      } else {
        const { error: signInError } = await supabase.auth.signInWithPassword({
          email: data.email,
          password: data.password,
        });

        if (signInError) throw signInError;

        // Navigate to app
        navigate('/app/learn');
      }
    } catch (err: any) {
      setError(err.message || t('auth.errors.general'));
    } finally {
      setLoading(false);
    }
  };

  const onResetPassword = async (data: ResetForm) => {
    setError(null);
    setSuccess(null);
    setLoading(true);

    try {
      const { error: resetError } = await supabase.auth.resetPasswordForEmail(
        data.email,
        {
          redirectTo: `${window.location.origin}/auth/update-password`,
        }
      );

      if (resetError) throw resetError;

      setSuccess(t('auth.resetPassword.success'));
      resetForm();
      
      // Close modal after 3 seconds
      setTimeout(() => {
        setShowResetPassword(false);
        setSuccess(null);
      }, 3000);
    } catch (err: any) {
      setError(err.message || 'Failed to send reset email');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-brand/10 via-white to-brand/5 px-4">
      <motion.div
        className="w-full max-w-md"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
      >
        {/* Logo */}
        <div className="text-center mb-8">
          <img
            src="/assets/logo.svg"
            alt="Relingo"
            className="w-32 h-32 mx-auto mb-4"
          />
          <h1 className="font-display text-4xl font-bold text-gray-900 mb-2">
            {t('app.name')}
          </h1>
          <p className="text-gray-600">
            {t('app.tagline')}
          </p>
          <div className="mt-4">
            <LanguageSwitcher />
          </div>
        </div>

        {/* Auth Form */}
        <div className="bg-white rounded-3xl shadow-xl p-8">
          <h2 className="text-2xl font-bold text-gray-900 mb-6 text-center">
            {isSignUp ? t('auth.signUp.title') : t('auth.signIn.title')}
          </h2>

          {error && (
            <div className="mb-4 p-3 bg-red-50 border border-red-200 rounded-xl text-red-700 text-sm">
              {error}
            </div>
          )}

          {success && (
            <div className="mb-4 p-3 bg-green-50 border border-green-200 rounded-xl text-green-700 text-sm">
              {success}
            </div>
          )}

          <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
            {/* Email */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                {t('auth.signIn.email')}
              </label>
              <input
                {...register('email')}
                type="email"
                className="w-full px-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-brand focus:border-transparent"
                placeholder="you@example.com"
              />
              {errors.email && (
                <p className="mt-1 text-sm text-red-600">{errors.email.message}</p>
              )}
            </div>

            {/* Password */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                {t('auth.signIn.password')}
              </label>
              <input
                {...register('password')}
                type="password"
                className="w-full px-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-brand focus:border-transparent"
                placeholder="••••••••"
              />
              {errors.password && (
                <p className="mt-1 text-sm text-red-600">
                  {errors.password.message}
                </p>
              )}
            </div>

            {/* Submit Button */}
            <button
              type="submit"
              disabled={loading}
              className="w-full py-4 bg-brand text-white font-semibold text-lg rounded-xl hover:bg-brand-dark transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {loading 
                ? t('auth.loading') 
                : isSignUp 
                  ? t('auth.signUp.button') 
                  : t('auth.signIn.button')
              }
            </button>
          </form>

          {/* Forgot Password Link */}
          {!isSignUp && (
            <div className="mt-4 text-center">
              <button
                onClick={() => {
                  setShowResetPassword(true);
                  setError(null);
                  setSuccess(null);
                }}
                className="text-sm text-gray-600 hover:text-brand transition-colors"
              >
                {t('auth.signIn.forgotPassword')}
              </button>
            </div>
          )}

          {/* Toggle */}
          <div className="mt-6 text-center">
            <button
              onClick={() => {
                setIsSignUp(!isSignUp);
                setError(null);
                setSuccess(null);
              }}
              className="text-brand hover:text-brand-dark font-medium transition-colors"
            >
              {isSignUp
                ? t('auth.signUp.switchToSignIn')
                : t('auth.signIn.switchToSignUp')}
            </button>
          </div>
        </div>

        {/* Reset Password Modal */}
        <AnimatePresence>
          {showResetPassword && (
            <motion.div
              className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              onClick={() => setShowResetPassword(false)}
            >
              <motion.div
                className="bg-white rounded-2xl p-6 max-w-md w-full"
                initial={{ scale: 0.9, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                exit={{ scale: 0.9, opacity: 0 }}
                onClick={(e) => e.stopPropagation()}
              >
                <h3 className="text-xl font-bold text-gray-900 mb-2">
                  {t('auth.resetPassword.title')}
                </h3>
                <p className="text-sm text-gray-600 mb-4">
                  {t('auth.resetPassword.description')}
                </p>

                {error && (
                  <div className="mb-4 p-3 bg-red-50 border border-red-200 rounded-xl text-red-700 text-sm">
                    {error}
                  </div>
                )}

                {success && (
                  <div className="mb-4 p-3 bg-green-50 border border-green-200 rounded-xl text-green-700 text-sm">
                    {success}
                  </div>
                )}

                <form onSubmit={handleSubmitReset(onResetPassword)} className="space-y-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      {t('auth.signIn.email')}
                    </label>
                    <input
                      {...registerReset('email')}
                      type="email"
                      className="w-full px-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-brand focus:border-transparent"
                      placeholder="you@example.com"
                      autoFocus
                    />
                    {resetErrors.email && (
                      <p className="mt-1 text-sm text-red-600">
                        {resetErrors.email.message}
                      </p>
                    )}
                  </div>

                  <div className="flex gap-3">
                    <button
                      type="button"
                      onClick={() => {
                        setShowResetPassword(false);
                        setError(null);
                        setSuccess(null);
                        resetForm();
                      }}
                      className="flex-1 py-3 border border-gray-300 text-gray-700 font-medium rounded-xl hover:bg-gray-50 transition-colors"
                    >
                      {t('auth.resetPassword.cancel')}
                    </button>
                    <button
                      type="submit"
                      disabled={loading}
                      className="flex-1 py-3 bg-brand text-white font-medium rounded-xl hover:bg-brand-dark transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                    >
                      {loading ? t('auth.resetPassword.sending') : t('auth.resetPassword.sendButton')}
                    </button>
                  </div>
                </form>
              </motion.div>
            </motion.div>
          )}
        </AnimatePresence>
      </motion.div>
    </div>
  );
}
