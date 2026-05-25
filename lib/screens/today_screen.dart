import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../data/isms_data.dart';
import '../providers/diagnosis_history_provider.dart';
import '../providers/user_stats_provider.dart';
import '../widgets/isms_art.dart';                  // ✅ corrected import
import '../widgets/ism_detail_sheet.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// Today Screen
// ═══════════════════════════════════════════════════════════════════════════════

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  // ───────────────────────────────────────────────────────────────────────────
  // DAILY ISM
  // ───────────────────────────────────────────────────────────────────────────

  static IsmMeta get _dailyIsm {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final dayOfYear = now.difference(startOfYear).inDays;
    return kIsms[dayOfYear % kIsms.length];
  }

  // ───────────────────────────────────────────────────────────────────────────

  static String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  static String get _formattedDate {
    final now = DateTime.now();
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return '${days[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }

  @override
  Widget build(BuildContext context) {
    final ism = _dailyIsm;
    final gradColors = ism.gradientColors;

    return Consumer2<DiagnosisHistoryProvider, UserStatsProvider>(
      builder: (context, diagProvider, statsProvider, _) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          body: Stack(
            children: [
              Positioned(
                top: -100,
                right: -80,
                child: Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        gradColors[0].withValues(alpha: 0.15),   // ✅ fixed
                        Colors.transparent,
                      ],
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
                      _buildTopRow(statsProvider),
                      const SizedBox(height: 28),
                      _buildDailyIsmCard(context, ism, gradColors),
                      const SizedBox(height: 20),
                      _buildChallengeCard(ism, gradColors),
                      const SizedBox(height: 20),
                      if (diagProvider.lastDiagnosis != null) ...[
                        _buildLastDiagnosisCard(diagProvider),
                        const SizedBox(height: 20),
                      ],
                      _buildStatsRow(statsProvider),
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

  // ═══════════════════════════════════════════════════════════════════════════
  // TOP ROW
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildTopRow(UserStatsProvider stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _formattedDate,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Text(
                'Forge yourself.',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  height: 1.05,
                ),
              ),
            ),
            if (stats.streak > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500).withValues(alpha: 0.15),   // ✅ fixed
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFFF9500).withValues(alpha: 0.35),   // ✅ fixed
                  ),
                ),
                child: Row(
                  children: [
                    const Text('🔥', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 4),
                    Text(
                      '${stats.streak}d',
                      style: const TextStyle(
                        color: Color(0xFFFF9500),
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          '$_greeting. Today\'s philosophy is ${_dailyIsm.name}.',
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DAILY ISM CARD
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildDailyIsmCard(
    BuildContext context,
    IsmMeta ism,
    List<Color> gradColors,
  ) {
    return GestureDetector(
      onTap: () => _showIsmDetail(context, ism, gradColors),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: [
              gradColors[0].withValues(alpha: 0.25),   // ✅ fixed
              gradColors[1].withValues(alpha: 0.12),   // ✅ fixed
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: gradColors[0].withValues(alpha: 0.4),   // ✅ fixed
            width: 1.2,
          ),
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
                    decoration: BoxDecoration(
                      color: gradColors[0].withValues(alpha: 0.2),   // ✅ fixed
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "TODAY'S PHILOSOPHY",
                      style: TextStyle(
                        color: gradColors[0],
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: gradColors[0].withValues(alpha: 0.6),   // ✅ fixed
                    size: 18,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: IsmArtWidget(
                      ism: ism,
                      colors: gradColors,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ism.name,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ism.category.replaceFirst('_', ' '),
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
              child: Text(
                ism.tagline,
                style: TextStyle(
                  color: AppColors.textSecondary.withValues(alpha: 0.9),   // ✅ fixed
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CHALLENGE CARD
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildChallengeCard(IsmMeta ism, List<Color> gradColors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border(
          left: BorderSide(color: gradColors[0], width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bolt_rounded, color: gradColors[0], size: 16),
              const SizedBox(width: 6),
              Text(
                "TODAY'S CHALLENGE",
                style: TextStyle(
                  color: gradColors[0],
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            ism.challenge,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LAST DIAGNOSIS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildLastDiagnosisCard(DiagnosisHistoryProvider diag) {
    final last = diag.lastDiagnosis!;
    final diff = DateTime.now().difference(last.timestamp);
    final timeAgo = diff.inMinutes < 60
        ? '${diff.inMinutes}m ago'
        : diff.inHours < 24
            ? '${diff.inHours}h ago'
            : '${diff.inDays}d ago';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'LAST DIAGNOSIS',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.surfaceAlt),
          ),
          child: Row(
            children: [
              Text(last.result.icon, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      last.result.philosophy,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      last.userInput,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                timeAgo,
                style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // STATS ROW
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildStatsRow(UserStatsProvider stats) {
    return Row(
      children: [
        Expanded(
          child: _StatTile(
            icon: '🔥',
            value: '${stats.streak}',
            label: 'Day Streak',
            color: const Color(0xFFFF9500),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatTile(
            icon: '⚡',
            value: '${stats.totalDiagnoses}',
            label: 'Diagnoses',
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatTile(
            icon: '🧠',
            value: '${stats.totalDiagnoses}',
            label: 'Sessions',
            color: const Color(0xFF64D2FF),
          ),
        ),
      ],
    );
  }

  void _showIsmDetail(BuildContext context, IsmMeta ism, List<Color> gradColors) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => IsmDetailSheet(ism: ism, gradColors: gradColors),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// STAT TILE
// ═══════════════════════════════════════════════════════════════════════════════

class _StatTile extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final Color color;

  const _StatTile({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.25)),   // ✅ fixed
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}