
import 'philosophy_result.dart';

class HistoryEntry {
  final PhilosophyResult result;
  final String userInput;
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