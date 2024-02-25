part of '../login.dart';

class _FormData {
  static Map<String, dynamic> initialValues() {
    if (!kDebugMode) {
      return {};
    }

    return {
      'email': 'abdulrehman71255@gmail.com',
      'password': '12345678',
    };
  }
}
