import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:softec_app/models/event.dart';

class EventRepo {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  Future<void> saveEvent(
    String name,
    String location,
    DateTime date,
    String id,
    List<String> participants,
  ) async {
    try {
      final event = Event(
        name: name,
        location: location,
        date: date,
        id: id,
        participants: participants,
      ).toMap();

      await _firestore.collection('events').add(event);
    } catch (e) {
      throw Exception('Internal server error');
    }
  }

  Future<List<Event>> getEvents() async {
    try {
      final data = await _firestore.collection('events').get();
      if (data.docs.isEmpty) return [];
      return data.docs.map((e) => Event.fromMap(e.data())).toList();
    } catch (e) {
      throw Exception('Internal server error');
    }
  }

  Future<List<Event>> getMyEvents() async {
    final uid = _auth.currentUser!.uid;
    try {
      final data = await _firestore
          .collection('events')
          .where('participants', arrayContains: uid)
          .get();
      return data.docs.map((e) => Event.fromMap(e.data())).toList();
    } catch (e) {
      throw Exception('Internal server error');
    }
  }
}
