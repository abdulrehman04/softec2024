// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class MealPlan {
  final List<String> breakfast;
  final List<String> lunch;
  final List<String> dinner;
  final List<String> snacks;
  MealPlan({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snacks,
  });

  MealPlan copyWith({
    List<String>? breakfast,
    List<String>? lunch,
    List<String>? dinner,
    List<String>? snacks,
  }) {
    return MealPlan(
      breakfast: breakfast ?? this.breakfast,
      lunch: lunch ?? this.lunch,
      dinner: dinner ?? this.dinner,
      snacks: snacks ?? this.snacks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'breakfast': breakfast,
      'lunch': lunch,
      'dinner': dinner,
      'snacks': snacks,
    };
  }

  factory MealPlan.fromMap(Map<String, dynamic> map) {
    return MealPlan(
      breakfast: List<String>.from((map['breakfast'] as List<String>)),
      lunch: List<String>.from((map['lunch'] as List<String>)),
      dinner: List<String>.from((map['dinner'] as List<String>)),
      snacks: List<String>.from((map['snacks'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory MealPlan.fromJson(String source) =>
      MealPlan.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MealPlan(breakfast: $breakfast, lunch: $lunch, dinner: $dinner, snacks: $snacks)';
  }

  @override
  bool operator ==(covariant MealPlan other) {
    if (identical(this, other)) return true;

    return listEquals(other.breakfast, breakfast) &&
        listEquals(other.lunch, lunch) &&
        listEquals(other.dinner, dinner) &&
        listEquals(other.snacks, snacks);
  }

  @override
  int get hashCode {
    return breakfast.hashCode ^
        lunch.hashCode ^
        dinner.hashCode ^
        snacks.hashCode;
  }
}
