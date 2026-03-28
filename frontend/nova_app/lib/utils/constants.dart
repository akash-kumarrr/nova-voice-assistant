class AppConstants {
  AppConstants._();

  // Backend
  static const String backendHost = 'http://localhost:8000';
  static const String assistantEndpoint = '/assistant/response';

  // App info
  static const String appName   = 'Nova';
  static const String appTagline = 'Voice Assistant';
  static const String version   = '1.0.0';

  // TTS defaults
  static const double ttsRate   = 0.48;
  static const double ttsPitch  = 0.95;
  static const double ttsVolume = 1.0;
  static const String ttsLang   = 'en-US';

  // UI
  static const double orbSize   = 120.0;
  static const double borderRadius = 16.0;
}
