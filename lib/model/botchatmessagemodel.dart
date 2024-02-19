import 'dart:convert';

class BotChatMessageModel {
  final String role;
  final List<ChatPartModel> parts;

  BotChatMessageModel({required this.role, required this.parts});

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'parts': parts.map((x) => x.toMap()).toList(),
    };
  }

  factory BotChatMessageModel.fromMap(Map<String, dynamic> map) {
    return BotChatMessageModel(
      role: map['role'] ?? '',
      parts: List<ChatPartModel>.from(
          map['parts']?.map((x) => ChatPartModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory BotChatMessageModel.fromJson(String source) =>
      BotChatMessageModel.fromMap(json.decode(source));
}

class ChatPartModel {
  final String text;
  ChatPartModel({
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }

  factory ChatPartModel.fromMap(Map<String, dynamic> map) {
    return ChatPartModel(
      text: map['text'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatPartModel.fromJson(String source) =>
      ChatPartModel.fromMap(json.decode(source));
}