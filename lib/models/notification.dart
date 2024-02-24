import 'dart:convert';

class NotificationModel {
  final String title;
  final String body;
  NotificationModel({
    required this.title,
    required this.body,
  });

  NotificationModel copyWith({
    String? title,
    String? body,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'NotificationModel(title: $title, body: $body)';

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.body == body;
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode;
}
