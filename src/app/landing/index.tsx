import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { BookOpen, Users, Award, Sparkles, ArrowRight, CheckCircle } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import LanguageSwitcher from '../../components/LanguageSwitcher';

export default function LandingPage() {
  const navigate = useNavigate();
  const { t } = useTranslation();

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-purple-50">
      {/* Header */}
      <header className="sticky top-0 z-50 bg-white/80 backdrop-blur border-b">
        <div className="max-w-7xl mx-auto px-4 py-4 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <img src="/assets/logo.svg" alt={t('app.name')} className="w-12 h-12" />
            <span className="font-display font-bold text-2xl text-brand">{t('app.name')}</span>
          </div>
          <div className="flex items-center gap-3">
            <LanguageSwitcher />
            <button
              onClick={() => navigate('/app/learn')}
              className="px-6 py-3 bg-brand text-white font-bold rounded-2xl hover:bg-brand-dark transition-all hover:scale-105 active:scale-95"
            >
              {t('landing.hero.cta')}
            </button>
          </div>
        </div>
      </header>

      {/* Hero Section */}
      <section className="max-w-7xl mx-auto px-4 py-16 md:py-24">
        <div className="grid md:grid-cols-2 gap-12 items-center">
          <motion.div
            initial={{ opacity: 0, x: -50 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.6 }}
          >
            <h1 className="font-display text-5xl md:text-6xl font-bold text-gray-900 mb-6 leading-tight">
              {t('landing.hero.title')}
            </h1>
            <p className="text-xl text-gray-600 mb-8 leading-relaxed">
              {t('landing.hero.description')}
            </p>
            <button
              onClick={() => navigate('/app/learn')}
              className="px-8 py-4 bg-brand text-white font-bold text-lg rounded-2xl hover:bg-brand-dark transition-all hover:scale-105 active:scale-95 shadow-lg flex items-center gap-2"
            >
              {t('landing.hero.cta')}
              <ArrowRight className="w-5 h-5" />
            </button>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, x: 50 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.6, delay: 0.2 }}
            className="relative"
          >
            {/* Illustration placeholder */}
            <div className="relative">
              <div className="w-full aspect-square bg-gradient-to-br from-brand/20 to-purple-200 rounded-3xl flex items-center justify-center">
                <div className="text-center">
                  <BookOpen className="w-32 h-32 text-brand mx-auto mb-4" />
                  <div className="flex gap-3 justify-center">
                    <div className="w-16 h-16 bg-blue-500 rounded-2xl"></div>
                    <div className="w-16 h-16 bg-purple-500 rounded-2xl"></div>
                    <div className="w-16 h-16 bg-orange-500 rounded-2xl"></div>
                    <div className="w-16 h-16 bg-teal-500 rounded-2xl"></div>
                  </div>
                </div>
              </div>
            </div>
          </motion.div>
        </div>
      </section>

      {/* Backed by Professors Section */}
      <section className="bg-white py-16 md:py-24">
        <div className="max-w-7xl mx-auto px-4">
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="text-center mb-12"
          >
            <h2 className="font-display text-4xl md:text-5xl font-bold text-gray-900 mb-4">
              {t('landing.backed.title')}
            </h2>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto">
              {t('landing.backed.description')}
            </p>
          </motion.div>

          <div className="grid md:grid-cols-2 gap-8 items-center">
            <motion.div
              initial={{ opacity: 0, x: -30 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              className="relative"
            >
              {/* Professor illustration */}
              <div className="w-full aspect-square bg-gradient-to-br from-purple-100 to-blue-100 rounded-3xl flex items-center justify-center">
                <div className="text-center">
                  <Users className="w-40 h-40 text-purple-600 mx-auto" />
                </div>
              </div>
            </motion.div>

            <motion.div
              initial={{ opacity: 0, x: 30 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              className="space-y-6"
            >
              <div className="flex items-start gap-4">
                <div className="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center flex-shrink-0">
                  <CheckCircle className="w-6 h-6 text-green-600" />
                </div>
                <div>
                  <h3 className="font-bold text-xl text-gray-900 mb-2">
                    {t('landing.backed.expertReview.title')}
                  </h3>
                  <p className="text-gray-600">
                    {t('landing.backed.expertReview.description')}
                  </p>
                </div>
              </div>

              <div className="flex items-start gap-4">
                <div className="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center flex-shrink-0">
                  <CheckCircle className="w-6 h-6 text-blue-600" />
                </div>
                <div>
                  <h3 className="font-bold text-xl text-gray-900 mb-2">
                    {t('landing.backed.culturallySensitive.title')}
                  </h3>
                  <p className="text-gray-600">
                    {t('landing.backed.culturallySensitive.description')}
                  </p>
                </div>
              </div>

              <div className="flex items-start gap-4">
                <div className="w-12 h-12 bg-purple-100 rounded-full flex items-center justify-center flex-shrink-0">
                  <CheckCircle className="w-6 h-6 text-purple-600" />
                </div>
                <div>
                  <h3 className="font-bold text-xl text-gray-900 mb-2">
                    {t('landing.backed.academicRigor.title')}
                  </h3>
                  <p className="text-gray-600">
                    {t('landing.backed.academicRigor.description')}
                  </p>
                </div>
              </div>
            </motion.div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-16 md:py-24">
        <div className="max-w-7xl mx-auto px-4">
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="text-center mb-16"
          >
            <h2 className="font-display text-4xl md:text-5xl font-bold text-gray-900 mb-4">
              {t('landing.personalized.title')}
            </h2>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto">
              {t('landing.personalized.description')}
            </p>
          </motion.div>

          <div className="grid md:grid-cols-3 gap-8">
            {/* Feature 1 */}
            <motion.div
              initial={{ opacity: 0, y: 30 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.1 }}
              className="bg-white rounded-3xl p-8 shadow-lg hover:shadow-xl transition-shadow"
            >
              <div className="w-16 h-16 bg-brand/10 rounded-2xl flex items-center justify-center mb-6">
                <BookOpen className="w-8 h-8 text-brand" />
              </div>
              <h3 className="font-display text-2xl font-bold text-gray-900 mb-3">
                {t('landing.personalized.biteSized.title')}
              </h3>
              <p className="text-gray-600">
                {t('landing.personalized.biteSized.description')}
              </p>
            </motion.div>

            {/* Feature 2 */}
            <motion.div
              initial={{ opacity: 0, y: 30 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.2 }}
              className="bg-white rounded-3xl p-8 shadow-lg hover:shadow-xl transition-shadow"
            >
              <div className="w-16 h-16 bg-purple-100 rounded-2xl flex items-center justify-center mb-6">
                <Sparkles className="w-8 h-8 text-purple-600" />
              </div>
              <h3 className="font-display text-2xl font-bold text-gray-900 mb-3">
                {t('landing.personalized.gamified.title')}
              </h3>
              <p className="text-gray-600">
                {t('landing.personalized.gamified.description')}
              </p>
            </motion.div>

            {/* Feature 3 */}
            <motion.div
              initial={{ opacity: 0, y: 30 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.3 }}
              className="bg-white rounded-3xl p-8 shadow-lg hover:shadow-xl transition-shadow"
            >
              <div className="w-16 h-16 bg-amber-100 rounded-2xl flex items-center justify-center mb-6">
                <Award className="w-8 h-8 text-amber-600" />
              </div>
              <h3 className="font-display text-2xl font-bold text-gray-900 mb-3">
                {t('landing.personalized.trackProgress.title')}
              </h3>
              <p className="text-gray-600">
                {t('landing.personalized.trackProgress.description')}
              </p>
            </motion.div>
          </div>
        </div>
      </section>

      {/* Religions Covered */}
      <section className="bg-gradient-to-br from-brand/10 to-purple-50 py-16 md:py-24">
        <div className="max-w-7xl mx-auto px-4">
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="text-center mb-12"
          >
            <h2 className="font-display text-4xl md:text-5xl font-bold text-gray-900 mb-4">
              {t('landing.religions.title')}
            </h2>
            <p className="text-xl text-gray-600">
              {t('landing.religions.description')}
            </p>
          </motion.div>

          <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
            {[
              { key: 'christianity', color: 'bg-purple-500' },
              { key: 'islam', color: 'bg-blue-500' },
              { key: 'hinduism', color: 'bg-orange-500' },
              { key: 'judaism', color: 'bg-teal-500' },
            ].map((religion, index) => (
              <motion.div
                key={religion.key}
                initial={{ opacity: 0, scale: 0.9 }}
                whileInView={{ opacity: 1, scale: 1 }}
                viewport={{ once: true }}
                transition={{ delay: index * 0.1 }}
                className="bg-white rounded-2xl p-6 shadow-lg text-center hover:shadow-xl transition-all hover:scale-105"
              >
                <div className={`w-20 h-20 ${religion.color} rounded-full flex items-center justify-center mx-auto mb-4`}>
                  <div className="w-12 h-12 bg-white/30 rounded-full"></div>
                </div>
                <h3 className="font-bold text-lg text-gray-900">
                  {t(`religions.${religion.key}`)}
                </h3>
                <p className="text-sm text-gray-600 mt-1">
                  6+ {t('learn.lessons')}
                </p>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-16 md:py-24">
        <div className="max-w-4xl mx-auto px-4 text-center">
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
          >
            <h2 className="font-display text-4xl md:text-5xl font-bold text-gray-900 mb-6">
              {t('landing.cta.title')}
            </h2>
            <p className="text-xl text-gray-600 mb-8">
              {t('landing.cta.description')}
            </p>
            <button
              onClick={() => navigate('/app/learn')}
              className="px-12 py-5 bg-brand text-white font-bold text-xl rounded-2xl hover:bg-brand-dark transition-all hover:scale-105 active:scale-95 shadow-xl"
            >
              {t('landing.cta.button')}
            </button>
            <p className="text-sm text-gray-500 mt-4">
              {t('landing.cta.note')}
            </p>
          </motion.div>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-brand text-white py-12">
        <div className="max-w-7xl mx-auto px-4">
          <div className="grid md:grid-cols-4 gap-8">
            <div>
              <h3 className="font-bold text-lg mb-4">{t('landing.footer.about')}</h3>
              <ul className="space-y-2 text-white/80">
                <li><a href="#" className="hover:text-white transition-colors">{t('landing.footer.mission')}</a></li>
                <li><a href="#" className="hover:text-white transition-colors">{t('landing.footer.approach')}</a></li>
                <li><a href="#" className="hover:text-white transition-colors">{t('landing.footer.team')}</a></li>
              </ul>
            </div>
            <div>
              <h3 className="font-bold text-lg mb-4">{t('landing.footer.learn')}</h3>
              <ul className="space-y-2 text-white/80">
                <li><a href="#" className="hover:text-white transition-colors">{t('religions.christianity')}</a></li>
                <li><a href="#" className="hover:text-white transition-colors">{t('religions.islam')}</a></li>
                <li><a href="#" className="hover:text-white transition-colors">{t('religions.hinduism')}</a></li>
                <li><a href="#" className="hover:text-white transition-colors">{t('religions.judaism')}</a></li>
              </ul>
            </div>
            <div>
              <h3 className="font-bold text-lg mb-4">{t('landing.footer.support')}</h3>
              <ul className="space-y-2 text-white/80">
                <li><a href="#" className="hover:text-white transition-colors">{t('landing.footer.helpCenter')}</a></li>
                <li><a href="#" className="hover:text-white transition-colors">{t('landing.footer.faqs')}</a></li>
                <li><a href="#" className="hover:text-white transition-colors">{t('landing.footer.contact')}</a></li>
              </ul>
            </div>
            <div>
              <h3 className="font-bold text-lg mb-4">{t('landing.footer.legal')}</h3>
              <ul className="space-y-2 text-white/80">
                <li><a href="#" className="hover:text-white transition-colors">{t('landing.footer.terms')}</a></li>
                <li><a href="#" className="hover:text-white transition-colors">{t('landing.footer.privacy')}</a></li>
              </ul>
            </div>
          </div>
          <div className="border-t border-white/20 mt-8 pt-8 text-center text-white/60">
            <p>{t('landing.footer.copyright')}</p>
          </div>
        </div>
      </footer>
    </div>
  );
}
