import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app.dart';
import '../core/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<int?> _answers = [null, null, null, null];
  bool _isAdvancing = false;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': "What's your biggest struggle right now?",
      'options': [
        'Procrastination / lack of motivation',
        'Feeling overwhelmed / anxious',
        'Relationship or social pressure',
        'Lack of direction / purpose',
      ],
    },
    {
      'question': 'What do you want most in the next 3 months?',
      'options': [
        'Discipline & consistency',
        'Inner peace & clarity',
        'Creative breakthroughs',
        'Better connections with people',
      ],
    },
    {
      'question': 'Which phrase resonates with you?',
      'options': [
        '“Action cures fear.”',
        '“Let go of what you can’t control.”',
        '“Originality is the key.”',
        '“We are shaped by those we love.”',
      ],
    },
    {
      'question': 'When you face a setback, you usually…',
      'options': [
        'Push harder and grind through',
        'Reflect and adjust your mindset',
        'Look for a creative workaround',
        'Seek advice from someone you trust',
      ],
    },
  ];

  static const Map<int, String> _philosophyMap = {
    0: 'spartan_discipline',
    1: 'marcus_aurelius',
    2: 'diogenes',
    3: 'nietzsche',
  };

  String _computePhilosophyId() {
    final counts = <String, int>{};
    String? firstChoice;
    for (final answer in _answers) {
      if (answer == null) continue;
      final id = _philosophyMap[answer]!;
      firstChoice ??= id;
      counts[id] = (counts[id] ?? 0) + 1;
    }
    if (counts.isEmpty) return 'spartan_discipline';
    String best = counts.keys.first;
    for (final id in counts.keys) {
      if (counts[id]! > counts[best]! ||
          (counts[id] == counts[best] && id == firstChoice)) {
        best = id;
      }
    }
    return best;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goBack() {
    if (_isAdvancing || _currentPage == 0) return;
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => _currentPage--);
  }

  void _onOptionSelected(int optionIndex) {
    if (_isAdvancing) return;
    _isAdvancing = true;

    final bool isLastPage = _currentPage == _questions.length - 1;

    setState(() {
      _answers[_currentPage] = optionIndex;
      if (!isLastPage) _currentPage++;
    });

    if (isLastPage) {
      _finishOnboarding();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      ).then((_) {
        if (mounted) _isAdvancing = false;
      });
    }
  }

  void _skip() {
    if (_isAdvancing) return;
    _isAdvancing = true;
    for (int i = 0; i < _answers.length; i++) {
      _answers[i] ??= 0;
    }
    _finishOnboarding();
  }

  Future<void> _finishOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_done', true);
      await prefs.setString('primary_philosophy_id', _computePhilosophyId());
    } catch (_) {}
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainShell()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.bg,
              Color(0xFF1E1E1E),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: List.generate(
                    _questions.length,
                    (index) => Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: index <= _currentPage
                              ? AppColors.accent
                              : AppColors.surfaceAlt,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _questions.length,
                  itemBuilder: (_, index) => _buildQuestionPage(index),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage > 0)
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: AppColors.textMuted),
                        onPressed: _goBack,
                      )
                    else
                      const SizedBox(width: 48),
                    if (_currentPage < _questions.length - 1)
                      TextButton(
                        onPressed: _isAdvancing ? null : _skip,
                        child: const Text(
                          'Skip →',
                          style: TextStyle(color: AppColors.textMuted),
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionPage(int index) {
    final question = _questions[index]['question'] as String;
    final options = List<String>.from(_questions[index]['options'] as List);
    final selected = _answers[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 40),
          ...options.asMap().entries.map((entry) {
            final idx = entry.key;
            final text = entry.value;
            final isSelected = selected == idx;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => _onOptionSelected(idx),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.accent.withValues(alpha: 0.1)
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? AppColors.accent : AppColors.surfaceAlt,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? AppColors.accent : Colors.transparent,
                          border: Border.all(
                            color: isSelected ? AppColors.accent : AppColors.textMuted,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, size: 16, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}