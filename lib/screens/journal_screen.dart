import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../models/journal_entry.dart';
import '../providers/diagnosis_history_provider.dart';
import '../providers/journal_provider.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// Journal Screen
// Entries persist via SharedPreferences (handled in JournalProvider).
// Each entry auto-links to the last active philosophy diagnosis.
// ═══════════════════════════════════════════════════════════════════════════════

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController _ctrl  = TextEditingController();
  final FocusNode             _focus = FocusNode();
  bool _composing = false;

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  Future<void> _submit(DiagnosisHistoryProvider diag, JournalProvider journal) async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;

    _focus.unfocus();

    final last = diag.lastDiagnosis;
    final entry = JournalEntry(
      id:               DateTime.now().millisecondsSinceEpoch.toString(),
      text:             text,
      linkedPhilosophy: last?.result.philosophy,
      linkedIcon:       last?.result.icon,
      createdAt:        DateTime.now(),
    );

    await journal.addEntry(entry);

    _ctrl.clear();
    setState(() => _composing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<DiagnosisHistoryProvider, JournalProvider>(
      builder: (context, diag, journal, _) {
        final grouped = _groupByDate(journal.journal);

        return Scaffold(
          backgroundColor: AppColors.bg,
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(diag, journal),
                // Compose bar
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 250),
                  crossFadeState: _composing
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: _buildComposeTrigger(),
                  secondChild: _buildComposeBox(diag, journal),
                ),
                const SizedBox(height: 4),

                // Entry list
                Expanded(
                  child: journal.journal.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
                          itemCount: grouped.length,
                          itemBuilder: (_, i) {
                            final section = grouped[i];
                            return _DateSection(
                              label: section.$1,
                              entries: section.$2,
                              onDelete: (id) => journal.deleteEntry(id),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────

  Widget _buildHeader(DiagnosisHistoryProvider diag, JournalProvider journal) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (b) => const LinearGradient(
                  colors: [Color(0xFF64D2FF), Color(0xFFBF5AF2)],
                ).createShader(b),
                child: const Text(
                  'JOURNAL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${journal.journalCount} reflection${journal.journalCount == 1 ? '' : 's'}',
                style: const TextStyle(
                    color: AppColors.textMuted, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          if (!_composing)
            GestureDetector(
              onTap: () {
                setState(() => _composing = true);
                Future.delayed(const Duration(milliseconds: 300),
                    () => _focus.requestFocus());
              },
              child: Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF64D2FF), Color(0xFFBF5AF2)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
        ],
      ),
    );
  }

  // ── Compose trigger (collapsed) ────────────────────────────────────────────

  Widget _buildComposeTrigger() {
    return GestureDetector(
      onTap: () {
        setState(() => _composing = true);
        Future.delayed(
            const Duration(milliseconds: 200), () => _focus.requestFocus());
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.surfaceAlt),
        ),
        child: const Row(
          children: [
            Icon(Icons.edit_outlined,
                color: AppColors.textMuted, size: 16),
            SizedBox(width: 10),
            Text(
              'Write a reflection…',
              style: TextStyle(color: AppColors.textMuted, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // ── Compose box (expanded) ─────────────────────────────────────────────────

  Widget _buildComposeBox(DiagnosisHistoryProvider diag, JournalProvider journal) {
    final last = diag.lastDiagnosis;
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: const Color(0xFF64D2FF).withValues(alpha: 0.5), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Linked philosophy chip
          if (last != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
              child: Row(
                children: [
                  Text(last.result.icon,
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 6),
                  Text(
                    'Linked to ${last.result.philosophy}',
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

          TextField(
            controller: _ctrl,
            focusNode: _focus,
            style: const TextStyle(
                color: AppColors.textPrimary, fontSize: 15, height: 1.6),
            maxLines: 5,
            minLines: 3,
            decoration: const InputDecoration(
              hintText:
                  'What are you actually feeling right now?\nWhat did you avoid today? Why?\nWhat would the warrior version of you do?',
              hintStyle: TextStyle(
                  color: AppColors.textMuted, fontSize: 14, height: 1.6),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(14),
            ),
          ),

          // Action row
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _ctrl.clear();
                    _focus.unfocus();
                    setState(() => _composing = false);
                  },
                  child: const Text('Cancel',
                      style: TextStyle(
                          color: AppColors.textMuted, fontSize: 13)),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _submit(diag, journal),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF64D2FF), Color(0xFFBF5AF2)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
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

  // ── Empty state ────────────────────────────────────────────────────────────

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70, height: 70,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.surfaceAlt),
            ),
            child: const Center(
              child: Text('📖', style: TextStyle(fontSize: 32)),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No reflections yet.',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Write your first thought.\nHonesty with yourself is the start.',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 13,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ── Group entries by date ──────────────────────────────────────────────────

  List<(String, List<JournalEntry>)> _groupByDate(
      List<JournalEntry> entries) {
    final map = <String, List<JournalEntry>>{};
    for (final e in entries) {
      final key = _dateLabel(e.createdAt);
      map.putIfAbsent(key, () => []).add(e);
    }
    return map.entries.map((e) => (e.key, e.value)).toList();
  }

  String _dateLabel(DateTime dt) {
    final now   = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date  = DateTime(dt.year, dt.month, dt.day);
    final diff  = today.difference(date).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[dt.month - 1]} ${dt.day}';
  }
}

// ── Date section ───────────────────────────────────────────────────────────────

class _DateSection extends StatelessWidget {
  final String              label;
  final List<JournalEntry>  entries;
  final void Function(String id) onDelete;

  const _DateSection({
    required this.label,
    required this.entries,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        ),
        ...entries.map((e) => _JournalTile(entry: e, onDelete: onDelete)),
      ],
    );
  }
}

// ── Journal tile ───────────────────────────────────────────────────────────────

class _JournalTile extends StatelessWidget {
  final JournalEntry entry;
  final void Function(String id) onDelete;

  const _JournalTile({required this.entry, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final hasLink   = entry.linkedPhilosophy != null;
    final timeStr   = '${entry.createdAt.hour.toString().padLeft(2, '0')}:'
        '${entry.createdAt.minute.toString().padLeft(2, '0')}';

    return Dismissible(
      key: Key(entry.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFF3B30).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.delete_outline_rounded,
            color: Color(0xFFFF3B30), size: 22),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: AppColors.surface,
            title: const Text('Delete entry?',
                style: TextStyle(color: AppColors.textPrimary)),
            content: const Text('This can\'t be undone.',
                style: TextStyle(color: AppColors.textSecondary)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel',
                    style: TextStyle(color: AppColors.textMuted)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete',
                    style: TextStyle(color: Color(0xFFFF3B30))),
              ),
            ],
          ),
        ) ?? false;
      },
      onDismissed: (_) => onDelete(entry.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.surfaceAlt),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Linked philosophy + time
            Row(
              children: [
                if (hasLink) ...[
                  Text(entry.linkedIcon!,
                      style: const TextStyle(fontSize: 13)),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      entry.linkedPhilosophy!,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ] else
                  const Spacer(),
                Text(
                  timeStr,
                  style: const TextStyle(
                      color: AppColors.textMuted, fontSize: 11),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Entry text
            Text(
              entry.text,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.55,
              ),
            ),
          ],
        ),
      ),
    );
  }
}