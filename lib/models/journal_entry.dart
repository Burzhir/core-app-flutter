import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class JournalEntry {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final String? linkedPhilosophy;

  @HiveField(3)
  final String? linkedIcon;

  @HiveField(4)
  final DateTime createdAt;

  const JournalEntry({
    required this.id,
    required this.text,
    this.linkedPhilosophy,
    this.linkedIcon,
    required this.createdAt,
  });

  // These methods are still here if you need JSON, but Hive doesn't use them
  Map<String, dynamic> toJson() => {
    'id':               id,
    'text':             text,
    'linkedPhilosophy': linkedPhilosophy,
    'linkedIcon':       linkedIcon,
    'createdAt':        createdAt.toIso8601String(),
  };

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id:               json['id'] as String? ?? '',
      text:             json['text'] as String? ?? '',
      linkedPhilosophy: json['linkedPhilosophy'] as String?,
      linkedIcon:       json['linkedIcon'] as String?,
      createdAt:        DateTime.parse(json['createdAt'] as String),
    );
  }
}

// ---------- Hive adapter (manual) ----------
class JournalEntryAdapter extends TypeAdapter<JournalEntry> {
  @override
  final int typeId = 2;

  @override
  JournalEntry read(BinaryReader reader) {
    final numFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numFields; i++) {
      final key = reader.readByte();
      final value = reader.read();
      fields[key] = value;
    }
    return JournalEntry(
      id:               fields[0] as String,
      text:             fields[1] as String,
      linkedPhilosophy: fields[2] as String?,
      linkedIcon:       fields[3] as String?,
      createdAt:        fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, JournalEntry obj) {
    writer.writeByte(5);
    writer.writeByte(0); writer.write(obj.id);
    writer.writeByte(1); writer.write(obj.text);
    writer.writeByte(2); writer.write(obj.linkedPhilosophy);
    writer.writeByte(3); writer.write(obj.linkedIcon);
    writer.writeByte(4); writer.write(obj.createdAt);
  }
}