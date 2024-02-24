import 'dart:convert';

import 'package:softec_app/models/auth_data.dart';

class ChatMeta {
  final AuthData receiver;
  final String lastMessage;
  final String chatId;

  ChatMeta({
    required this.receiver,
    required this.lastMessage,
    required this.chatId,
  });

  ChatMeta copyWith({
    AuthData? receiver,
    String? lastMessage,
    String? chatId,
  }) {
    return ChatMeta(
      receiver: receiver ?? this.receiver,
      lastMessage: lastMessage ?? this.lastMessage,
      chatId: chatId ?? this.chatId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'receiver': receiver.toMap(),
      'lastMessage': lastMessage,
      'chatId': chatId,
    };
  }

  factory ChatMeta.fromMap(Map<String, dynamic> map) {
    return ChatMeta(
      receiver: map['receiver'] as AuthData,
      lastMessage: map['lastMessage'] as String,
      chatId: map['chatId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMeta.fromJson(String source) =>
      ChatMeta.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChatMeta(receiver: $receiver, lastMessage: $lastMessage, chatId: $chatId)';

  @override
  bool operator ==(covariant ChatMeta other) {
    if (identical(this, other)) return true;

    return other.receiver == receiver &&
        other.lastMessage == lastMessage &&
        other.chatId == chatId;
  }

  @override
  int get hashCode =>
      receiver.hashCode ^ lastMessage.hashCode ^ chatId.hashCode;
}
