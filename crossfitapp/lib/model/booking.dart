

import 'package:crossfitapp/model/error.dart';
import 'package:crossfitapp/model/event.dart';
import 'package:intl/intl.dart';

class Booking{

  Booking({this.id, this.date, this.timeslotId, this.subscriptionId});

  Event event;

  int id;
  final DateTime date;
  final int timeslotId;
  int subscriptionId;

  ErrorMessage error;


  static  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  static Booking fromJson(data) {
    Booking e = Booking(
      id: data["id"],
      date: data['date'] != null ? dateFormat.parse(data['date']) : null,
      timeslotId: data["timeslotId"],
      subscriptionId: data["subscriptionId"],
    );
    e.error = ErrorMessage.fromJson(data);
    return e;
  }
}


