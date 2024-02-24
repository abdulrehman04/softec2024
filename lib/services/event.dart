import 'package:flutter/material.dart';
import 'package:softec_app/models/event.dart';
import 'package:softec_app/repositories/event_repo.dart';

class EventService extends ChangeNotifier {
  bool isCreatingEvent = false;
  bool isFetchingEvents = false;
  List<Event> allEvents = [];
  final repo = EventRepo();

  void createEvent(Event event) async {
    isCreatingEvent = true;
    notifyListeners();
    await repo.saveEvent(
      event.name,
      event.location,
      event.startDate,
      event.endDate,
      event.id,
      event.participants,
    );
    allEvents.add(event);
    isCreatingEvent = false;
    notifyListeners();
  }

  void fetchEvents() async {
    isFetchingEvents = true;
    allEvents = await repo.getEvents();
    isFetchingEvents = false;
    notifyListeners();
  }
}
