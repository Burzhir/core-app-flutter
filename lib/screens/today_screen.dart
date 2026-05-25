import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_state.dart';
import '../data/isms_data.dart';
import '../widgets/isms_art.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// Today Screen
// Shows greeting, daily ism, challenge, streak, last diagnosis.
// ═══════════════════════════════════════════════════════════════════════════════

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  static IsmMeta get _dailyIsm {
    final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year)).inDays;
    return kIsms[dayOfYear % kIsms.length];
  }

  static String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  static String get _formattedDate {
    final now = DateTime.now();
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    const days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
    return '${days[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }

  @override
  Widget build(BuildContext context) {
    final ism = _dailyIsm;
    final gradColors = ism.gradientColors;

    return Consumer<AppState>(
      builder: (context, state, _) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          body: Stack(
            children: [
              Positioned(
                top: -100, right: -80,
                child: Container(
                  width: 320, height: 320,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [gradColors[0].withValues(alpha: 0.15), Colors.transparent],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      _buildTopRow(context, state, gradColors),
                      const SizedBox(height: 28),
                      _buildDailyIsmCard(ism, gradColors, context),
                      const SizedBox(height: 20),
                      _buildChallengeCard(ism, gradColors),
                      const SizedBox(height: 20),
                      if (state.lastDiagnosis != null) ...[
                        _buildLastDiagnosisCard(state, gradColors),
                        const SizedBox(height: 20),
                      ],
                      _buildStreakCard(state),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopRow(BuildContext context, AppState state, List<Color> gradColors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_formattedDate, style: const TextStyle(color: AppColors.textMuted, fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.5)),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('$_greeting, warrior.', style: const TextStyle(color: AppColors.textPrimary, fontSize: 26, fontWeight: FontWeight.w800, height: 1.1)),
            const Spacer(),
            if (state.streak > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFFF9500).withValues(alpha: 0.35)),
                ),
                child: Row(
                  children: [
                    const Text('🔥', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 4),
                    Text('${state.streak}d', style: const TextStyle(color: Color(0xFFFF9500), fontSize: 13, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildDailyIsmCard(IsmMeta ism, List<Color> gradColors, BuildContext context) {
    return GestureDetector(
      onTap: () => _showIsmDetail(context, ism, gradColors),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(colors: [gradColors[0].withValues(alpha: 0.25), gradColors[1].withValues(alpha: 0.12)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          border: Border.all(color: gradColors[0].withValues(alpha: 0.4), width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: gradColors[0].withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                    child: Text("TODAY'S PHILOSOPHY", style: TextStyle(color: gradColors[0], fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
                  ),
                  const Spacer(),
                  Icon(Icons.chevron_right_rounded, color: gradColors[0].withValues(alpha: 0.6), size: 18),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 40, height: 40, child: IsmArtWidget(ism: ism, colors: gradColors, height: 40, width: 40)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ism.name, style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w800, height: 1.2)),
                        const SizedBox(height: 4),
                        Text(ism.category.replaceFirst('_', ' '), style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
              child: Text(ism.tagline, style: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.9), fontSize: 14, fontStyle: FontStyle.italic, height: 1.5)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeCard(IsmMeta ism, List<Color> gradColors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border(left: BorderSide(color: gradColors[0], width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.bolt_rounded, color: gradColors[0], size: 16),
            const SizedBox(width: 6),
            Text("TODAY'S CHALLENGE", style: TextStyle(color: gradColors[0], fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
          ]),
          const SizedBox(height: 10),
          Text(ism.challenge, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.6)),
        ],
      ),
    );
  }

  Widget _buildLastDiagnosisCard(AppState state, List<Color> gradColors) {
    final last = state.lastDiagnosis!;
    final diff = DateTime.now().difference(last.timestamp);
    final timeAgo = diff.inMinutes < 60
        ? '${diff.inMinutes}m ago'
        : diff.inHours < 24
            ? '${diff.inHours}h ago'
            : '${diff.inDays}d ago';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('LAST DIAGNOSIS', style: TextStyle(color: AppColors.textMuted, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 2)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.surfaceAlt)),
          child: Row(
            children: [
              Text(last.result.icon, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(last.result.philosophy, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(last.userInput, style: const TextStyle(color: AppColors.textMuted, fontSize: 12, height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(timeAgo, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStreakCard(AppState state) {
    return Row(
      children: [
        Expanded(child: _StatTile(icon: '🔥', value: '${state.streak}', label: 'Day Streak', color: const Color(0xFFFF9500))),
        const SizedBox(width: 12),
        Expanded(child: _StatTile(icon: '⚡', value: '${state.totalDiagnoses}', label: 'Diagnoses', color: AppColors.accent)),
        const SizedBox(width: 12),
        Expanded(child: _StatTile(icon: '📖', value: '${state.journalCount}', label: 'Reflections', color: const Color(0xFF64D2FF))),
      ],
    );
  }

  void _showIsmDetail(BuildContext context, IsmMeta ism, List<Color> gradColors) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _IsmDetailSheet(ism: ism, gradColors: gradColors),
    );
  }
}

// ── Stat tile ───────────────────────────────────────────────────────────────
class _StatTile extends StatelessWidget {
  final String icon; final String value; final String label; final Color color;
  const _StatTile({required this.icon, required this.value, required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withValues(alpha: 0.25))),
      child: Column(children: [
        Text(icon, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 6),
        Text(value, style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.w900)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 10), textAlign: TextAlign.center),
      ]),
    );
  }
}

// ── Detail sheet (same as in IsmsScreen) ────────────────────────────────────
class _IsmDetailSheet extends StatelessWidget {
  final IsmMeta ism;
  final List<Color> gradColors;
  const _IsmDetailSheet({required this.ism, required this.gradColors});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      expand: false,
      builder: (_, ctrl) => ListView(
        controller: ctrl,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 20),
          ClipRRect(borderRadius: BorderRadius.circular(16), child: IsmArtWidget(ism: ism, colors: gradColors, height: 180)),
          const SizedBox(height: 20),
          Row(children: [
            Text(ism.icon, style: const TextStyle(fontSize: 40)),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(ism.name, style: const TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w800, height: 1.2)),
              const SizedBox(height: 4),
              Text(ism.category, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
            ])),
          ]),
          const SizedBox(height: 16),
          Container(height: 1, color: AppColors.surfaceAlt),
          const SizedBox(height: 16),
          Text('"${ism.tagline}"', style: TextStyle(color: gradColors[0], fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600, height: 1.4)),
          const SizedBox(height: 16),
          _buildSectionTitle('OVERVIEW', gradColors), const SizedBox(height: 8),
          Text(ism.overview, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.7)),
          const SizedBox(height: 24),
          _buildSectionTitle('HISTORICAL CONTEXT', gradColors), const SizedBox(height: 8),
          Text(ism.historicalContext, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.7)),
          const SizedBox(height: 24),
          _buildSectionTitle('CORE TENETS', gradColors), const SizedBox(height: 8),
          ...ism.coreTenets.map((t) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('• ', style: TextStyle(color: AppColors.textMuted)), Expanded(child: Text(t, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5)))]))),
          const SizedBox(height: 24),
          _buildSectionTitle('NOTABLE FIGURES', gradColors), const SizedBox(height: 8),
          ...ism.notableFigures.map((nf) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(nf.name, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w700)), const SizedBox(height: 2), Text(nf.contribution, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.4))]))),
          const SizedBox(height: 24),
          _buildSectionTitle('MODERN APPLICATION', gradColors), const SizedBox(height: 8),
          Text(ism.modernApplication, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.7)),
          const SizedBox(height: 24),
          _buildSectionTitle('QUOTES', gradColors), const SizedBox(height: 8),
          ...ism.quotes.map((q) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(q, style: TextStyle(color: gradColors[0], fontSize: 13, fontStyle: FontStyle.italic, height: 1.5)))),
          const SizedBox(height: 24),
          _buildSectionTitle('KEY WORKS', gradColors), const SizedBox(height: 8),
          ...ism.keyWorks.map((w) => Padding(padding: const EdgeInsets.only(bottom: 4), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('• ', style: TextStyle(color: AppColors.textMuted)), Expanded(child: Text(w, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5)))]))),
          const SizedBox(height: 24),
          Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(gradient: LinearGradient(colors: [gradColors[0].withValues(alpha: 0.15), gradColors[1].withValues(alpha: 0.08)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: gradColors[0].withValues(alpha: 0.35), width: 1.2)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(Icons.bolt_rounded, color: gradColors[0], size: 16), const SizedBox(width: 6), Text('THE CHALLENGE', style: TextStyle(color: gradColors[0], fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.5))]), const SizedBox(height: 10), Text(ism.challenge, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.6))])),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, List<Color> colors) {
    return Row(children: [
      Container(width: 4, height: 14, decoration: BoxDecoration(color: colors[0], borderRadius: BorderRadius.circular(2))),
      const SizedBox(width: 8),
      Text(title, style: TextStyle(color: colors[0], fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 2)),
    ]);
  }
}