import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/theme_provider.dart';
import '../providers/diagnosis_history_provider.dart';
import '../providers/journal_provider.dart';
import '../providers/user_stats_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats   = context.watch<UserStatsProvider>();
    final history = context.watch<DiagnosisHistoryProvider>();
    final journal = context.watch<JournalProvider>();
    final theme   = context.watch<ThemeProvider>();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ───────────────────────────────────────────────────
              Row(
                children: [
                  ShaderMask(
                    shaderCallback: (b) => const LinearGradient(
                      colors: [Color(0xFFBF5AF2), Color(0xFF64D2FF)],
                    ).createShader(b),
                    child: const Text(
                      'PROFILE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Theme toggle
                  GestureDetector(
                    onTap: () => context.read<ThemeProvider>().toggle(),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 52,
                      height: 28,
                      decoration: BoxDecoration(
                        color: theme.isDark
                            ? AppColors.surfaceAlt
                            : AppColors.accent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            left: theme.isDark ? 2 : 26,
                            top: 2,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                theme.isDark ? Icons.dark_mode : Icons.light_mode,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ── Stats row ────────────────────────────────────────────────
              const _SectionLabel('YOUR STATS'),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: '🔥',
                      value: '${stats.streak}',
                      label: 'Day Streak',
                      color: const Color(0xFFFF9500),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: '⚡',
                      value: '${stats.totalDiagnoses}',
                      label: 'Diagnoses',
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: '📓',
                      value: '${journal.journalCount}',
                      label: 'Journal Entries',
                      color: const Color(0xFF4A90D9),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ── Top philosophies ─────────────────────────────────────────
              if (history.topIsms.isNotEmpty) ...[
                const _SectionLabel('YOUR TOP PHILOSOPHIES'),
                const SizedBox(height: 12),
                ...history.topIsms.asMap().entries.map((entry) {
                  final rank  = entry.key + 1;
                  final ism   = entry.value;
                  return _TopIsmRow(rank: rank, name: ism.key, count: ism.value);
                }),
                const SizedBox(height: 28),
              ],

              // ── Recent diagnoses ─────────────────────────────────────────
              if (history.history.isNotEmpty) ...[
                const _SectionLabel('RECENT DIAGNOSES'),
                const SizedBox(height: 12),
                ...history.history.take(5).map((e) => _HistoryTile(entry: e)),
                const SizedBox(height: 28),
              ],

              // ── Settings ─────────────────────────────────────────────────
              const _SectionLabel('SETTINGS'),
              const SizedBox(height: 12),

              _SettingsTile(
                icon: Icons.delete_sweep_outlined,
                label: 'Clear diagnosis history',
                color: const Color(0xFFFF9500),
                onTap: () => _confirmClear(
                  context,
                  title: 'Clear history?',
                  body: 'Your diagnosis history will be deleted. Journal and stats are kept.',
                  onConfirm: () => context.read<DiagnosisHistoryProvider>().clear(),
                ),
              ),
              const SizedBox(height: 8),
              _SettingsTile(
                icon: Icons.delete_forever_outlined,
                label: 'Clear all data',
                color: const Color(0xFFFF3B30),
                onTap: () => _confirmClear(
                  context,
                  title: 'Clear everything?',
                  body: 'This deletes all diagnoses, journal entries, and resets your stats. This cannot be undone.',
                  onConfirm: () async {
                    await context.read<DiagnosisHistoryProvider>().clear();
                    await context.read<JournalProvider>().clear();
                    await context.read<UserStatsProvider>().clearAll();
                  },
                ),
              ),

              const SizedBox(height: 40),

              // ── App info ──────────────────────────────────────────────────
              Center(
                child: Column(
                  children: [
                    Text(
                      'CORE',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'v0.1 · Philosophical coaching for warriors',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmClear(
    BuildContext context, {
    required String title,
    required String body,
    required VoidCallback onConfirm,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(title,
            style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
        content: Text(body,
            style: const TextStyle(color: AppColors.textSecondary, height: 1.5)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Color(0xFFFF3B30))),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      onConfirm();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Done.'),
          backgroundColor: AppColors.surface,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

// ── Section label ──────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textMuted,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 2,
      ),
    );
  }
}

// ── Stat card ──────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final Color  color;

  const _StatCard({
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
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.25)),
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

// ── Top ism row ────────────────────────────────────────────────────────────────

class _TopIsmRow extends StatelessWidget {
  final int    rank;
  final String name;
  final int    count;

  const _TopIsmRow({required this.rank, required this.name, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.surfaceAlt),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '#$rank',
              style: TextStyle(
                color: rank == 1 ? const Color(0xFFFFD700) : AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '$count× matched',
            style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ── History tile ───────────────────────────────────────────────────────────────

class _HistoryTile extends StatelessWidget {
  final dynamic entry;

  const _HistoryTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.surfaceAlt),
      ),
      child: Row(
        children: [
          Text(entry.result.icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.result.philosophy,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  entry.userInput,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                    height: 1.4,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _formatDate(entry.timestamp),
            style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays}d ago';
  }
}

// ── Settings tile ──────────────────────────────────────────────────────────────

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String   label;
  final Color    color;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_right_rounded, color: color.withValues(alpha: 0.5), size: 18),
          ],
        ),
      ),
    );
  }
}
