import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:softec_app/models/auth_data.dart';
import 'package:softec_app/repositories/auth_repo.dart';
import 'package:softec_app/widgets/core/snackbar/custom_snackbar.dart';

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
  bool isEmailNotVerified = false;
  Future<void> login(Map<String, dynamic> payload) async {
    try {
      isLoginLoading = true;
      notifyListeners();

      final deviceToken = await FirebaseMessaging.instance.getToken();

      authData = await AuthRepo.loginUser(payload);
      if (authData == null) {
        isLoginLoading = false;
        isEmailNotVerified = true;
        notifyListeners();
        return;
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      await AuthRepo.setTokenAndLocation(
        authData!.uid,
        deviceToken ?? '',
        position,
      );
      authData!.deviceToken = deviceToken;

      fetchAllUsers();
      isLoginLoading = false;
      notifyListeners();
    } catch (e) {
      isLoginLoading = false;
      notifyListeners();
      debugPrint(e.toString());
      // if (e.toString().contains('Email not verified')) {
      //   isEmailNotVerified = true;
      //   if (!context.mounted) return;
      //   print('here');
      //   SnackBars.failure(
      //     context,
      //     'Please verify your email address',
      //   );
      //   notifyListeners();
      // }
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

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      isFetchingUsers = false;
      allUsers = [];
      isLoginLoading = false;
      isRegisterLoading = false;
      isEmailNotVerified = false;
      authData = null;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
