class JournalEntry {
  final String id;
  final String text;
  final String? linkedPhilosophy;  // philosophy name from last diagnosis
  final String? linkedIcon;        // emoji icon
  final DateTime createdAt;

  const JournalEntry({
    required this.id,
    required this.text,
    this.linkedPhilosophy,
    this.linkedIcon,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id':               id,
    'text':             text,
    'linkedPhilosophy': linkedPhilosophy,
    'linkedIcon':       linkedIcon,
    'createdAt':        createdAt.toIso8601String(),
  };

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id:               json['id']               as String,
      text:             json['text']             as String,
      linkedPhilosophy: json['linkedPhilosophy'] as String?,
      linkedIcon:       json['linkedIcon']       as String?,
      createdAt:        DateTime.parse(json['createdAt'] as String),
    );
  }
}