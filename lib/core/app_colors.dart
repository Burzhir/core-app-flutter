import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Base palette ───────────────────────────────────────────────────────────
  static const Color bg          = Color(0xFF0E0B1A);
  static const Color surface     = Color(0xFF1A1530);
  static const Color surfaceAlt  = Color(0xFF231E3D);
  static const Color accent      = Color(0xFFBF5AF2);

  // ── Text ───────────────────────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0A8D0);
  static const Color textMuted     = Color(0xFF6B6490);

  // ── Per‑philosophy gradient pairs (aligned with the 21 isms) ─────────────
  static const Map<String, List<Color>> _gradients = {
    // Meaning & Existence
    'Stoicism':           [Color(0xFFD4AF37), Color(0xFF8B7500)],
    'Existentialism':     [Color(0xFF7F8C8D), Color(0xFF2C3E50)],
    'Nihilism':           [Color(0xFF2C3E50), Color(0xFF1A1A1A)],
    'Absurdism':          [Color(0xFFBF5AF2), Color(0xFF5E5CE6)],
    'Humanism':           [Color(0xFF4A90D9), Color(0xFF2ECC71)],
    'Fatalism':           [Color(0xFF8E44AD), Color(0xFF2C3E50)],

    // Self & Society
    'Individualism':      [Color(0xFFE91E63), Color(0xFF9C27B0)],
    'Collectivism':       [Color(0xFF2ECC71), Color(0xFF1ABC9C)],
    'Minimalism':         [Color(0xFFA5D6A7), Color(0xFF81C784)],
    'Hedonism':           [Color(0xFFFFC107), Color(0xFFFF5722)],
    'Asceticism':         [Color(0xFF8D6E63), Color(0xFF5D4037)],
    'Pragmatism':         [Color(0xFF607D8B), Color(0xFF455A64)],

    // Mental & Emotional Approaches
    'Optimism':           [Color(0xFFFFEB3B), Color(0xFFFF9800)],
    'Pessimism':          [Color(0xFF37474F), Color(0xFF263238)],
    'Cynicism':           [Color(0xFF66BB6A), Color(0xFF388E3C)],
    'Romanticism':        [Color(0xFFE91E63), Color(0xFF9C27B0)],
    'Realism':            [Color(0xFF607D8B), Color(0xFF37474F)],

    // Spiritual / Eastern Approaches
    'Buddhism':           [Color(0xFFFFA726), Color(0xFFF57C00)],
    'Taoism':             [Color(0xFF66BB6A), Color(0xFF2E7D32)],
    'Confucianism':       [Color(0xFFD32F2F), Color(0xFFB71C1C)],
  };

  /// Returns the two‑color gradient for the given philosophy name.
  /// Falls back to accent + a darker accent if the name is unknown.
  static List<Color> gradientFor(String philosophy) {
    return _gradients[philosophy] ??
        [accent, const Color(0xFF7A40BF)];   // fallback gradient
  }
}