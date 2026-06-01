import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../providers/auth_provider.dart' as core;
import '../screens/paywall_screen.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Header ─────────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 8),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'JOURNAL',
                            style: TextStyle(
                              color:         AppColors.accent,
                              fontSize:      13,
                              fontWeight:    FontWeight.w800,
                              letterSpacing: 4,
                              fontFamily:    'Outfit',
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Reflect & grow',
                            style: TextStyle(
                              color:      AppColors.textPrimary,
                              fontSize:   26,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Outfit',
                              height:     1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _openNewEntry(context),
                      child: Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [AppColors.accent, Color(0xFF5E5CE6)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:      AppColors.accent.withValues(alpha: 0.35),
                              blurRadius: 12,
                              offset:     const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.add_rounded, color: Colors.white, size: 22),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Today's prompt card ────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                child: _DailyPromptCard(onTap: () => _openNewEntry(context)),
              ),
            ),

            // ── Entries list ───────────────────────────────────────────────
            const _JournalEntriesList(),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  void _openNewEntry(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _NewEntrySheet(),
    );
  }
}

// ── Daily prompt card ─────────────────────────────────────────────────────────

class _DailyPromptCard extends StatelessWidget {
  final VoidCallback onTap;
  const _DailyPromptCard({required this.onTap});

  static const _prompts = [
    'What is one belief you hold that you have never truly examined?',
    'Describe a moment today where you chose comfort over courage.',
    'What would your ideal self have done differently today?',
    'What are you most resistant to right now — and why?',
    'Where did you give away your agency today?',
    'What are you pretending not to know?',
    'What would you do if you knew it would fail?',
  ];

  String get _todayPrompt {
    final day = DateTime.now().weekday - 1;
    return _prompts[day % _prompts.length];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end:   Alignment.bottomRight,
            colors: [
              AppColors.accent.withValues(alpha: 0.15),
              const Color(0xFF5E5CE6).withValues(alpha: 0.08),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color:        AppColors.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'TODAY\'S PROMPT',
                    style: TextStyle(
                      color:         AppColors.accent,
                      fontSize:      9,
                      fontWeight:    FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.edit_note_rounded, color: AppColors.accent, size: 18),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '"$_todayPrompt"',
              style: const TextStyle(
                color:     AppColors.textPrimary,
                fontSize:  16,
                height:    1.5,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Text(
                  'Write your reflection',
                  style: TextStyle(
                    color:      AppColors.accent,
                    fontSize:   13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward_rounded, color: AppColors.accent, size: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Journal entries list ──────────────────────────────────────────────────────

class _JournalEntriesList extends StatelessWidget {
  const _JournalEntriesList();

  @override
  Widget build(BuildContext context) {
    // Placeholder: entries are stored via Firestore in the actual integration.
    // For now, show an empty state so the screen is fully functional.
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PAST ENTRIES',
              style: TextStyle(
                color:         AppColors.textMuted,
                fontSize:      11,
                fontWeight:    FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            _EmptyJournal(),
          ],
        ),
      ),
    );
  }
}

class _EmptyJournal extends StatelessWidget {
  const _EmptyJournal();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border:       Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentSoft,
            ),
            child: const Icon(Icons.book_outlined, color: AppColors.accent, size: 28),
          ),
          const SizedBox(height: 16),
          const Text(
            'No entries yet',
            style: TextStyle(
              color:      AppColors.textPrimary,
              fontSize:   16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Outfit',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your reflections will appear here.\nStart with today\'s prompt above.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color:    AppColors.textMuted,
              fontSize: 13,
              height:   1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── New entry sheet ───────────────────────────────────────────────────────────

class _NewEntrySheet extends StatefulWidget {
  const _NewEntrySheet();

  @override
  State<_NewEntrySheet> createState() => _NewEntrySheetState();
}

class _NewEntrySheetState extends State<_NewEntrySheet> {
  final _ctrl = TextEditingController();
  String _mood = '';

  static const _moods = ['😤', '😔', '😐', '🙂', '🔥'];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, bottomInset),
      decoration: const BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40, height: 4,
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            decoration: BoxDecoration(
              color:        AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'New entry',
                style: TextStyle(
                  color:      AppColors.textPrimary,
                  fontSize:   20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Outfit',
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Mood selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const Text(
                  'Mood  ',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                ),
                ..._moods.map((m) => GestureDetector(
                  onTap: () => setState(() => _mood = m),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _mood == m ? AppColors.accentSoft : Colors.transparent,
                      border: _mood == m
                          ? Border.all(color: AppColors.accent.withValues(alpha: 0.5))
                          : null,
                    ),
                    child: Text(m, style: const TextStyle(fontSize: 22)),
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Text field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextField(
              controller:    _ctrl,
              autofocus:     true,
              maxLines:      8,
              minLines:      5,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 15, height: 1.6),
              decoration: InputDecoration(
                hintText:        'Write what\'s on your mind…',
                hintStyle:       const TextStyle(color: AppColors.textMuted),
                filled:          true,
                fillColor:       AppColors.surfaceAlt,
                border:          OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:   BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Save button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: GestureDetector(
              onTap: () {
                if (_ctrl.text.trim().isEmpty) return;
                // TODO: save to Firestore in production
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Entry saved'),
                    backgroundColor: AppColors.surface,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.accent, Color(0xFF5E5CE6)]),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color:      AppColors.accent.withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset:     const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Save entry',
                    style: TextStyle(
                      color:      Colors.white,
                      fontSize:   15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
