part of '../login.dart';

class _FormData {
  static Map<String, dynamic> initialValues() {
    if (!kDebugMode) {
      return {};
    }

    return {
      'email': 'test1@test.com',
      'password': 'test123',
    };
  }
}
