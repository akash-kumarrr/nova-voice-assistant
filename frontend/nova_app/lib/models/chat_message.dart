import 'package:flutter/foundation.dart';

enum MessageRole { user, nova }

enum MessageStatus { idle, loading, error, success }

@immutable
class ChatMessage {
  final String id;
  final String text;
  final MessageRole role;
  final DateTime timestamp;
  final MessageStatus status;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.role,
    required this.timestamp,
    this.status = MessageStatus.success,
  });

  factory ChatMessage.user(String text) => ChatMessage(
        id: _genId(),
        text: text,
        role: MessageRole.user,
        timestamp: DateTime.now(),
      );

  factory ChatMessage.nova(String text, {MessageStatus status = MessageStatus.success}) =>
      ChatMessage(
        id: _genId(),
        text: text,
        role: MessageRole.nova,
        timestamp: DateTime.now(),
        status: status,
      );

  factory ChatMessage.loading() => ChatMessage(
        id: _genId(),
        text: '',
        role: MessageRole.nova,
        timestamp: DateTime.now(),
        status: MessageStatus.loading,
      );

  factory ChatMessage.error(String message) => ChatMessage(
        id: _genId(),
        text: message,
        role: MessageRole.nova,
        timestamp: DateTime.now(),
        status: MessageStatus.error,
      );

  bool get isUser    => role == MessageRole.user;
  bool get isNova    => role == MessageRole.nova;
  bool get isLoading => status == MessageStatus.loading;
  bool get isError   => status == MessageStatus.error;

  ChatMessage copyWith({String? text, MessageStatus? status}) => ChatMessage(
        id: id,
        text: text ?? this.text,
        role: role,
        timestamp: timestamp,
        status: status ?? this.status,
      );

  static String _genId() =>
      DateTime.now().microsecondsSinceEpoch.toString();
}
