import 'package:flutter_tts/flutter_tts.dart';
import '../utils/constants.dart';

typedef VoidCallback = void Function();

class TtsService {
  TtsService._();
  static final TtsService instance = TtsService._();

  final FlutterTts _tts = FlutterTts();
  bool _isSpeaking = false;

  bool get isSpeaking => _isSpeaking;

  VoidCallback? onStart;
  VoidCallback? onComplete;
  Function(String)? onError;

  Future<void> init() async {
    await _tts.setLanguage(AppConstants.ttsLang);
    await _tts.setPitch(AppConstants.ttsPitch);
    await _tts.setSpeechRate(AppConstants.ttsRate);
    await _tts.setVolume(AppConstants.ttsVolume);

    _tts.setStartHandler(() {
      _isSpeaking = true;
      onStart?.call();
    });
    _tts.setCompletionHandler(() {
      _isSpeaking = false;
      onComplete?.call();
    });
    _tts.setCancelHandler(() {
      _isSpeaking = false;
      onComplete?.call();
    });
    _tts.setErrorHandler((msg) {
      _isSpeaking = false;
      onError?.call(msg);
    });
  }

  Future<void> speak(String text) async {
    if (text.trim().isEmpty) return;
    await stop();
    await _tts.speak(text);
  }

  Future<void> stop() async {
    if (_isSpeaking) {
      await _tts.stop();
      _isSpeaking = false;
    }
  }

  void dispose() => _tts.stop();
}
