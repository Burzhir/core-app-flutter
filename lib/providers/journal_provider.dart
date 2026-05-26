import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/journal_entry.dart';

class JournalProvider extends ChangeNotifier {
  late Box<JournalEntry> _box;

  JournalProvider() {
    _box = Hive.box<JournalEntry>('journal');
  }

  List<JournalEntry> get journal => _box.values.toList().reversed.toList();
  int get journalCount => _box.length;

  // Hive loads automatically – kept for compatibility
  Future<void> load() async {}

  Future<void> addEntry(JournalEntry entry) async {
    await _box.add(entry);
    notifyListeners();
  }

  Future<void> deleteEntry(String id) async {
    final key = _box.keys.firstWhere(
      (k) => _box.get(k)?.id == id,
      orElse: () => null,
    );
    if (key != null) {
      await _box.delete(key);
      notifyListeners();
    }
  }

  Future<void> clear() async {
    await _box.clear();
    notifyListeners();
  }
}