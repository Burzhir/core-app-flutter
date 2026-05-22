import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_state.dart';
import '../data/philosophies_data.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// Today Screen
// Shows: greeting, daily philosophy (rotates by day), streak, challenge,
// last diagnosis from AppState — no API calls needed.
// ═══════════════════════════════════════════════════════════════════════════════

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  // Pick today's philosophy by day-of-year so it's the same for everyone
  // all day, then changes at midnight.
  static PhilosophyMeta get _dailyPhilosophy {
    final dayOfYear = int.parse(
      DateTime.now().difference(DateTime(DateTime.now().year)).inDays.toString(),
    );
    return kPhilosophies[dayOfYear % kPhilosophies.length];
  }

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
    final philosophy = _dailyPhilosophy;
    final gradColors = AppColors.gradientFor(philosophy.name);

    return Consumer<AppState>(
      builder: (context, state, _) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          body: Stack(
            children: [
              // Ambient background glow
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
                        gradColors[0].withOpacity(0.15),
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
                      _buildTopRow(context, state),
                      const SizedBox(height: 28),
                      _buildDailyPhilosophyCard(philosophy, gradColors, context),
                      const SizedBox(height: 20),
                      _buildChallengeCard(philosophy, gradColors),
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

  // ── Top row: date + greeting ───────────────────────────────────────────────

  Widget _buildTopRow(BuildContext context, AppState state) {
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
            Text(
              '$_greeting, warrior.',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                height: 1.1,
              ),
            ),
            const Spacer(),
            if (state.streak > 0)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color(0xFFFF9500).withOpacity(0.35)),
                ),
                child: Row(
                  children: [
                    const Text('🔥', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 4),
                    Text(
                      '${state.streak}d',
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
      ],
    );
  }

  // ── Daily philosophy card ──────────────────────────────────────────────────

  Widget _buildDailyPhilosophyCard(
    PhilosophyMeta philosophy,
    List<Color> gradColors,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => _showPhilosophyDetail(context, philosophy, gradColors),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: [
              gradColors[0].withOpacity(0.25),
              gradColors[1].withOpacity(0.12),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
              color: gradColors[0].withOpacity(0.4), width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label row
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: gradColors[0].withOpacity(0.2),
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
                  Icon(Icons.chevron_right_rounded,
                      color: gradColors[0].withOpacity(0.6), size: 18),
                ],
              ),
            ),

            // Icon + name
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(philosophy.icon,
                      style: const TextStyle(fontSize: 40)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          philosophy.name,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          philosophy.thinker,
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

            // Tagline
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
              child: Text(
                philosophy.tagline,
                style: TextStyle(
                  color: AppColors.textSecondary.withOpacity(0.9),
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

  // ── Challenge card ─────────────────────────────────────────────────────────

  Widget _buildChallengeCard(
      PhilosophyMeta philosophy, List<Color> gradColors) {
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
            philosophy.challenge,
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

  // ── Last diagnosis card ────────────────────────────────────────────────────

  Widget _buildLastDiagnosisCard(AppState state, List<Color> gradColors) {
    final last = state.lastDiagnosis!;
    final lastColors = last.result.gradientColors;
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
              Text(last.result.icon,
                  style: const TextStyle(fontSize: 28)),
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
                style: const TextStyle(
                    color: AppColors.textMuted, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Streak card ────────────────────────────────────────────────────────────

  Widget _buildStreakCard(AppState state) {
    return Row(
      children: [
        Expanded(
          child: _StatTile(
            icon: '🔥',
            value: '${state.streak}',
            label: 'Day Streak',
            color: const Color(0xFFFF9500),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatTile(
            icon: '⚡',
            value: '${state.totalDiagnoses}',
            label: 'Diagnoses',
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatTile(
            icon: '📖',
            value: '${state.journalCount}',
            label: 'Reflections',
            color: const Color(0xFF64D2FF),
          ),
        ),
      ],
    );
  }

  // ── Philosophy detail sheet ────────────────────────────────────────────────

  void _showPhilosophyDetail(
    BuildContext context,
    PhilosophyMeta philosophy,
    List<Color> gradColors,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _PhilosophyDetailSheet(
        philosophy: philosophy,
        gradColors: gradColors,
      ),
    );
  }
}

// ── Stat tile ──────────────────────────────────────────────────────────────────

class _StatTile extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final Color  color;

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
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
                color: AppColors.textMuted, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Philosophy detail sheet ────────────────────────────────────────────────────

class _PhilosophyDetailSheet extends StatelessWidget {
  final PhilosophyMeta philosophy;
  final List<Color>    gradColors;

  const _PhilosophyDetailSheet({
    required this.philosophy,
    required this.gradColors,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (_, ctrl) => ListView(
        controller: ctrl,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text(philosophy.icon,
                  style: const TextStyle(fontSize: 44)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      philosophy.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(philosophy.thinker,
                        style: const TextStyle(
                            color: AppColors.textMuted, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gradColors[0].withOpacity(0.5), Colors.transparent],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            philosophy.description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: gradColors[0].withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: gradColors[0].withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'THE CHALLENGE',
                  style: TextStyle(
                    color: gradColors[0], fontSize: 10,
                    fontWeight: FontWeight.w800, letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  philosophy.challenge,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14, height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}