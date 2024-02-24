import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:softec_app/models/notification.dart';

class NotificationRepo {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  Future<void> saveNotification(String uid, NotificationModel noti) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set(
        {
          'notifications': FieldValue.arrayUnion([noti.toMap()])
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      throw Exception('Internal server error');
    }
  }
}
