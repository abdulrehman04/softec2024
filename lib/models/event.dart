import 'dart:convert';

import 'package:flutter/foundation.dart';

class Event {
  final String name;
  final String location;
  final DateTime date;
  final String id;
  final List<String> participants;
  Event({
    required this.name,
    required this.location,
    required this.date,
    required this.id,
    required this.participants,
  });

  Event copyWith({
    String? name,
    String? location,
    DateTime? date,
    String? id,
    List<String>? participants,
  }) {
    return Event(
      name: name ?? this.name,
      location: location ?? this.location,
      date: date ?? this.date,
      id: id ?? this.id,
      participants: participants ?? this.participants,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'location': location,
      'date': date.millisecondsSinceEpoch,
      'id': id,
      'participants': participants,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      name: map['name'] as String,
      location: map['location'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      id: map['id'] as String,
      participants: List<String>.from((map['participants'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Event(name: $name, location: $location, date: $date, id: $id, participants: $participants)';
  }

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.location == location &&
        other.date == date &&
        other.id == id &&
        listEquals(other.participants, participants);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        location.hashCode ^
        date.hashCode ^
        id.hashCode ^
        participants.hashCode;
  }
}
