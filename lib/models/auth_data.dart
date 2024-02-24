import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:softec_app/models/ratings.dart';

class AuthData {
  final String email;
  final String fullname;
  final String uid;
  final bool isProfessional;
  final String domain;
  final String focus;
  final List<Rating>? ratings;

  AuthData({
    required this.email,
    required this.fullname,
    required this.uid,
    required this.isProfessional,
    required this.domain,
    required this.focus,
    this.ratings,
  });

  AuthData copyWith({
    String? email,
    String? fullname,
    String? uid,
    bool? isProfessional,
    String? domain,
    String? focus,
    List<Rating>? ratings,
  }) {
    return AuthData(
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      uid: uid ?? this.uid,
      isProfessional: isProfessional ?? this.isProfessional,
      domain: domain ?? this.domain,
      focus: focus ?? this.focus,
      ratings: ratings ?? this.ratings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'fullname': fullname,
      'uid': uid,
      'isProfessional': isProfessional,
      'domain': domain,
      'focus': focus,
      'ratings': ratings?.map((x) => x.toMap()).toList(),
    };
  }

  factory AuthData.fromMap(Map<String, dynamic> map) {
    return AuthData(
      email: map['email'] as String,
      fullname: map['fullname'] as String,
      uid: map['uid'] as String,
      isProfessional: map['isProfessional'] as bool,
      domain: map['domain'] as String,
      focus: map['focus'] as String,
      ratings: map['ratings'] != null ? List<Rating>.from((map['ratings'] as List<int>).map<Rating?>((x) => Rating.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthData.fromJson(String source) => AuthData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthData(email: $email, fullname: $fullname, uid: $uid, isProfessional: $isProfessional, domain: $domain, focus: $focus, ratings: $ratings)';
  }

  @override
  bool operator ==(covariant AuthData other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.fullname == fullname &&
      other.uid == uid &&
      other.isProfessional == isProfessional &&
      other.domain == domain &&
      other.focus == focus &&
      listEquals(other.ratings, ratings);
  }

  @override
  int get hashCode {
    return email.hashCode ^
      fullname.hashCode ^
      uid.hashCode ^
      isProfessional.hashCode ^
      domain.hashCode ^
      focus.hashCode ^
      ratings.hashCode;
  }
}
