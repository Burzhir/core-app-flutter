class AppConfig {
  AppConfig._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://core-app-x3ok.onrender.com',
  );

  static const String diagnoseEndpoint     = '$baseUrl/api/diagnose';
  static const String philosophiesEndpoint = '$baseUrl/api/philosophies';
}