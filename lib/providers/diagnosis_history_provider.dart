import 'package:flutter/foundation.dart';
import '../models/history_entry.dart';

class DiagnosisHistoryProvider extends ChangeNotifier {
  final List<HistoryEntry> _history = [];
  List<HistoryEntry> get history => List.unmodifiable(_history);
  HistoryEntry? get lastDiagnosis => _history.isEmpty ? null : _history.first;

  /// Returns ism name → count, sorted descending, top 5.
  List<MapEntry<String, int>> get topIsms {
    final freq = <String, int>{};
    for (final e in _history) {
      freq[e.result.philosophy] = (freq[e.result.philosophy] ?? 0) + 1;
    }
    return (freq.entries.toList()..sort((a, b) => b.value.compareTo(a.value)))
        .take(5)
        .toList();
  }

  void add(HistoryEntry entry) {
    _history.insert(0, entry);
    if (_history.length > 50) _history.removeLast();
    notifyListeners();
  }

  void clear() {
    _history.clear();
    notifyListeners();
  }
}