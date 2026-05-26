import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/history_entry.dart';

class DiagnosisHistoryProvider extends ChangeNotifier {
  late Box<HistoryEntry> _box;

  DiagnosisHistoryProvider() {
    _box = Hive.box<HistoryEntry>('history');
  }

  List<HistoryEntry> get history => _box.values.toList().reversed.toList();
  HistoryEntry? get lastDiagnosis => history.isEmpty ? null : history.first;

  List<MapEntry<String, int>> get topIsms {
    final freq = <String, int>{};
    for (final e in _box.values) {
      freq[e.result.philosophy] = (freq[e.result.philosophy] ?? 0) + 1;
    }
    return (freq.entries.toList()..sort((a, b) => b.value.compareTo(a.value)))
        .take(5)
        .toList();
  }

  void add(HistoryEntry entry) {
    _box.add(entry);
    notifyListeners();
  }

  void clear() {
    _box.clear();
    notifyListeners();
  }
}