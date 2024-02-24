import 'package:flutter/material.dart';
import 'package:softec_app/models/auth_data.dart';
import 'package:softec_app/repositories/auth_repo.dart';

class AuthService extends ChangeNotifier {
  AuthData? authData;
  Future<void> register(Map<String, dynamic> payload) async {
    try {
      authData = await AuthRepo.signUp(payload);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
