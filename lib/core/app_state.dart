import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/history_entry.dart';
import '../models/journal_entry.dart';

class AppState extends ChangeNotifier {
  // ── Diagnosis history (in-memory, max 50) ─────────────────────────────────
  final List<HistoryEntry> _history = [];
  List<HistoryEntry> get history => List.unmodifiable(_history);

  // ── Journal (persisted) ───────────────────────────────────────────────────
  final List<JournalEntry> _journal = [];
  List<JournalEntry> get journal => List.unmodifiable(_journal);

  // ── Stats ─────────────────────────────────────────────────────────────────
  int _streak        = 0;
  int _totalDiagnoses = 0;

  int get streak         => _streak;
  int get totalDiagnoses => _totalDiagnoses;
  int get journalCount   => _journal.length;

  bool _initialized = false;

  // ── Convenience: last diagnosis ───────────────────────────────────────────
  HistoryEntry? get lastDiagnosis => _history.isEmpty ? null : _history.first;

  // ── Init: load persisted data from SharedPreferences ──────────────────────
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    final prefs = await SharedPreferences.getInstance();

    // Restore journal
    final raw = prefs.getStringList(_kJournalKey) ?? [];
    for (final item in raw) {
      try {
        _journal.add(JournalEntry.fromJson(jsonDecode(item)));
      } catch (_) {
        // Skip corrupted entries silently
      }
    }

    // Restore stats
    _totalDiagnoses = prefs.getInt(_kTotalDiagnosesKey) ?? 0;
    _streak         = prefs.getInt(_kStreakCountKey)    ?? 0;

    // Reset streak if user hasn't been active in > 1 day
    final lastStr = prefs.getString(_kStreakLastDateKey);
    if (lastStr != null) {
      final last  = DateTime.parse(lastStr);
      final today = _dateOnly(DateTime.now());
      if (today.difference(_dateOnly(last)).inDays > 1) {
        _streak = 0;
        await prefs.setInt(_kStreakCountKey, 0);
      }
    }

    notifyListeners();
  }

  // ── Add a completed diagnosis ─────────────────────────────────────────────
  Future<void> addDiagnosis(HistoryEntry entry) async {
    _history.insert(0, entry);
    if (_history.length > 50) _history.removeLast();

    _totalDiagnoses++;
    await _updateStreak();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kTotalDiagnosesKey, _totalDiagnoses);

    notifyListeners();
  }

  // ── Journal CRUD ──────────────────────────────────────────────────────────
  Future<void> addJournalEntry(JournalEntry entry) async {
    _journal.insert(0, entry);
    await _persistJournal();
    notifyListeners();
  }

  Future<void> deleteJournalEntry(String id) async {
    _journal.removeWhere((e) => e.id == id);
    await _persistJournal();
    notifyListeners();
  }

  // ── Clear all history (from profile screen settings) ──────────────────────
  Future<void> clearHistory() async {
    _history.clear();
    notifyListeners();
  }

  Future<void> clearAllData() async {
    _history.clear();
    _journal.clear();
    _streak         = 0;
    _totalDiagnoses = 0;

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  // ── Derived stats for Profile screen ─────────────────────────────────────

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

  // ── Private helpers ───────────────────────────────────────────────────────

  Future<void> _updateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final today   = _dateOnly(DateTime.now());
    final lastStr = prefs.getString(_kStreakLastDateKey);

    if (lastStr == null) {
      _streak = 1;
    } else {
      final last = _dateOnly(DateTime.parse(lastStr));
      final diff = today.difference(last).inDays;
      if (diff == 0) {
        // Same day — no change
      } else if (diff == 1) {
        _streak++;          // Consecutive day
      } else {
        _streak = 1;        // Gap — reset
      }
    }

    await prefs.setInt(_kStreakCountKey, _streak);
    await prefs.setString(_kStreakLastDateKey, today.toIso8601String());
  }

  Future<void> _persistJournal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _kJournalKey,
      _journal.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  // ── Storage keys ──────────────────────────────────────────────────────────
  static const _kJournalKey        = 'journal_entries';
  static const _kStreakCountKey    = 'streak_count';
  static const _kStreakLastDateKey = 'streak_last_date';
  static const _kTotalDiagnosesKey = 'total_diagnoses';
}