import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/app_colors.dart';
import '../providers/auth_provider.dart' as core;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late final AnimationController _starCtrl;
  late final AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _starCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _starCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<core.AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // ── Animated star field background ─────────────────────────────
          AnimatedBuilder(
            animation: _starCtrl,
            builder: (_, __) => CustomPaint(
              painter: _StarFieldPainter(t: _starCtrl.value),
              child: const SizedBox.expand(),
            ),
          ),

          // ── Glowing orbs ───────────────────────────────────────────────
          AnimatedBuilder(
            animation: _pulseCtrl,
            builder: (_, __) {
              final p = _pulseCtrl.value;
              return Stack(
                children: [
                  Positioned(
                    top: -100 + p * 20,
                    left: -80,
                    child: _GlowOrb(
                        size: 300,
                        color: AppColors.accent,
                        opacity: 0.12 + p * 0.04),
                  ),
                  Positioned(
                    bottom: -80 + p * 15,
                    right: -60,
                    child: _GlowOrb(
                        size: 250,
                        color: AppColors.teal,
                        opacity: 0.08 + p * 0.03),
                  ),
                ],
              );
            },
          ),

          // ── Content ────────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // Logo / wordmark
                  Column(
                    children: [
                      // Glowing C logo
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            colors: [Color(0xFF3D1F6E), Color(0xFF0E0B1A)],
                          ),
                          border: Border.all(
                            color: AppColors.accent.withValues(alpha: 0.6),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withValues(alpha: 0.4),
                              blurRadius: 30,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'C',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Outfit',
                            ),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 600.ms)
                          .scale(begin: const Offset(0.8, 0.8)),

                      const SizedBox(height: 20),

                      ShaderMask(
                        shaderCallback: (b) => const LinearGradient(
                          colors: [Color(0xFFBF5AF2), Color(0xFF64D2FF)],
                        ).createShader(b),
                        child: const Text(
                          'CORE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 12,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      )
                          .animate(delay: 200.ms)
                          .fadeIn(duration: 600.ms)
                          .slideY(begin: 0.2, end: 0),

                      const SizedBox(height: 12),

                      const Text(
                        'Philosophical coaching\nfor the restless mind.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                          height: 1.6,
                          fontFamily: 'Outfit',
                        ),
                      ).animate(delay: 400.ms).fadeIn(duration: 600.ms),
                    ],
                  ),

                  const Spacer(flex: 2),

                  // ── Philosophy preview chips ────────────────────────────
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      'Stoicism',
                      'Absurdism',
                      'Buddhism',
                      'Nihilism',
                      'Taoism',
                      'Existentialism',
                    ].asMap().entries.map((e) {
                      return _PhilosophyChip(label: e.value, delay: e.key * 80);
                    }).toList(),
                  ),

                  const Spacer(flex: 1),

                  // ── Sign in button ──────────────────────────────────────
                  if (auth.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        auth.error!,
                        style: const TextStyle(
                            color: Color(0xFFFF6B6B), fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  _GoogleSignInButton(
                    loading: auth.loading,
                    onTap: () async {
                      await context
                          .read<core.AuthProvider>()
                          .signInWithGoogle();
                    },
                  )
                      .animate(delay: 800.ms)
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 16),

                  const Text(
                    'By continuing, you agree to our Terms & Privacy Policy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11,
                      height: 1.5,
                    ),
                  ).animate(delay: 1000.ms).fadeIn(duration: 500.ms),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Google Sign-In button ──────────────────────────────────────────────────────

class _GoogleSignInButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onTap;

  const _GoogleSignInButton({required this.loading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: loading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.accent,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google G logo
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          'G',
                          style: TextStyle(
                            color: Color(0xFF4285F4),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Continue with Google',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// ── Philosophy chip ────────────────────────────────────────────────────────────

class _PhilosophyChip extends StatelessWidget {
  final String label;
  final int delay;

  const _PhilosophyChip({required this.label, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.surfaceGlass,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: 'Outfit',
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: 600 + delay))
        .fadeIn(duration: 400.ms)
        .scale(begin: const Offset(0.9, 0.9));
  }
}

// ── Glow orb ──────────────────────────────────────────────────────────────────

class _GlowOrb extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;

  const _GlowOrb(
      {required this.size, required this.color, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: opacity), Colors.transparent],
        ),
      ),
    );
  }
}

// ── Star field painter ─────────────────────────────────────────────────────────

class _StarFieldPainter extends CustomPainter {
  final double t;
  static final _rng = math.Random(42);
  static late final List<_Star> _stars = List.generate(120, (i) => _Star(_rng));

  _StarFieldPainter({required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in _stars) {
      final twinkle =
          (math.sin(t * math.pi * 2 * star.speed + star.phase) * 0.5 + 0.5);
      final opacity = star.baseOpacity * (0.4 + twinkle * 0.6);
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.radius,
        Paint()..color = Colors.white.withValues(alpha: opacity),
      );
    }
  }

  @override
  bool shouldRepaint(_StarFieldPainter old) => old.t != t;
}

class _Star {
  final double x, y, radius, speed, phase, baseOpacity;

  _Star(math.Random rng)
      : x = rng.nextDouble(),
        y = rng.nextDouble(),
        radius = rng.nextDouble() * 1.2 + 0.3,
        speed = rng.nextDouble() * 0.8 + 0.2,
        phase = rng.nextDouble() * math.pi * 2,
        baseOpacity = rng.nextDouble() * 0.5 + 0.1;
}
