import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:softec_app/models/notification.dart';
import 'package:softec_app/repositories/notification_repo.dart';
import 'package:softec_app/services/notifications/service.dart';
import 'package:softec_app/widgets/core/snackbar/custom_snackbar.dart';

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

  Future<void> sendPushMessage(
      String uid, String token, String body, String title) async {
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

      NotificationRepo()
          .saveNotification(uid, NotificationModel(title: title, body: body));

      debugPrint('FCM request for device sent!');
    } catch (e) {
      debugPrint('------ $e ------');
    }
  }

  Future<void> listenNotifications(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((event) {
      _showFlutterNotification(context, event);
    });
  }

  void _showFlutterNotification(BuildContext context, RemoteMessage message) {
    final notiService = Provider.of<NotiService>(context);
    RemoteNotification? notification = message.notification;
    notiService.saveNoti(NotificationModel(
        title: notification?.title ?? '', body: notification?.body ?? ''));
    SnackBars.success(context, notification?.body ?? '');
  }
}
