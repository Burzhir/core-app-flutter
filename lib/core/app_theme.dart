import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// CoreColors — ThemeExtension for dual-theme support.
// Access via: context.coreColors.bg  (see extension below)
// ═══════════════════════════════════════════════════════════════════════════════

@immutable
class CoreColors extends ThemeExtension<CoreColors> {
  final Color bg;
  final Color surface;
  final Color surfaceAlt;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color accent;
  final Color accentSoft;
  final Color inputFill;

  const CoreColors({
    required this.bg,
    required this.surface,
    required this.surfaceAlt,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.accent,
    required this.accentSoft,
    required this.inputFill,
  });

  @override
  CoreColors copyWith({
    Color? bg, Color? surface, Color? surfaceAlt, Color? border,
    Color? textPrimary, Color? textSecondary, Color? textMuted,
    Color? accent, Color? accentSoft, Color? inputFill,
  }) {
    return CoreColors(
      bg:            bg            ?? this.bg,
      surface:       surface       ?? this.surface,
      surfaceAlt:    surfaceAlt    ?? this.surfaceAlt,
      border:        border        ?? this.border,
      textPrimary:   textPrimary   ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted:     textMuted     ?? this.textMuted,
      accent:        accent        ?? this.accent,
      accentSoft:    accentSoft    ?? this.accentSoft,
      inputFill:     inputFill     ?? this.inputFill,
    );
  }

  @override
  CoreColors lerp(CoreColors? other, double t) {
    if (other is! CoreColors) return this;
    return CoreColors(
      bg:            Color.lerp(bg,            other.bg,            t)!,
      surface:       Color.lerp(surface,       other.surface,       t)!,
      surfaceAlt:    Color.lerp(surfaceAlt,    other.surfaceAlt,    t)!,
      border:        Color.lerp(border,        other.border,        t)!,
      textPrimary:   Color.lerp(textPrimary,   other.textPrimary,   t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted:     Color.lerp(textMuted,     other.textMuted,     t)!,
      accent:        Color.lerp(accent,        other.accent,        t)!,
      accentSoft:    Color.lerp(accentSoft,    other.accentSoft,    t)!,
      inputFill:     Color.lerp(inputFill,     other.inputFill,     t)!,
    );
  }

  // ── Presets ────────────────────────────────────────────────────────────────

  static const CoreColors dark = CoreColors(
    bg:            Color(0xFF0E0B1A),
    surface:       Color(0xFF1A1530),
    surfaceAlt:    Color(0xFF231E3D),
    border:        Color(0xFF2A2445),
    textPrimary:   Color(0xFFFFFFFF),
    textSecondary: Color(0xFFB0A8D0),
    textMuted:     Color(0xFF6B6490),
    accent:        Color(0xFFBF5AF2),
    accentSoft:    Color(0x22BF5AF2),
    inputFill:     Color(0xFF1A1530),
  );

  static const CoreColors light = CoreColors(
    bg:            Color(0xFFF7F5FF),
    surface:       Color(0xFFFFFFFF),
    surfaceAlt:    Color(0xFFEDE9FF),
    border:        Color(0xFFDDD8F5),
    textPrimary:   Color(0xFF0E0B1A),
    textSecondary: Color(0xFF3D3460),
    textMuted:     Color(0xFF8B83B0),
    accent:        Color(0xFF7B2FBE),
    accentSoft:    Color(0x187B2FBE),
    inputFill:     Color(0xFFFFFFFF),
  );
}

// ── Context shorthand ──────────────────────────────────────────────────────────
extension CoreColorsX on BuildContext {
  CoreColors get coreColors =>
      Theme.of(this).extension<CoreColors>() ?? CoreColors.dark;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

// ═══════════════════════════════════════════════════════════════════════════════
// AppTheme — creates ThemeData for light and dark modes
// ═══════════════════════════════════════════════════════════════════════════════

class AppTheme {
  AppTheme._();

  static ThemeData dark() => _build(CoreColors.dark, Brightness.dark);
  static ThemeData light() => _build(CoreColors.light, Brightness.light);

  static ThemeData _build(CoreColors c, Brightness brightness) {
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: c.bg,
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness:   brightness,
        primary:      c.accent,
        onPrimary:    Colors.white,
        secondary:    c.accent,
        onSecondary:  Colors.white,
        surface:      c.surface,
        onSurface:    c.textPrimary,
        error:        const Color(0xFFFF3B30),
        onError:      Colors.white,
      ),
      extensions: [c],

      // Text theme
      textTheme: TextTheme(
        displayLarge:  TextStyle(color: c.textPrimary,   fontWeight: FontWeight.w900),
        displayMedium: TextStyle(color: c.textPrimary,   fontWeight: FontWeight.w800),
        headlineLarge: TextStyle(color: c.textPrimary,   fontWeight: FontWeight.w800),
        headlineMedium:TextStyle(color: c.textPrimary,   fontWeight: FontWeight.w700),
        bodyLarge:     TextStyle(color: c.textSecondary, fontWeight: FontWeight.w400),
        bodyMedium:    TextStyle(color: c.textSecondary, fontWeight: FontWeight.w400),
        labelLarge:    TextStyle(color: c.textMuted,     fontWeight: FontWeight.w600),
      ),

      // Bottom nav bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor:      c.surface,
        selectedItemColor:    c.accent,
        unselectedItemColor:  c.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Input fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: c.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: c.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: c.accent, width: 1.5),
        ),
        hintStyle: TextStyle(color: c.textMuted),
      ),

      // Page transitions
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: _FadeSlideTransitionBuilder(),
          TargetPlatform.iOS:     _FadeSlideTransitionBuilder(),
        },
      ),
    );
  }
}

// ── Custom page transition ─────────────────────────────────────────────────────

class _FadeSlideTransitionBuilder extends PageTransitionsBuilder {
  const _FadeSlideTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.03),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: child,
      ),
    );
  }
}