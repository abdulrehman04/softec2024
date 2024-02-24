import 'package:firebase_messaging/firebase_messaging.dart';
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

      final deviceToken = await FirebaseMessaging.instance.getToken();

      authData = await AuthRepo.loginUser(payload);
      await AuthRepo.setToken(authData!.uid, deviceToken ?? '');
      authData!.deviceToken = deviceToken;

      fetchAllUsers();
      isLoginLoading = false;
      notifyListeners();
    } catch (e) {
      isLoginLoading = false;
      notifyListeners();
      debugPrint(e.toString());
      rethrow;
    }
  }

  List<AuthData> allUsers = [];
  bool isFetchingUsers = false;

  Future<void> fetchAllUsers() async {
    try {
      isFetchingUsers = true;
      allUsers = await AuthRepo.fetchAllUsers();
      allUsers!.removeWhere((element) => element.uid == authData!.uid);
      isFetchingUsers = false;
      notifyListeners();
    } catch (e) {
      isFetchingUsers = false;
      notifyListeners();
      debugPrint(e.toString());
      rethrow;
    }
  }
}
