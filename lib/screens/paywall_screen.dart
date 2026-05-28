import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/app_colors.dart';
import '../providers/auth_provider.dart' as core;

class PaywallScreen extends StatelessWidget {
  final String? triggerReason;
  const PaywallScreen({super.key, this.triggerReason});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Background glow
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: 0.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Close button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceAlt,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.close_rounded,
                            color: AppColors.textMuted, size: 18),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        if (triggerReason != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color:
                                      AppColors.accent.withValues(alpha: 0.3)),
                            ),
                            child: Text(
                              triggerReason!,
                              style: const TextStyle(
                                  color: AppColors.accent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ).animate().fadeIn(duration: 400.ms),

                        const SizedBox(height: 20),

                        ShaderMask(
                          shaderCallback: (b) => const LinearGradient(
                            colors: [Color(0xFFBF5AF2), Color(0xFF64D2FF)],
                          ).createShader(b),
                          child: const Text(
                            'Go\nPremium.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                              height: 1.1,
                              fontFamily: 'Outfit',
                            ),
                          ),
                        )
                            .animate(delay: 100.ms)
                            .fadeIn(duration: 500.ms)
                            .slideY(begin: 0.2, end: 0),

                        const SizedBox(height: 12),
                        const Text(
                          'Unlimited access to all philosophies,\nunlimited AI diagnoses, zero limits.',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                            height: 1.6,
                          ),
                        ).animate(delay: 200.ms).fadeIn(duration: 500.ms),

                        const SizedBox(height: 32),

                        // Feature list
                        ..._features.asMap().entries.map((e) {
                          return _FeatureRow(
                            icon: e.value.$1,
                            title: e.value.$2,
                            subtitle: e.value.$3,
                            delay: 300 + e.key * 80,
                          );
                        }),

                        const SizedBox(height: 32),

                        // Pricing card
                        _PricingCard()
                            .animate(delay: 700.ms)
                            .fadeIn(duration: 500.ms)
                            .slideY(begin: 0.2, end: 0),

                        const SizedBox(height: 20),

                        // CTA
                        _UnlockButton()
                            .animate(delay: 850.ms)
                            .fadeIn(duration: 500.ms),

                        const SizedBox(height: 12),
                        const Center(
                          child: Text(
                            'Cancel anytime · Restore purchases',
                            style: TextStyle(
                                color: AppColors.textMuted, fontSize: 12),
                          ),
                        ).animate(delay: 950.ms).fadeIn(duration: 400.ms),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const List<(String, String, String)> _features = [
    (
      '⚡',
      'Unlimited AI Diagnoses',
      'No daily cap — diagnose as much as you need'
    ),
    (
      '📚',
      'Full Philosophy Library',
      'All 30 isms unlocked with deep insights'
    ),
    ('🎨', 'Exclusive AI Art', 'Unique generative art for every philosophy'),
    ('📊', 'Advanced Analytics', 'Track your philosophy patterns over time'),
    ('🔥', 'Priority AI', 'Faster responses, better AI model access'),
  ];
}

class _FeatureRow extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final int delay;

  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderGlow),
            ),
            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded,
              color: AppColors.accent, size: 18),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: delay))
        .fadeIn(duration: 400.ms)
        .slideX(begin: -0.1, end: 0);
  }
}

class _PricingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withValues(alpha: 0.15),
            AppColors.teal.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: AppColors.accent.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'CORE Premium',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
                ),
                child: const Text(
                  'BEST VALUE',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '\$2.99',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 6),
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text(
                  '/ month',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                ),
              ),
              const Spacer(),
              const Text(
                '\$35.88 / year',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Or \$19.99/year — save 44%',
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _UnlockButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Wire to RevenueCat / Stripe later
        await context.read<core.AuthProvider>().unlockPremium();
        if (context.mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Premium unlocked! Enjoy CORE.'),
              backgroundColor: AppColors.surface,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFBF5AF2), Color(0xFF5E5CE6)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.4),
              blurRadius: 24,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'UNLOCK PREMIUM',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              fontFamily: 'Outfit',
            ),
          ),
        ),
      ),
    );
  }
}
