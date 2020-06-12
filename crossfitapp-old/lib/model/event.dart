

import 'package:crossfitapp/common/hexcolor.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TimeSlotType{
  

  TimeSlotType({this.name, this.icon});

  int id;
  final String name;
  final IconData icon;


  static TimeSlotType openbox = TimeSlotType(       name: "Open Box",       icon: Icons.child_friendly);
  static TimeSlotType conditionning = TimeSlotType( name: "Conditionning",  icon: Icons.whatshot);
  static TimeSlotType wod = TimeSlotType(           name: "WOD",            icon: Icons.chat_bubble);
  static TimeSlotType stamnia = TimeSlotType(       name: "Stamania",       icon: Icons.pool);
  static TimeSlotType weightlifting = TimeSlotType( name: "Weightlifting",  icon: Icons.trending_flat);
}

enum EventType { 
   FULL, 
   BOOKABLE, 
   BOOKED, 
   PAST,
   EXCLUSION,
   CLOSED_DAY 
}

class Event{

  Event({this.startAt, this.endAt, this.timeslottype});


  int id;
  String title;
  final DateTime startAt;
  final DateTime endAt;
  final TimeSlotType timeslottype;
  EventType type;
  Color color;
  bool hasSubscribeNotif;
  int totalAttendees;
  int maxAttendees;


  static DateTime getToday(){    
    DateTime now = DateTime.now();
    DateTime today = new DateTime(now.year, now.month, now.day, 0, 0, 0, 0, 0);
    return today;
  }


  static  DateFormat datetimeFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");

  static Event fromJson(data, type, color) {
    Event e = Event(
      startAt: datetimeFormat.parse(data['start']),
      endAt: datetimeFormat.parse(data['end']),
      timeslottype: new TimeSlotType(
        name: data['type'],
        icon: Icons.email
      )
    );
    e.id = data["id"];
    e.title = data["name"];
    e.totalAttendees = data["totalAttendees"];
    e.maxAttendees = data["maxAttendees"];
    e.hasSubscribeNotif = data["hasSubNotif"]??false;
    e.type = EnumToString.fromString(EventType.values, type);
    e.color = HexColor(color);
    return e;
  }
}


