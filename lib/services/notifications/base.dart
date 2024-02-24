import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationBase {
  static Future init(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    const androidPlatformSpecific = AndroidNotificationDetails(
      'softec_2024',
      'channel_name',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    const not = NotificationDetails(android: androidPlatformSpecific);

    await fln.show(id, title, body, not);
  }

  String _constructFCMPayload(String? token, String body, String title) {
    return jsonEncode({
      'to': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging',
      },
      'notification': {
        'title': title,
        'body': body,
      },
    });
  }

  Future<void> sendPushMessage(String token, String body, String title) async {
    try {
      const serverKey =
          'AAAAFVE7aY0:APA91bGGy9agjDCcdPvsxJ9uBxX-bR24H_-tzdTazzngiwqSuz2b5Zt8HeHOyenYJbxuRcKTyxV3hrih2QB-BFJtHq-MmShXNXk4mK3DIoqPYoBMIJxslf_mnzY5UQIpxDRRrwYaSb5E';

      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$serverKey'
        },
        body: _constructFCMPayload(token, body, title),
      );
      debugPrint('FCM request for device sent!');
    } catch (e) {
      debugPrint('------ $e ------');
    }
  }
}
