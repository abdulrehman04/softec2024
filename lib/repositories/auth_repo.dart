import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:softec_app/models/auth_data.dart';

class AuthRepo {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  static Future<AuthData> signUp(Map<String, dynamic> payload) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: payload['email'],
        password: payload['password'],
      );

      final user = userCredential.user;

      payload.remove('password');
      payload['uid'] = user!.uid;

      await _firestore.collection('users').doc(user.uid).set(payload);

      final data = AuthData.fromMap(payload);
      return data;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Internal server error');
    }
  }

  static Future<AuthData> loginUser(Map<String, dynamic> payload) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: payload['email'],
        password: payload['password'],
      );

      final data = await getUser(user.user!.uid);
      return data;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Internal server error');
    }
  }

  static Future<AuthData> getUser(String uid) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();

      final data = AuthData.fromMap(userDoc.data() as Map<String, dynamic>);
      return data;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Internal server error');
    }
  }
}