import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/services/event.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventsP = Provider.of<EventService>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: eventsP.isFetchingEvents
          ? const Center(child: CircularProgressIndicator())
          : eventsP.allEvents.isEmpty
              ? Center(
                  child: Text(
                    'No events? Add an event right now!',
                    style: AppText.h2bm,
                  ),
                )
              : ListView.builder(
                  itemCount: eventsP.allEvents.length,
                  itemBuilder: (context, index) {
                    final event = eventsP.allEvents[index];
                    return ListTile(
                      title: Text(event.name),
                      subtitle: Text(event.location),
                    );
                  },
                ),
    );
  }
}
