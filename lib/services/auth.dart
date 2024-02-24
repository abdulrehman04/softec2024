import 'package:flutter/material.dart';
import 'package:softec_app/models/auth_data.dart';
import 'package:softec_app/repositories/auth_repo.dart';

class AuthService extends ChangeNotifier {
  bool isRegisterLoading = false;
  AuthData? authData;
  Future<void> register(Map<String, dynamic> payload) async {
    try {
      isRegisterLoading = true;
      notifyListeners();
      
      authData = await AuthRepo.signUp(payload);
      isRegisterLoading = false;
      notifyListeners();
    } catch (e) {
      isRegisterLoading = false;
      notifyListeners();
      debugPrint(e.toString());
      rethrow;
    }
  }

  bool isLoginLoading = false;
  Future<void> login(Map<String, dynamic> payload) async {
    try {
      isLoginLoading = true;
      notifyListeners();

      authData = await AuthRepo.loginUser(payload);
      isLoginLoading = false;
      notifyListeners();
    } catch (e) {
      isLoginLoading = false;
      notifyListeners();
      debugPrint(e.toString());
      rethrow;
    }
  }
}
