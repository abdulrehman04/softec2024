import 'package:flutter/material.dart';
import 'package:softec_app/repositories/notification_repo.dart';
import 'package:softec_app/models/notification.dart';

class NotiService with ChangeNotifier {
  bool isSavingNoti = false;
  List<NotificationModel> allNoti = [];
  final repo = NotificationRepo();

  void saveNoti(NotificationModel noti) {
    isSavingNoti = true;
    allNoti.add(noti);
    notifyListeners();
  }
}
