import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/app_state.dart';
import 'app.dart';
import 'package:http/http.dart' as http;
import 'core/app_config.dart';
 
void main() {
  WidgetsFlutterBinding.ensureInitialized();
   http.get(Uri.parse('${AppConfig.baseUrl}/health')).timeout(
    const Duration(seconds: 5),
    onTimeout: () => http.Response('', 408), // ignore
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState()..init(),
      child: const CoreApp(),
    ),
  );
}
 