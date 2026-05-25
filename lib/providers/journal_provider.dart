import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/journal_entry.dart';

class JournalProvider extends ChangeNotifier {
  final List<JournalEntry> _journal = [];
  List<JournalEntry> get journal => List.unmodifiable(_journal);
  int get journalCount => _journal.length;

  static const _kJournalKey = 'journal_entries';

  /// Load persisted journal from SharedPreferences.
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_kJournalKey) ?? [];
    for (final item in raw) {
      try {
        _journal.add(JournalEntry.fromJson(jsonDecode(item)));
      } catch (_) {}
    }
    notifyListeners();
  }

  Future<void> addEntry(JournalEntry entry) async {
    _journal.insert(0, entry);
    await _persist();
    notifyListeners();
  }

  Future<void> deleteEntry(String id) async {
    _journal.removeWhere((e) => e.id == id);
    await _persist();
    notifyListeners();
  }

  Future<void> clear() async {
    _journal.clear();
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _kJournalKey,
      _journal.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }
}