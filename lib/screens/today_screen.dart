import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../widgets/cosmic_background.dart';
import '../data/philosophies_data.dart';
import '../models/philosophy_model.dart';
import '../providers/auth_provider.dart' as core;
import '../app.dart';
import 'philosophy_detail_screen.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final today     = DateTime.now();
    final weekdays  = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final dayName   = weekdays[today.weekday - 1];
    final months    = ['Jan','Feb','Mar','Apr','May','Jun',
                       'Jul','Aug','Sep','Oct','Nov','Dec'];
    final dateStr   = '$dayName, ${months[today.month - 1]} ${today.day}';

    // Rotate through all 12 philosophies by day-of-year
    final dayOfYear = int.parse(
        '${today.difference(DateTime(today.year)).inDays}');
    final featured  = kPhilosophies[dayOfYear % kPhilosophies.length];
    final daily     = featured.todayContent;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          CosmicBackground(accentColors: featured.gradient),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                // ── Header ──────────────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(dateStr,
                                style: const TextStyle(
                                  color: AppColors.textMuted, fontSize: 12,
                                  letterSpacing: 1.5,
                                )).animate().fadeIn(duration: 500.ms),
                              const SizedBox(height: 4),
                              const Text('Today',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 28, fontWeight: FontWeight.w900,
                                  fontFamily: 'Outfit',
                                )).animate(delay: 100.ms)
                                  .fadeIn(duration: 500.ms),
                            ],
                          ),
                        ),
                        _QuickCompareButton(context: context),
                      ],
                    ),
                  ),
                ),

                // ── Featured philosophy card ─────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) => PhilosophyDetailScreen(philosophy: featured))),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              featured.gradient[0].withValues(alpha: 0.25),
                              featured.gradient[1].withValues(alpha: 0.15),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: featured.gradient[0].withValues(alpha: 0.4),
                          ),
                        ),
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(featured.emoji,
                                    style: const TextStyle(fontSize: 24)),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Today\'s philosophy',
                                      style: TextStyle(
                                        color: AppColors.textMuted,
                                        fontSize: 11, letterSpacing: 1.5,
                                      )),
                                    Text(featured.name,
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: 18, fontWeight: FontWeight.w800,
                                        fontFamily: 'Outfit',
                                      )),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios_rounded,
                                    color: AppColors.textMuted, size: 14),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(featured.tagline,
                              style: TextStyle(
                                color: featured.gradient[0],
                                fontSize: 13, fontStyle: FontStyle.italic,
                              )),
                          ],
                        ),
                      ),
                    ).animate(delay: 200.ms)
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.1, end: 0),
                  ),
                ),

                // ── Daily quote ──────────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: _SectionCard(
                      title: 'Quote',
                      accentColor: AppColors.gold,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('"', style: TextStyle(
                            color: AppColors.gold, fontSize: 36,
                            fontWeight: FontWeight.w900, height: 0.8,
                          )),
                          const SizedBox(height: 6),
                          Text(daily.quote,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16, fontStyle: FontStyle.italic,
                              height: 1.6,
                            )),
                          const SizedBox(height: 10),
                          Text('— ${daily.quoteAuthor}',
                            style: const TextStyle(
                              color: AppColors.textMuted, fontSize: 12,
                            )),
                        ],
                      ),
                    ),
                  ).animate(delay: 300.ms).fadeIn(duration: 500.ms),
                ),

                // ── Reflection question ──────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                    child: _SectionCard(
                      title: '🔍  Reflection',
                      accentColor: AppColors.teal,
                      child: Text(daily.reflectionQuestion,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15, height: 1.6,
                        )),
                    ),
                  ).animate(delay: 400.ms).fadeIn(duration: 500.ms),
                ),

                // ── Action challenge ─────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                    child: _SectionCard(
                      title: '⚡  Action Challenge',
                      accentColor: AppColors.accent,
                      child: Text(daily.actionChallenge,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15, height: 1.6,
                        )),
                    ),
                  ).animate(delay: 500.ms).fadeIn(duration: 500.ms),
                ),

                // ── Explore more ─────────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('More philosophies',
                          style: TextStyle(
                            color: AppColors.textSecondary, fontSize: 12,
                            letterSpacing: 1.5,
                          )),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 80,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: kPhilosophies.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 10),
                            itemBuilder: (context, i) {
                              final p = kPhilosophies[i];
                              return GestureDetector(
                                onTap: () => Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (_) => PhilosophyDetailScreen(philosophy: p))),
                                child: Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        p.gradient[0].withValues(alpha: 0.18),
                                        p.gradient[1].withValues(alpha: 0.08),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: p.gradient[0].withValues(alpha: 0.3)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(p.emoji,
                                          style: const TextStyle(fontSize: 22)),
                                      const SizedBox(height: 4),
                                      Text(p.name,
                                        style: const TextStyle(
                                          color: AppColors.textMuted, fontSize: 9,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ).animate(delay: 600.ms).fadeIn(duration: 500.ms),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Quick compare button ───────────────────────────────────────────────────────

class _QuickCompareButton extends StatelessWidget {
  final BuildContext context;
  const _QuickCompareButton({required this.context});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Forge tab (index 1)
        final shell = context.findAncestorStateOfType<State<MainShell>>();
        if (shell is _MainShellState) {
          (shell as dynamic)._index = 1;
          (shell as dynamic).setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.accentSoft,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderGlow),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.compare_arrows_rounded,
                color: AppColors.accent, size: 14),
            SizedBox(width: 6),
            Text('Forge',
              style: TextStyle(
                color: AppColors.accent, fontSize: 12,
                fontWeight: FontWeight.w700,
              )),
          ],
        ),
      ),
    );
  }
}

// ── Section card ──────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final Color  accentColor;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.accentColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
            style: TextStyle(
              color: accentColor, fontSize: 11,
              fontWeight: FontWeight.w800, letterSpacing: 1.5,
            )),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
