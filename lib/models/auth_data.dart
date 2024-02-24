import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:softec_app/models/ratings.dart';

class AuthData {
  final String email;
  final String password;
  final String fullname;
  final String uid;
  final bool isProfessional;
  final String experties;
  final String focus;
  final List<Rating> ratings;

  AuthData({
    required this.email,
    required this.password,
    required this.fullname,
    required this.uid,
    required this.isProfessional,
    required this.experties,
    required this.focus,
    required this.ratings,
  });

  AuthData copyWith({
    String? email,
    String? password,
    String? fullname,
    String? uid,
    bool? isProfessional,
    String? experties,
    String? focus,
    List<Rating>? ratings,
  }) {
    return AuthData(
      email: email ?? this.email,
      password: password ?? this.password,
      fullname: fullname ?? this.fullname,
      uid: uid ?? this.uid,
      isProfessional: isProfessional ?? this.isProfessional,
      experties: experties ?? this.experties,
      focus: focus ?? this.focus,
      ratings: ratings ?? this.ratings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'fullname': fullname,
      'uid': uid,
      'isProfessional': isProfessional,
      'experties': experties,
      'focus': focus,
      'ratings': ratings.map((x) => x.toMap()).toList(),
    };
  }

  factory AuthData.fromMap(Map<String, dynamic> map) {
    return AuthData(
      email: map['email'] as String,
      password: map['password'] as String,
      fullname: map['fullname'] as String,
      uid: map['uid'] as String,
      isProfessional: map['isProfessional'] as bool,
      experties: map['experties'] as String,
      focus: map['focus'] as String,
      ratings: List<Rating>.from((map['ratings'] as List<int>).map<Rating>((x) => Rating.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthData.fromJson(String source) => AuthData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthData(email: $email, password: $password, fullname: $fullname, uid: $uid, isProfessional: $isProfessional, experties: $experties, focus: $focus, ratings: $ratings)';
  }

  @override
  bool operator ==(covariant AuthData other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password &&
      other.fullname == fullname &&
      other.uid == uid &&
      other.isProfessional == isProfessional &&
      other.experties == experties &&
      other.focus == focus &&
      listEquals(other.ratings, ratings);
  }

  @override
  int get hashCode {
    return email.hashCode ^
      password.hashCode ^
      fullname.hashCode ^
      uid.hashCode ^
      isProfessional.hashCode ^
      experties.hashCode ^
      focus.hashCode ^
      ratings.hashCode;
  }
}
