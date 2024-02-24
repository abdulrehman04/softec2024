import 'dart:convert';

class Message {
  final String to;
  final String from;
  final String content;
  final DateTime createdAt;

  Message({
    required this.to,
    required this.from,
    required this.content,
    required this.createdAt,
  });

  Message copyWith({
    String? to,
    String? from,
    String? content,
    DateTime? createdAt,
  }) {
    return Message(
      to: to ?? this.to,
      from: from ?? this.from,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'to': to,
      'from': from,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      to: map['to'] as String,
      from: map['from'] as String,
      content: map['content'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(to: $to, from: $from, content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.to == to &&
        other.from == from &&
        other.content == content &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return to.hashCode ^ from.hashCode ^ content.hashCode ^ createdAt.hashCode;
  }
}
