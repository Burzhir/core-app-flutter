import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_state.dart';
import '../data/philosophies_data.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// Philosophies Screen — browsable grid of all 15 philosophies.
// Top section shows which ones the user has been matched to most.
// ═══════════════════════════════════════════════════════════════════════════════

class PhilosophiesScreen extends StatefulWidget {
  const PhilosophiesScreen({super.key});

  @override
  State<PhilosophiesScreen> createState() => _PhilosophiesScreenState();
}

class _PhilosophiesScreenState extends State<PhilosophiesScreen> {
  String _search = '';

  List<PhilosophyMeta> get _filtered {
    if (_search.isEmpty) return kPhilosophies;
    final q = _search.toLowerCase();
    return kPhilosophies
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.thinker.toLowerCase().contains(q) ||
            p.tagline.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(
              child: Consumer<AppState>(
                builder: (_, state, __) {
                  final top = state.topPhilosophies;
                  return CustomScrollView(
                    slivers: [
                      if (top.isNotEmpty && _search.isEmpty) ...[
                        SliverToBoxAdapter(
                          child: _buildYourMatchesSection(top),
                        ),
                      ],
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                          child: Row(
                            children: [
                              const Text(
                                'ALL PHILOSOPHIES',
                                style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${_filtered.length}',
                                style: const TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.85,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (_, i) => _PhilosophyCard(
                              philosophy: _filtered[i],
                              isMatched: top.any(
                                (e) => e.key == _filtered[i].name,
                              ),
                              matchCount: top
                                  .where((e) => e.key == _filtered[i].name)
                                  .map((e) => e.value)
                                  .firstOrNull ?? 0,
                            ),
                            childCount: _filtered.length,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (b) => const LinearGradient(
              colors: [Color(0xFFBF5AF2), Color(0xFF64D2FF)],
            ).createShader(b),
            child: const Text(
              'LIBRARY',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '15 frameworks. One for every battle.',
            style: TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // ── Search bar ─────────────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.surfaceAlt),
        ),
        child: TextField(
          onChanged: (v) => setState(() => _search = v),
          style: const TextStyle(
              color: AppColors.textPrimary, fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'Search thinkers, philosophies…',
            hintStyle:
                TextStyle(color: AppColors.textMuted, fontSize: 14),
            prefixIcon: Icon(Icons.search_rounded,
                color: AppColors.textMuted, size: 18),
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ),
    );
  }

  // ── "Your matches" horizontal strip ───────────────────────────────────────

  Widget _buildYourMatchesSection(List<MapEntry<String, int>> top) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Text(
            'YOUR MOST MATCHED',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: top.length,
            itemBuilder: (_, i) {
              final entry = top[i];
              final meta = kPhilosophies.firstWhere(
                (p) => p.name == entry.key,
                orElse: () => kPhilosophies.first,
              );
              final colors = AppColors.gradientFor(meta.name);
              return Container(
                width: 180,
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors[0].withOpacity(0.2),
                      colors[1].withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: colors[0].withOpacity(0.35)),
                ),
                child: Row(
                  children: [
                    Text(meta.icon,
                        style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            meta.name,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${entry.value}× matched',
                            style: TextStyle(
                              color: colors[0],
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ── Philosophy card ────────────────────────────────────────────────────────────

class _PhilosophyCard extends StatelessWidget {
  final PhilosophyMeta philosophy;
  final bool isMatched;
  final int  matchCount;

  const _PhilosophyCard({
    required this.philosophy,
    required this.isMatched,
    required this.matchCount,
  });

  @override
  Widget build(BuildContext context) {
    final gradColors = AppColors.gradientFor(philosophy.name);

    return GestureDetector(
      onTap: () => _openDetail(context, gradColors),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradColors[0].withOpacity(isMatched ? 0.22 : 0.12),
              gradColors[1].withOpacity(isMatched ? 0.12 : 0.06),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: gradColors[0].withOpacity(isMatched ? 0.5 : 0.25),
            width: isMatched ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon + matched badge row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(philosophy.icon,
                    style: const TextStyle(fontSize: 30)),
                const Spacer(),
                if (isMatched)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: gradColors[0].withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${matchCount}×',
                      style: TextStyle(
                        color: gradColors[0],
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
              ],
            ),
            const Spacer(),

            // Name
            Text(
              philosophy.name,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                height: 1.25,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // Thinker
            Text(
              philosophy.thinker,
              style: const TextStyle(
                  color: AppColors.textMuted, fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Tagline
            Text(
              philosophy.tagline,
              style: TextStyle(
                color: AppColors.textSecondary.withOpacity(0.8),
                fontSize: 11,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, List<Color> gradColors) {
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

// ── Detail sheet ───────────────────────────────────────────────────────────────

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
      initialChildSize: 0.65,
      maxChildSize: 0.93,
      minChildSize: 0.4,
      expand: false,
      builder: (_, ctrl) => ListView(
        controller: ctrl,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
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

          // Header
          Row(
            children: [
              Text(philosophy.icon,
                  style: const TextStyle(fontSize: 48)),
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

          // Gradient divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  gradColors[0].withOpacity(0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Tagline
          Text(
            '"${philosophy.tagline}"',
            style: TextStyle(
              color: gradColors[0],
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            philosophy.description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 24),

          // Challenge box
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  gradColors[0].withOpacity(0.15),
                  gradColors[1].withOpacity(0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: gradColors[0].withOpacity(0.35), width: 1.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.bolt_rounded,
                        color: gradColors[0], size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'THE CHALLENGE',
                      style: TextStyle(
                        color: gradColors[0], fontSize: 10,
                        fontWeight: FontWeight.w800, letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
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