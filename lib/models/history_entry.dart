import 'package:hive/hive.dart';
import 'philosophy_result.dart';

@HiveType(typeId: 0)
class HistoryEntry {
  @HiveField(0)
  final PhilosophyResult result;

  @HiveField(1)
  final String userInput;

  @HiveField(2)
  final DateTime timestamp;

  const HistoryEntry({
    required this.result,
    required this.userInput,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'result':    result.toJson(),
    'userInput': userInput,
    'timestamp': timestamp.toIso8601String(),
  };

  factory HistoryEntry.fromJson(Map<String, dynamic> json) {
    return HistoryEntry(
      result:    PhilosophyResult.fromJson(json['result'] as Map<String, dynamic>),
      userInput: json['userInput'] as String? ?? '',
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}

// Manual adapter (no code generation needed)
class HistoryEntryAdapter extends TypeAdapter<HistoryEntry> {
  @override
  final int typeId = 0;

  @override
  HistoryEntry read(BinaryReader reader) {
    final numFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numFields; i++) {
      final key = reader.readByte();
      final value = reader.read();
      fields[key] = value;
    }
    return HistoryEntry(
      result:    fields[0] as PhilosophyResult,
      userInput: fields[1] as String,
      timestamp: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryEntry obj) {
    writer.writeByte(3);  // number of fields
    writer.writeByte(0);
    writer.write(obj.result);
    writer.writeByte(1);
    writer.write(obj.userInput);
    writer.writeByte(2);
    writer.write(obj.timestamp);
  }
}