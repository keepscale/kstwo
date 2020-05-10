

import 'package:crossfitapp/common/hexcolor.dart';
import 'package:crossfitapp/model/error.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Booking{

  Booking({this.id, this.date, this.timeslotId, this.subscriptionId});


  final int id;
  DateTime date;
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


