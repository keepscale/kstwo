

import 'package:crossfitapp/planning/event.dart';
import 'package:intl/intl.dart';

class Booking{

  Booking({this.id, this.date, this.timeslotId, this.subscriptionId});

  Event event;

  int id;
  final DateTime date;
  final int timeslotId;
  int subscriptionId;



  static  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  static Booking fromJson(data) {
    Booking e = Booking(
      id: data["id"],
      date: dateFormat.parse(data['date']),
      timeslotId: data["timeslotId"],
      subscriptionId: data["subscriptionId"],
    );
    return e;
  }
}


