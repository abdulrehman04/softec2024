import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/models/event.dart';
import 'package:softec_app/router/router.dart';
import 'package:softec_app/screens/add_event/add_event.dart';
import 'package:softec_app/services/event.dart';
import 'package:softec_app/utils/app_utils.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventsP = Provider.of<EventService>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppRouter.push(context, const AddEventScreen());
        },
        child: const Icon(Icons.add),
      ),
      body: eventsP.isFetchingEvents
          ? const Center(child: CircularProgressIndicator())
          : eventsP.allEvents.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'No events? Add an event right now!',
                      style: AppText.h2bm,
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: eventsP.allEvents.length,
                  itemBuilder: (context, index) {
                    final event = eventsP.allEvents[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(event.name),
                          subtitle: Text(event.location),
                          trailing: Text(
                            AppUtils.getStatus(event),
                            style: AppText.b1!.cl(getColor(event)),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Space.y2!,
                ),
    );
  }

  Color getColor(Event event) {
    final status = AppUtils.getStatus(event);
    if (status == 'Upcoming') {
      return Colors.yellow;
    } else if (status == 'Live') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
