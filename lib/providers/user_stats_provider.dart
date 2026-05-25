import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStatsProvider extends ChangeNotifier {
  int _streak = 0;
  int _totalDiagnoses = 0;

  int get streak => _streak;
  int get totalDiagnoses => _totalDiagnoses;

  static const _kStreakCountKey = 'streak_count';
  static const _kStreakLastDateKey = 'streak_last_date';
  static const _kTotalDiagnosesKey = 'total_diagnoses';

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _totalDiagnoses = prefs.getInt(_kTotalDiagnosesKey) ?? 0;
    _streak = prefs.getInt(_kStreakCountKey) ?? 0;

    // Reset streak if inactive for > 1 day
    final lastStr = prefs.getString(_kStreakLastDateKey);
    if (lastStr != null) {
      final last = DateTime.parse(lastStr);
      final today = _dateOnly(DateTime.now());
      if (today.difference(_dateOnly(last)).inDays > 1) {
        _streak = 0;
        await prefs.setInt(_kStreakCountKey, 0);
      }
    }
    notifyListeners();
  }

  Future<void> recordDiagnosis() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _dateOnly(DateTime.now());
    final lastStr = prefs.getString(_kStreakLastDateKey);

    if (lastStr == null) {
      _streak = 1;
    } else {
      final last = _dateOnly(DateTime.parse(lastStr));
      final diff = today.difference(last).inDays;
      if (diff == 0) {
        // same day, no change
      } else if (diff == 1) {
        _streak++;
      } else {
        _streak = 1;
      }
    }

    _totalDiagnoses++;
    await prefs.setInt(_kStreakCountKey, _streak);
    await prefs.setInt(_kTotalDiagnosesKey, _totalDiagnoses);
    await prefs.setString(_kStreakLastDateKey, today.toIso8601String());
    notifyListeners();
  }

  Future<void> clearAll() async {
    _streak = 0;
    _totalDiagnoses = 0;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kStreakCountKey, 0);
    await prefs.setInt(_kTotalDiagnosesKey, 0);
    await prefs.remove(_kStreakLastDateKey);
    notifyListeners();
  }

  DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
}