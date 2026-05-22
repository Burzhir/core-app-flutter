import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class PhilosophyResult {
  final String philosophy;
  final String reason;
  final String icon;
  final String color;
  final String source;
  final String confidence;
  final List<String> matchedKeywords;

  const PhilosophyResult({
    required this.philosophy,
    required this.reason,
    required this.icon,
    required this.color,
    required this.source,
    required this.confidence,
    required this.matchedKeywords,
  });

  factory PhilosophyResult.fromJson(Map<String, dynamic> json) {
    return PhilosophyResult(
      philosophy:      json['philosophy']       as String? ?? 'Unknown',
      reason:          json['reason']           as String? ?? '',
      icon:            json['icon']             as String? ?? '⚡',
      color:           json['color']            as String? ?? '#FF9500',
      source:          json['source']           as String? ?? 'unknown',
      confidence:      json['confidence']       as String? ?? 'low',
      matchedKeywords: List<String>.from(json['matched_keywords'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'philosophy':      philosophy,
    'reason':          reason,
    'icon':            icon,
    'color':           color,
    'source':          source,
    'confidence':      confidence,
    'matched_keywords': matchedKeywords,
  };

  List<Color> get gradientColors => AppColors.gradientFor(philosophy);
}