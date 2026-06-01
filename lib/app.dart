import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_colors.dart';
import 'core/app_theme.dart';
import 'providers/auth_provider.dart' as core;
import 'screens/auth_screen.dart';
import 'screens/today_screen.dart';
import 'screens/forge_screen.dart';
import 'screens/library_screen.dart';
import 'screens/journal_screen.dart';
import 'screens/profile_screen.dart';
import 'onboarding/onboarding_screen.dart';

class CoreApp extends StatelessWidget {
  final bool showOnboarding;
  const CoreApp({super.key, this.showOnboarding = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CORE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      home: _RootRouter(showOnboarding: showOnboarding),
    );
  }
}

class _RootRouter extends StatelessWidget {
  final bool showOnboarding;
  const _RootRouter({required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<core.AuthProvider>();
    switch (auth.status) {
      case core.AuthStatus.unknown:
        return const _SplashScreen();
      case core.AuthStatus.unauthenticated:
        return const AuthScreen();
      case core.AuthStatus.authenticated:
        if (showOnboarding) return const OnboardingScreen();
        return const MainShell();
    }
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.bg,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('CORE',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 10,
                  fontFamily: 'Outfit',
                )),
            SizedBox(height: 8),
            Text('Forge Yourself',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 14,
                  letterSpacing: 3,
                )),
          ],
        ),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _screens = [
    TodayScreen(),
    ForgeScreen(),
    LibraryScreen(),
    JournalScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: _NavBar(
        index: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  final int _index;
  final ValueChanged<int> onTap;
  const _NavBar({required int index, required this.onTap}) : _index = index;

  static const _items = [
    (Icons.wb_sunny_outlined, Icons.wb_sunny, 'Today'),
    (Icons.compare_arrows_outlined, Icons.compare_arrows, 'Forge'),
    (Icons.auto_stories_outlined, Icons.auto_stories, 'Library'),
    (Icons.book_outlined, Icons.book, 'Journal'),
    (Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: const Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _items.asMap().entries.map((e) {
              final i = e.key;
              final item = e.value;
              final active = i == _index;
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 64,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: active ? 20 : 0,
                        height: 2,
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          gradient: active
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFFBF5AF2),
                                    Color(0xFF64D2FF)
                                  ],
                                )
                              : null,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          active ? item.$2 : item.$1,
                          key: ValueKey(active),
                          color:
                              active ? AppColors.accent : AppColors.textMuted,
                          size: 22,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(item.$3,
                          style: TextStyle(
                            color:
                                active ? AppColors.accent : AppColors.textMuted,
                            fontSize: 10,
                            fontWeight:
                                active ? FontWeight.w700 : FontWeight.w400,
                            fontFamily: 'Outfit',
                          )),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
