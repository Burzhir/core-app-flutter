import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_state.dart';
import '../data/isms_data.dart';
import '../widgets/isms_art.dart';        // ✅ updated import

// ═══════════════════════════════════════════════════════════════════════════════
// Isms Screen — browsable grid of all 21 philosophical isms.
// Top section shows which isms the user has been matched to most.
// ═══════════════════════════════════════════════════════════════════════════════

class IsmsScreen extends StatefulWidget {
  const IsmsScreen({super.key});
  @override
  State<IsmsScreen> createState() => _IsmsScreenState();
}

class _IsmsScreenState extends State<IsmsScreen> {
  String _search = '';

  List<IsmMeta> get _filtered {
    if (_search.isEmpty) return kIsms;
    final q = _search.toLowerCase();
    return kIsms
        .where((ism) =>
            ism.name.toLowerCase().contains(q) ||
            ism.tagline.toLowerCase().contains(q))
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
                  final top = state.topIsms;        // ✅ new getter
                  return CustomScrollView(
                    slivers: [
                      if (top.isNotEmpty && _search.isEmpty) ...[
                        SliverToBoxAdapter(child: _buildYourMatchesSection(top)),
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
                                  color: AppColors.textMuted, fontSize: 11,
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
                            (_, i) => _IsmCard(
                              ism: _filtered[i],
                              isMatched: top.any((e) => e.key == _filtered[i].name),
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
                color: Colors.white, fontSize: 22,
                fontWeight: FontWeight.w900, letterSpacing: 4,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${kIsms.length} frameworks. One for every battle.',
            style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    // identical to before, just search hint text changed
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
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'Search isms…',
            hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
            prefixIcon: Icon(Icons.search_rounded, color: AppColors.textMuted, size: 18),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildYourMatchesSection(List<MapEntry<String, int>> top) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Text(
            'YOUR MOST MATCHED',
            style: TextStyle(
              color: AppColors.textMuted, fontSize: 11,
              fontWeight: FontWeight.w700, letterSpacing: 2,
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
              // find ism by name (key)
              final ism = kIsms.firstWhere(
                (i) => i.name == entry.key,
                orElse: () => kIsms.first,
              );
              final colors = ism.gradientColors;
              return Container(
                width: 180,
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors[0].withValues(alpha: 0.2),
                      colors[1].withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: colors[0].withValues(alpha: 0.35)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: IsmArtWidget(
                        ism: ism,
                        colors: colors,
                        height: 56,
                        width: 56,
                        animated: false,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ism.name,
                            style: const TextStyle(
                              color: AppColors.textPrimary, fontSize: 12,
                              fontWeight: FontWeight.w700, height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${entry.value}× matched',
                            style: TextStyle(
                              color: colors[0], fontSize: 11,
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

// ── Individual card in grid ──────────────────────────────────────────────────

class _IsmCard extends StatelessWidget {
  final IsmMeta ism;
  final bool isMatched;
  final int  matchCount;

  const _IsmCard({
    required this.ism,
    required this.isMatched,
    required this.matchCount,
  });

  @override
  Widget build(BuildContext context) {
    final gradColors = ism.gradientColors;

    return GestureDetector(
      onTap: () => _openDetail(context, gradColors),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradColors[0].withValues(alpha: isMatched ? 0.22 : 0.12),
              gradColors[1].withValues(alpha: isMatched ? 0.12 : 0.06),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: gradColors[0].withValues(alpha: isMatched ? 0.5 : 0.25),
            width: isMatched ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Art + matched badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: IsmArtWidget(
                    ism: ism,
                    colors: gradColors,
                    height: 56,
                    width: 56,
                    animated: false,
                  ),
                ),
                const Spacer(),
                if (isMatched)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: gradColors[0].withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$matchCount×',
                      style: TextStyle(
                        color: gradColors[0], fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
              ],
            ),
            const Spacer(),
            Text(
              ism.name,
              style: const TextStyle(
                color: AppColors.textPrimary, fontSize: 13,
                fontWeight: FontWeight.w800, height: 1.25,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              ism.category,  // e.g. "meaning_existence"
              style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              ism.tagline,
              style: TextStyle(
                color: AppColors.textSecondary.withValues(alpha: 0.8),
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
      builder: (_) => _IsmDetailSheet(ism: ism, gradColors: gradColors),
    );
  }
}

// ── Detail sheet ─────────────────────────────────────────────────────────────

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
          // Drag handle
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Art header
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: IsmArtWidget(
              ism: ism,
              colors: gradColors,
              height: 180,
            ),
          ),
          const SizedBox(height: 20),

          // Icon + name + category
          Row(
            children: [
              Text(ism.icon, style: const TextStyle(fontSize: 40)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ism.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary, fontSize: 20,
                        fontWeight: FontWeight.w800, height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(ism.category,
                        style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: AppColors.surfaceAlt),
          const SizedBox(height: 16),

          // Tagline
          Text(
            '"${ism.tagline}"',
            style: TextStyle(
              color: gradColors[0], fontSize: 16,
              fontStyle: FontStyle.italic, fontWeight: FontWeight.w600, height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // Overview
          _buildSectionTitle('OVERVIEW', gradColors),
          const SizedBox(height: 8),
          Text(ism.overview, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.7)),
          const SizedBox(height: 24),

          // Historical context
          _buildSectionTitle('HISTORICAL CONTEXT', gradColors),
          const SizedBox(height: 8),
          Text(ism.historicalContext, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.7)),
          const SizedBox(height: 24),

          // Core tenets (list of strings)
          _buildSectionTitle('CORE TENETS', gradColors),
          const SizedBox(height: 8),
          ...ism.coreTenets.map((t) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: AppColors.textMuted)),
                    Expanded(
                      child: Text(t, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5)),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 24),

          // Notable Figures
          _buildSectionTitle('NOTABLE FIGURES', gradColors),
          const SizedBox(height: 8),
          ...ism.notableFigures.map((nf) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nf.name, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(nf.contribution, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.4)),
                  ],
                ),
              )),
          const SizedBox(height: 24),

          // Modern application
          _buildSectionTitle('MODERN APPLICATION', gradColors),
          const SizedBox(height: 8),
          Text(ism.modernApplication, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.7)),
          const SizedBox(height: 24),

          // Quotes (strings)
          _buildSectionTitle('QUOTES', gradColors),
          const SizedBox(height: 8),
          ...ism.quotes.map((q) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  q,
                  style: TextStyle(
                    color: gradColors[0], fontSize: 13,
                    fontStyle: FontStyle.italic, height: 1.5,
                  ),
                ),
              )),
          const SizedBox(height: 24),

          // Key works
          _buildSectionTitle('KEY WORKS', gradColors),
          const SizedBox(height: 8),
          ...ism.keyWorks.map((w) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: AppColors.textMuted)),
                    Expanded(
                      child: Text(w, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5)),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 24),

          // Challenge box
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gradColors[0].withValues(alpha: 0.15), gradColors[1].withValues(alpha: 0.08)],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: gradColors[0].withValues(alpha: 0.35), width: 1.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.bolt_rounded, color: gradColors[0], size: 16),
                    const SizedBox(width: 6),
                    Text('THE CHALLENGE', style: TextStyle(color: gradColors[0], fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(ism.challenge, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.6)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, List<Color> colors) {
    return Row(
      children: [
        Container(width: 4, height: 14, decoration: BoxDecoration(color: colors[0], borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 8),
        Text(title, style: TextStyle(color: colors[0], fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 2)),
      ],
    );
  }
}