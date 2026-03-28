import 'package:flutter/foundation.dart';
import '../models/chat_message.dart';
import '../services/api_service.dart';
import '../services/tts_service.dart';

enum AssistantState { idle, thinking, speaking, error }

class ChatProvider extends ChangeNotifier {
  final _api = ApiService.instance;
  final _tts = TtsService.instance;

  final List<ChatMessage> _messages = [];
  AssistantState _state = AssistantState.idle;
  String? _errorMessage;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  AssistantState get state => _state;
  String? get errorMessage => _errorMessage;

  bool get isThinking  => _state == AssistantState.thinking;
  bool get isSpeaking  => _state == AssistantState.speaking;
  bool get isIdle      => _state == AssistantState.idle;
  bool get isBusy      => _state == AssistantState.thinking;

  ChatProvider() {
    _initTts();
    _addWelcome();
  }

  void _initTts() {
    _tts.onStart    = () { _setState(AssistantState.speaking); };
    _tts.onComplete = () { _setState(AssistantState.idle); };
    _tts.onError    = (_) { _setState(AssistantState.idle); };
  }

  void _addWelcome() {
    _messages.add(ChatMessage.nova(
      "Hello! I'm Nova, your AI voice assistant. Type your message and I'll respond in speech.",
    ));
  }

  Future<void> sendMessage(String input) async {
    if (input.trim().isEmpty || isThinking) return;

    // Add user message
    _messages.add(ChatMessage.user(input));
    // Add loading placeholder
    final loadingMsg = ChatMessage.loading();
    _messages.add(loadingMsg);
    _setState(AssistantState.thinking);

    final result = await _api.sendMessage(input);

    // Replace loading with result
    final idx = _messages.indexWhere((m) => m.id == loadingMsg.id);
    if (idx != -1) {
      _messages[idx] = result.success
          ? ChatMessage.nova(result.text)
          : ChatMessage.error(result.error ?? 'Unknown error');
    }

    if (result.success) {
      notifyListeners();
      await _tts.speak(result.text);
    } else {
      _setState(AssistantState.error);
      _errorMessage = result.error;
    }
  }

  Future<void> stopSpeaking() async {
    await _tts.stop();
    _setState(AssistantState.idle);
  }

  void clearMessages() {
    _messages.clear();
    _addWelcome();
    notifyListeners();
  }

  void _setState(AssistantState s) {
    _state = s;
    notifyListeners();
  }

  @override
  void dispose() {
    _tts.dispose();
    super.dispose();
  }
}
