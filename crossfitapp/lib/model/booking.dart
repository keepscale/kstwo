

import 'package:crossfitapp/model/error.dart';
import 'package:crossfitapp/model/event.dart';
import 'package:intl/intl.dart';

class Booking{

  Booking({this.id, this.date, this.timeslotId, this.subscriptionId, this.createdAt});

  Event event;

  int id;
  final DateTime date;
  DateTime createdAt;
  final int timeslotId;
  int subscriptionId;

  ErrorMessage error;


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


