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

  // ── Per-philosophy gradient pairs ──────────────────────────────────────────
  static const Map<String, List<Color>> _gradients = {
    'Spartan Discipline':
        [Color(0xFFFF3B30), Color(0xFF8B0000)],
    'Extreme Ownership':
        [Color(0xFFFF9500), Color(0xFFBF5A00)],
    "Nietzsche's Self-Overcoming":
        [Color(0xFFAF52DE), Color(0xFF5E189E)],
    'Bushido: The Way of the Warrior':
        [Color(0xFFFF2D55), Color(0xFF8B0022)],
    'The 40% Rule':
        [Color(0xFF0A84FF), Color(0xFF003F8A)],
    'Warrior Stoicism (Marcus Aurelius)':
        [Color(0xFF8E8E93), Color(0xFF3A3A3C)],
    "Sun Tzu's Strategic Dominance":
        [Color(0xFF30D158), Color(0xFF00703A)],
    "Musashi's Way of the Sword":
        [Color(0xFFFF6B35), Color(0xFF9A2F00)],
    "Seneca's Urgency Doctrine":
        [Color(0xFFFFD60A), Color(0xFFA87D00)],
    "Roosevelt's Arena":
        [Color(0xFFBF5AF2), Color(0xFF5A1A8C)],
    "Epictetus' Inner Citadel":
        [Color(0xFF5E5CE6), Color(0xFF24228A)],
    "Alexander's Conquest Mindset":
        [Color(0xFF0A84FF), Color(0xFF004080)],
    'Mamba Mentality: Obsessive Excellence':
        [Color(0xFFFFD60A), Color(0xFF7A5C00)],
    "Naval's Long-Game Philosophy":
        [Color(0xFF64D2FF), Color(0xFF007A9A)],
    "Diogenes' Radical Freedom":
        [Color(0xFF34C759), Color(0xFF006B28)],
    'Forge Yourself':
        [Color(0xFFFF9500), Color(0xFF7A4000)],
  };

  static List<Color> gradientFor(String philosophy) {
    return _gradients[philosophy] ??
        [const Color(0xFFFF9500), const Color(0xFF7A4000)];
  }
}