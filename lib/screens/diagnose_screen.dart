import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../core/app_colors.dart';
import '../core/app_config.dart';
import '../core/app_state.dart';
import '../models/philosophy_result.dart';
import '../models/history_entry.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// Diagnose Screen
// ═══════════════════════════════════════════════════════════════════════════════

class DiagnoseScreen extends StatefulWidget {
  const DiagnoseScreen({super.key});

  @override
  State<DiagnoseScreen> createState() => _DiagnoseScreenState();
}

class _DiagnoseScreenState extends State<DiagnoseScreen>
    with TickerProviderStateMixin {
  final TextEditingController _controller  = TextEditingController();
  final ScrollController      _scroll      = ScrollController();
  final FocusNode             _focus       = FocusNode();

  PhilosophyResult? _result;
  bool    _loading  = false;
  String? _error;
  int     _charCount = 0;

  late final AnimationController _pulseCtrl;
  late final AnimationController _resultCtrl;
  late final Animation<double>   _pulseAnim;
  late final Animation<double>   _resultFade;
  late final Animation<Offset>   _resultSlide;

  @override
  void initState() {
    super.initState();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );

    _resultCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );

    _resultFade = CurvedAnimation(parent: _resultCtrl, curve: Curves.easeOut);

    _resultSlide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _resultCtrl, curve: Curves.easeOut));

    _controller.addListener(() {
      setState(() => _charCount = _controller.text.length);
    });

    _focus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    _focus.dispose();
    _pulseCtrl.dispose();
    _resultCtrl.dispose();
    super.dispose();
  }

  // ── API ────────────────────────────────────────────────────────────────────

  Future<void> _getGuidance() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _focus.unfocus();
    setState(() { _loading = true; _error = null; _result = null; });
    _resultCtrl.reset();

    try {
      final response = await http.post(
        Uri.parse(AppConfig.diagnoseEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'answers': [text]}),
      ).timeout(const Duration(seconds: 45));

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data   = jsonDecode(response.body) as Map<String, dynamic>;
        final result = PhilosophyResult.fromJson(data);

        setState(() { _result = result; _loading = false; });

        // Persist to shared state so Today/Profile/Journal can read it
        await context.read<AppState>().addDiagnosis(
          HistoryEntry(
            result:    result,
            userInput: text,
            timestamp: DateTime.now(),
          ),
        );

        await _resultCtrl.forward();

        await Future.delayed(const Duration(milliseconds: 150));
        if (_scroll.hasClients) {
          _scroll.animateTo(
            _scroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeOut,
          );
        }
      } else if (response.statusCode == 429) {
        if (!mounted) return;
        setState(() {
          _error   = 'Too many requests. Take a breath and try again.';
          _loading = false;
        });
      } else {
        if (!mounted) return;
        final data = jsonDecode(response.body) as Map<String, dynamic>?;
        setState(() {
          _error   = data?['error'] as String? ?? 'Server error ${response.statusCode}.';
          _loading = false;
        });
      }
    } on Exception catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString().contains('TimeoutException')
            ? 'Server took too long. Try again.'
            : 'No connection. Check your network.';
        _loading = false;
      });
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          _Background(accentColors: _result?.gradientColors),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scroll,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        _buildHeadline(),
                        const SizedBox(height: 20),
                        _buildInputCard(),
                        const SizedBox(height: 16),
                        _buildSubmitButton(),
                        if (_error != null) ...[
                          const SizedBox(height: 14),
                          _buildErrorBanner(),
                        ],
                        if (_result != null) ...[
                          const SizedBox(height: 28),
                          _buildResultCard(_result!),
                        ],
                        const SizedBox(height: 40),
                      ],
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

  // ── Header ─────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (b) => const LinearGradient(
              colors: [Color(0xFFBF5AF2), Color(0xFF64D2FF)],
            ).createShader(b),
            child: const Text(
              'DIAGNOSE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
              ),
            ),
          ),
          const Spacer(),
          // Show history count from shared AppState
          Consumer<AppState>(
            builder: (_, state, __) {
              if (state.history.isEmpty) return const SizedBox.shrink();
              return GestureDetector(
                onTap: () => _showHistorySheet(state.history),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.history_rounded,
                          size: 13, color: AppColors.textMuted),
                      const SizedBox(width: 4),
                      Text(
                        '${state.history.length}',
                        style: const TextStyle(
                            color: AppColors.textMuted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ── Headline ───────────────────────────────────────────────────────────────

  Widget _buildHeadline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What's in\nyour way?",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 36,
            fontWeight: FontWeight.w800,
            height: 1.1,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'No therapy. No hand-holding. Just the philosophy you need to move.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ── Input ──────────────────────────────────────────────────────────────────

  Widget _buildInputCard() {
    final nearLimit = _charCount > 1700;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _focus.hasFocus
              ? AppColors.accent.withOpacity(0.6)
              : AppColors.surfaceAlt,
          width: 1.5,
        ),
        boxShadow: _focus.hasFocus
            ? [BoxShadow(
                color: AppColors.accent.withOpacity(0.08),
                blurRadius: 20,
              )]
            : null,
      ),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            focusNode: _focus,
            style: const TextStyle(
                color: AppColors.textPrimary, fontSize: 16, height: 1.6),
            maxLines: 5,
            minLines: 3,
            maxLength: 2000,
            buildCounter: (_, {required currentLength,
                required isFocused, maxLength}) => null,
            decoration: const InputDecoration(
              hintText:
                  'I keep procrastinating on everything…\n'
                  'I feel like I\'m falling behind…\n'
                  'I\'m burned out but can\'t stop…',
              hintStyle: TextStyle(
                  color: AppColors.textMuted, fontSize: 15, height: 1.6),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '$_charCount / 2000',
                  style: TextStyle(
                    color: nearLimit
                        ? const Color(0xFFFF3B30)
                        : AppColors.textMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Submit button ──────────────────────────────────────────────────────────

  Widget _buildSubmitButton() {
    final canSubmit = !_loading && _charCount > 0;
    return ScaleTransition(
      scale: _pulseAnim,
      child: GestureDetector(
        onTap: canSubmit ? _getGuidance : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 56,
          decoration: BoxDecoration(
            gradient: canSubmit
                ? const LinearGradient(
                    colors: [Color(0xFFBF5AF2), Color(0xFF5E5CE6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: canSubmit ? null : AppColors.surfaceAlt,
            borderRadius: BorderRadius.circular(16),
            boxShadow: canSubmit
                ? [BoxShadow(
                    color: AppColors.accent.withOpacity(0.4),
                    blurRadius: 22,
                    offset: const Offset(0, 6),
                  )]
                : null,
          ),
          child: Center(
            child: _loading
                ? const SizedBox(
                    width: 22, height: 22,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.5, color: Colors.white),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        canSubmit ? 'DIAGNOSE ME' : 'SAY SOMETHING FIRST',
                        style: TextStyle(
                          color: canSubmit ? Colors.white : AppColors.textMuted,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.8,
                        ),
                      ),
                      if (canSubmit) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded,
                            color: Colors.white, size: 18),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  // ── Error ──────────────────────────────────────────────────────────────────

  Widget _buildErrorBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFF3B30).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: const Color(0xFFFF3B30).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: Color(0xFFFF3B30), size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(_error!,
                style: const TextStyle(
                    color: Color(0xFFFF6B6B), fontSize: 13, height: 1.4)),
          ),
        ],
      ),
    );
  }

  // ── Result card ────────────────────────────────────────────────────────────

  Widget _buildResultCard(PhilosophyResult r) {
    final grad = r.gradientColors;
    return FadeTransition(
      opacity: _resultFade,
      child: SlideTransition(
        position: _resultSlide,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section label
            Row(
              children: [
                Container(
                  width: 3, height: 14,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: grad,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'YOUR FRAMEWORK',
                  style: TextStyle(
                    color: grad[0], fontSize: 11,
                    fontWeight: FontWeight.w700, letterSpacing: 2,
                  ),
                ),
                const Spacer(),
                _SourceBadge(source: r.source, confidence: r.confidence),
              ],
            ),
            const SizedBox(height: 14),

            // Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    grad[0].withOpacity(0.18),
                    grad[1].withOpacity(0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: grad[0].withOpacity(0.35), width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Philosophy name + icon header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          grad[0].withOpacity(0.3),
                          grad[1].withOpacity(0.15),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(19)),
                    ),
                    child: Row(
                      children: [
                        Text(r.icon, style: const TextStyle(fontSize: 28)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            r.philosophy,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Gradient divider
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [grad[0].withOpacity(0.5), Colors.transparent],
                      ),
                    ),
                  ),

                  // Reason
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      r.reason,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        height: 1.65,
                      ),
                    ),
                  ),

                  // Keyword chips
                  if (r.matchedKeywords.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: r.matchedKeywords
                            .take(5)
                            .map((kw) => _KeywordChip(keyword: kw, color: grad[0]))
                            .toList(),
                      ),
                    ),
                ],
              ),
            ),

            // Action row
            const SizedBox(height: 12),
            Row(
              children: [
                _ActionButton(
                  icon: Icons.refresh_rounded,
                  label: 'Try Again',
                  onTap: () {
                    _controller.clear();
                    setState(() {
                      _result    = null;
                      _error     = null;
                      _charCount = 0;
                    });
                    _focus.requestFocus();
                  },
                ),
                const SizedBox(width: 10),
                _ActionButton(
                  icon: Icons.copy_rounded,
                  label: 'Copy',
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                      text: '${r.philosophy}\n\n${r.reason}',
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Copied to clipboard'),
                        backgroundColor: grad[0],
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── History sheet ──────────────────────────────────────────────────────────

  void _showHistorySheet(List<HistoryEntry> history) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _HistorySheet(history: history),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared sub-widgets (private to this file)
// ═══════════════════════════════════════════════════════════════════════════════

class _SourceBadge extends StatelessWidget {
  final String source;
  final String confidence;
  const _SourceBadge({required this.source, required this.confidence});

  @override
  Widget build(BuildContext context) {
    final isAi = source == 'groq';
    final color = isAi ? AppColors.accent : AppColors.textMuted;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAi ? Icons.auto_awesome_rounded : Icons.tag_rounded,
            size: 10, color: color,
          ),
          const SizedBox(width: 4),
          Text(
            isAi ? 'AI' : 'KEYWORDS',
            style: TextStyle(
              color: color, fontSize: 10,
              fontWeight: FontWeight.w700, letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _KeywordChip extends StatelessWidget {
  final String keyword;
  final Color  color;
  const _KeywordChip({required this.keyword, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Text(
        keyword,
        style: TextStyle(
          color: color.withOpacity(0.9), fontSize: 11, fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.surfaceAlt),
        ),
        child: Row(
          children: [
            Icon(icon, size: 15, color: AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _HistorySheet extends StatelessWidget {
  final List<HistoryEntry> history;
  const _HistorySheet({required this.history});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Container(
          width: 40, height: 4,
          decoration: BoxDecoration(
            color: AppColors.surfaceAlt,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'PAST DIAGNOSES',
              style: TextStyle(
                color: AppColors.textMuted, fontSize: 11,
                fontWeight: FontWeight.w700, letterSpacing: 2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            itemCount: history.length,
            itemBuilder: (_, i) => _HistoryTile(entry: history[i]),
          ),
        ),
      ],
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final HistoryEntry entry;
  const _HistoryTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    final colors = entry.result.gradientColors;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: colors[0], width: 3)),
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
                    color: AppColors.textPrimary, fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  entry.userInput,
                  style: const TextStyle(
                      color: AppColors.textMuted, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Background ──────────────────────────────────────────────────────────────

class _Background extends StatelessWidget {
  final List<Color>? accentColors;
  const _Background({this.accentColors});

  @override
  Widget build(BuildContext context) {
    final c1 = accentColors?[0] ?? AppColors.accent;
    final c2 = accentColors?[1] ?? const Color(0xFF5E5CE6);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(-0.8, -0.9),
          radius: 1.4,
          colors: [c1.withOpacity(0.12), AppColors.bg],
        ),
      ),
      child: CustomPaint(
        painter: _GridPainter(),
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.9, 0.8),
              radius: 1.0,
              colors: [c2.withOpacity(0.07), Colors.transparent],
            ),
          ),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.025)
      ..strokeWidth = 0.5;
    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter _) => false;
}