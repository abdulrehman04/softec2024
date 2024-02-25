import 'package:softec_app/models/event.dart';

class AppUtils {
  static String getStatus(Event event) {
    final now = DateTime.now();
    if (now.isBefore(event.startDate)) {
      return 'Upcoming';
    } else if (now.isAfter(event.startDate) && now.isBefore(event.endDate)) {
      return 'Live';
    } else {
      return 'Ended';
    }
  }
}
