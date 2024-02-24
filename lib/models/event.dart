import 'dart:convert';

import 'package:flutter/foundation.dart';

class Event {
  final String name;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final String id;
  final List<String> participants;
  final String url;

  Event({
    required this.name,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.id,
    required this.participants,
    required this.url,
  });

  Event copyWith({
    String? name,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    String? id,
    List<String>? participants,
    String? url,
  }) {
    return Event(
      name: name ?? this.name,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      id: id ?? this.id,
      participants: participants ?? this.participants,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'location': location,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'id': id,
      'participants': participants,
      'url': url,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      name: map['name'] as String,
      location: map['location'] as String,
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int),
      id: map['id'] as String,
      participants: List<String>.from((map['participants'] as List)),
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Event(name: $name, location: $location, startDate: $startDate, endDate: $endDate, id: $id, participants: $participants, url: $url)';
  }

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.location == location &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.id == id &&
      listEquals(other.participants, participants) &&
      other.url == url;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      location.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      id.hashCode ^
      participants.hashCode ^
      url.hashCode;
  }
}
