import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../core/app_colors.dart';
import '../models/journal_entry.dart';
import '../providers/journal_provider.dart';
import '../providers/diagnosis_history_provider.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _addEntry() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;

    // Link to last diagnosis if one exists
    final last = context.read<DiagnosisHistoryProvider>().lastDiagnosis;

    final entry = JournalEntry(
      id:               const Uuid().v4(),
      text:             text,
      linkedPhilosophy: last?.result.philosophy,
      linkedIcon:       last?.result.icon,
      createdAt:        DateTime.now(),
    );

    await context.read<JournalProvider>().addEntry(entry);
    _ctrl.clear();
    FocusScope.of(context).unfocus();
  }

  void _deleteEntry(String id) {
    context.read<JournalProvider>().deleteEntry(id);
  }

  @override
  Widget build(BuildContext context) {
    final journal = context.watch<JournalProvider>().journal;

    // Group entries by date label
    final grouped = <String, List<JournalEntry>>{};
    for (final e in journal) {
      final label = _dateLabel(e.createdAt);
      grouped.putIfAbsent(label, () []).add(e);
    }

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: ShaderMask(
                shaderCallback: (b) => const LinearGradient(
                  colors: [Color(0xFFBF5AF2), Color(0xFF64D2FF)],
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
            ),

            const SizedBox(height: 16),

            // Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.surfaceAlt),
                      ),
                      child: TextField(
                        controller: _ctrl,
                        style: const TextStyle(
                            color: AppColors.textPrimary, fontSize: 14, height: 1.5),
                        maxLines: 3,
                        minLines: 1,
                        decoration: const InputDecoration(
                          hintText: 'Write your thoughts…',
                          hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _addEntry,
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFBF5AF2), Color(0xFF5E5CE6)],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.add_rounded, color: Colors.white, size: 22),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Entries list
            Expanded(
              child: journal.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('📓', style: TextStyle(fontSize: 40)),
                          SizedBox(height: 12),
                          Text(
                            'No entries yet.',
                            style: TextStyle(
                                color: AppColors.textMuted, fontSize: 14),
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
                      children: grouped.entries
                          .map((g) => _DateSection(
                                label: g.key,
                                entries: g.value,
                                onDelete: _deleteEntry,
                              ))
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _dateLabel(DateTime dt) {
    final now  = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date  = DateTime(dt.year, dt.month, dt.day);
    final diff  = today.difference(date).inDays;
    if (diff == 0) return 'TODAY';
    if (diff == 1) return 'YESTERDAY';
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${months[dt.month - 1].toUpperCase()} ${dt.day}';
  }
}
