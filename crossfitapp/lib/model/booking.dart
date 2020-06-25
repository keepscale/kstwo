

import 'package:crossfitapp/model/error.dart';
import 'package:crossfitapp/model/timeslot.dart';
import 'package:crossfitapp/model/wod.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class Booking{

  Booking({this.id, this.date, this.startAt, this.timeslotId, this.subscriptionId, this.createdAt, this.title});

  int id;
  final DateTime date;
  DateTime createdAt;
  final int timeslotId;
  int subscriptionId;

  DateTime startAt;
  String title;

  ErrorMessage error;

  TimeSlotStatus timeSlotStatus;

  List<Wod> wods;

  static  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  static  DateFormat dateTimeFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");

  static Booking fromJson(data) {
    Booking e = Booking(
      id: data["id"],
      date: data['date'] != null ? dateFormat.parse(data['date']) : null,
      startAt: data['startAt'] != null ? dateTimeFormat.parse(data['startAt']) : null,
      timeslotId: data["timeslotId"],
      subscriptionId: data["subscriptionId"],
      createdAt: data['createdAt'] != null ? dateTimeFormat.parse(data['createdAt']) : null,
      title: data['title'] != null ? (data['title'] as String).replaceAll("'", "") : null,
    );
    e.error = ErrorMessage.fromJson(data);
    return e;
  }
}


