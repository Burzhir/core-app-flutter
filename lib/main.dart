import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'core/app_config.dart';
import 'core/theme_provider.dart';
import 'app.dart';
import 'providers/diagnosis_history_provider.dart';
import 'providers/journal_provider.dart';
import 'providers/user_stats_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Wake up Render server silently
  try {
    http.get(Uri.parse('${AppConfig.baseUrl}/health'))
        .timeout(const Duration(seconds: 5));
  } catch (_) {}

  final prefs = await SharedPreferences.getInstance();
  final onboardingDone = prefs.getBool('onboarding_done') ?? false;

  final diagnosisProvider = DiagnosisHistoryProvider();
  final journalProvider   = JournalProvider();
  final statsProvider     = UserStatsProvider();
  final themeProvider     = ThemeProvider();

  await journalProvider.load();
  await statsProvider.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: diagnosisProvider),
        ChangeNotifierProvider.value(value: journalProvider),
        ChangeNotifierProvider.value(value: statsProvider),
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: CoreApp(showOnboarding: !onboardingDone),
    ),
  );
}
