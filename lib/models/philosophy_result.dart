import 'package:hive/hive.dart';
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

class PhilosophyResultAdapter extends TypeAdapter<PhilosophyResult> {
  @override
  final int typeId = 1;

  @override
  PhilosophyResult read(BinaryReader reader) {
    final numFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numFields; i++) {
      final key = reader.readByte();
      final value = reader.read();
      fields[key] = value;
    }
    return PhilosophyResult(
      philosophy:      fields[0] as String,
      reason:          fields[1] as String,
      icon:            fields[2] as String,
      color:           fields[3] as String,
      source:          fields[4] as String,
      confidence:      fields[5] as String,
      matchedKeywords: List<String>.from(fields[6] as List),
    );
  }

  @override
  void write(BinaryWriter writer, PhilosophyResult obj) {
    writer.writeByte(7);
    writer.writeByte(0); writer.write(obj.philosophy);
    writer.writeByte(1); writer.write(obj.reason);
    writer.writeByte(2); writer.write(obj.icon);
    writer.writeByte(3); writer.write(obj.color);
    writer.writeByte(4); writer.write(obj.source);
    writer.writeByte(5); writer.write(obj.confidence);
    writer.writeByte(6); writer.write(obj.matchedKeywords);
  }
}