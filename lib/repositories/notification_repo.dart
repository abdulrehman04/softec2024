import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:softec_app/models/notification.dart';

class NotificationRepo {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  Future<void> saveNotification(String uid, NotificationModel noti) async {
    try {
      await _firestore.collection('users').doc(uid).set(
        {
          'notifications': FieldValue.arrayUnion([noti.toMap()])
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      throw Exception('Internal server error');
    }
  }

  Future<List<NotificationModel>> getNotifications() async {
    final uid = _auth.currentUser!.uid;
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      final data = doc.data() as Map<String, dynamic>;
      final notis = data['notifications'] as List<dynamic>?;
      return notis != null
          ? notis
              .map((e) => NotificationModel.fromMap(e as Map<String, dynamic>))
              .toList()
          : [];
    } catch (e) {
      throw Exception('Internal server error');
    }
  }
}
