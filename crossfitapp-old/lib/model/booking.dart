

import 'package:crossfitapp/model/error.dart';
import 'package:crossfitapp/model/timeslot.dart';
import 'package:intl/intl.dart';

class Booking{

  Booking({this.id, this.date, this.timeslotId, this.subscriptionId, this.createdAt});

  int id;
  final DateTime date;
  DateTime createdAt;
  final int timeslotId;
  int subscriptionId;

  ErrorMessage error;

  TimeSlotStatus timeSlotStatus;

  static  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  static  DateFormat dateTimeFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");

  static Booking fromJson(data) {
    Booking e = Booking(
      id: data["id"],
      date: data['date'] != null ? dateFormat.parse(data['date']) : null,
      timeslotId: data["timeslotId"],
      subscriptionId: data["subscriptionId"],
      createdAt: data['createdAt'] != null ? dateTimeFormat.parse(data['createdAt']) : null,
    );
    e.error = ErrorMessage.fromJson(data);
    return e;
  }
}


