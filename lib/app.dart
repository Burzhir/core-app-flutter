import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_colors.dart';
import 'core/app_theme.dart';
import 'core/theme_provider.dart';
import 'screens/today_screen.dart';
import 'screens/diagnose_screen.dart';
import 'screens/isms_screen.dart';
import 'screens/journal_screen.dart';
import 'screens/profile_screen.dart';
import '../onboarding/onboarding_screen.dart';

class CoreApp extends StatelessWidget {
  final bool showOnboarding;
  const CoreApp({super.key, this.showOnboarding = false});

  @override
  Widget build(BuildContext context) {
    // FIX: Consume ThemeProvider so the app actually responds to theme changes
    return Consumer<ThemeProvider>(
      builder: (_, themeProvider, __) {
        return MaterialApp(
          title: 'CORE',
          debugShowCheckedModeBanner: false,
          // FIX: Use AppTheme.dark() / AppTheme.light() instead of hardcoded ThemeData
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: themeProvider.mode,
          home: showOnboarding ? const OnboardingScreen() : const MainShell(),
        );
      },
    );
  }
}

// ── Main shell ─────────────────────────────────────────────────────────────────

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    TodayScreen(),
    DiagnoseScreen(),
    IsmsScreen(),
    JournalScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _NavBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

// ── Bottom nav bar ─────────────────────────────────────────────────────────────

class _NavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _NavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: Color(0xFF2A2445), width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(icon: Icons.wb_sunny_outlined, activeIcon: Icons.wb_sunny,         label: 'Today',    index: 0, currentIndex: currentIndex, onTap: onTap),
              _NavItem(icon: Icons.flash_on_outlined, activeIcon: Icons.flash_on,         label: 'Diagnose', index: 1, currentIndex: currentIndex, onTap: onTap),
              _NavItem(icon: Icons.library_books_outlined, activeIcon: Icons.library_books, label: 'Library',  index: 2, currentIndex: currentIndex, onTap: onTap),
              _NavItem(icon: Icons.book_outlined,     activeIcon: Icons.book,             label: 'Journal',  index: 3, currentIndex: currentIndex, onTap: onTap),
              _NavItem(icon: Icons.person_outline,    activeIcon: Icons.person,           label: 'Profile',  index: 4, currentIndex: currentIndex, onTap: onTap),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isActive ? activeIcon : icon,
                key: ValueKey(isActive),
                color: isActive ? AppColors.accent : AppColors.textMuted,
                size: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppColors.accent : AppColors.textMuted,
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
