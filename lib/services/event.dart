import 'package:flutter/material.dart';
import 'package:softec_app/models/event.dart';
import 'package:softec_app/repositories/event_repo.dart';

class EventService extends ChangeNotifier {
  bool isCreatingEvent = false;
  bool isFetchingEvents = false;
  List<Event> allEvents = [];
  final repo = EventRepo();

  Future<bool> createEvent(Event event) async {
    try {
      isCreatingEvent = true;
      notifyListeners();
      await repo.saveEvent(
        event.name,
        event.url,
        event.location,
        event.startDate,
        event.endDate,
        event.id,
        event.participants,
      );
      allEvents.add(event);
      isCreatingEvent = false;
      notifyListeners();
      return true;
    } catch (e) {
      isCreatingEvent = false;
      notifyListeners();
      return false;
    }
  }

  void fetchEvents() async {
    isFetchingEvents = true;
    allEvents = await repo.getEvents();
    isFetchingEvents = false;
    notifyListeners();
  }
}
