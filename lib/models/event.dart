import 'dart:convert';

import 'package:flutter/foundation.dart';

class Event {
  final String name;
  final String location;
  final DateTime date;
  final List<String> participants;

  Event({
    required this.name,
    required this.location,
    required this.date,
    required this.participants,
  });

  Event copyWith({
    String? name,
    String? location,
    DateTime? date,
    List<String>? participants,
  }) {
    return Event(
      name: name ?? this.name,
      location: location ?? this.location,
      date: date ?? this.date,
      participants: participants ?? this.participants,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'location': location,
      'date': date.millisecondsSinceEpoch,
      'participants': participants,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      name: map['name'] as String,
      location: map['location'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      participants: List<String>.from((map['participants'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Event(name: $name, location: $location, date: $date, participants: $participants)';
  }

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.location == location &&
        other.date == date &&
        listEquals(other.participants, participants);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        location.hashCode ^
        date.hashCode ^
        participants.hashCode;
  }
}
