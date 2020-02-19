

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TimeSlotType{
  

  const TimeSlotType({this.name, this.icon});

  final String name;
  final IconData icon;


  static const TimeSlotType openbox = TimeSlotType(       name: "Open Box",       icon: Icons.child_friendly);
  static const TimeSlotType conditionning = TimeSlotType( name: "Conditionning",  icon: Icons.whatshot);
  static const TimeSlotType wod = TimeSlotType(           name: "WOD",            icon: Icons.chat_bubble);
  static const TimeSlotType stamnia = TimeSlotType(       name: "Stamania",       icon: Icons.pool);
  static const TimeSlotType weightlifting = TimeSlotType( name: "Weightlifting",  icon: Icons.trending_flat);
}
class Event{

  Event({this.startAt, this.endAt, this.timeslottype});

  final DateTime startAt;
  final DateTime endAt;
  final TimeSlotType timeslottype;

  int totalAttendees = 5;
  int maxAttendees = 15;


  static DateTime getToday(){    
    DateTime now = DateTime.now();
    DateTime today = new DateTime(now.year, now.month, now.day, 0, 0, 0, 0, 0);
    return today;
  }


  static Map<DateTime, Map<DateTime, List<Event>>> getTestData() {
    DateTime today = getToday();
    DateTime now = new DateTime(today.year, today.month, today.day, 8, 0, 0, 0, 0);
    return {
      today.add(Duration(days: 0)) : {
        now.add(Duration(hours: 0)) : [
          Event(startAt: now.add(Duration(hours: 0)), endAt: now.add(Duration(hours: 1)), timeslottype:TimeSlotType.openbox),
          Event(startAt: now.add(Duration(hours: 0)), endAt: now.add(Duration(hours: 1)), timeslottype:TimeSlotType.conditionning),
        ],
        now.add(Duration(hours: 1)) : [
          Event(startAt: now.add(Duration(hours: 1)), endAt: now.add(Duration(hours: 2)), timeslottype:TimeSlotType.openbox),
          Event(startAt: now.add(Duration(hours: 1)), endAt: now.add(Duration(hours: 2)), timeslottype:TimeSlotType.wod),
        ],
        now.add(Duration(hours: 2)) : [
          Event(startAt: now.add(Duration(hours: 2)), endAt: now.add(Duration(hours: 3)), timeslottype:TimeSlotType.openbox),
        ],
        now.add(Duration(hours: 3)) : [
          Event(startAt: now.add(Duration(hours: 2)), endAt: now.add(Duration(hours: 3)), timeslottype:TimeSlotType.openbox),
        ],
        now.add(Duration(hours: 4, minutes: 30)) : [
          Event(startAt: now.add(Duration(hours: 4)), endAt: now.add(Duration(hours: 5)), timeslottype:TimeSlotType.conditionning),
        ],
        now.add(Duration(hours: 6)) : [
          Event(startAt: now.add(Duration(hours: 6)), endAt: now.add(Duration(hours: 7)), timeslottype:TimeSlotType.openbox),
          Event(startAt: now.add(Duration(hours: 6)), endAt: now.add(Duration(hours: 7)), timeslottype:TimeSlotType.stamnia),
          Event(startAt: now.add(Duration(hours: 6)), endAt: now.add(Duration(hours: 7)), timeslottype:TimeSlotType.conditionning),
        ],
        now.add(Duration(hours: 7)) : [
          Event(startAt: now.add(Duration(hours: 7)), endAt: now.add(Duration(hours: 8)), timeslottype:TimeSlotType.wod),
        ],
      },      
      today.add(Duration(days: 1)) : {
        now.add(Duration(days: 1, hours: 0)) : [
          Event(startAt: now.add(Duration(days: 1, hours: 0)), endAt: now.add(Duration(days: 1, hours: 1)), timeslottype:TimeSlotType.openbox),
          Event(startAt: now.add(Duration(days: 1, hours: 0)), endAt: now.add(Duration(days: 1, hours: 1)), timeslottype:TimeSlotType.conditionning),
        ],
        now.add(Duration(days: 1, hours: 1)) : [
          Event(startAt: now.add(Duration(days: 1, hours: 1)), endAt: now.add(Duration(days: 1, hours: 2)), timeslottype:TimeSlotType.openbox),
          Event(startAt: now.add(Duration(days: 1, hours: 1)), endAt: now.add(Duration(days: 1, hours: 2)), timeslottype:TimeSlotType.wod),
        ],
      },      
      today.add(Duration(days: 2)) : {
        now.add(Duration(days: 2, hours: 0)) : [
          Event(startAt: now.add(Duration(days: 2, hours: 0)), endAt: now.add(Duration(days: 2, hours: 1)), timeslottype:TimeSlotType.openbox),
          Event(startAt: now.add(Duration(days: 2, hours: 0)), endAt: now.add(Duration(days: 2, hours: 1)), timeslottype:TimeSlotType.conditionning),
        ],
        now.add(Duration(days: 2, hours: 1)) : [
          Event(startAt: now.add(Duration(days: 2, hours: 1)), endAt: now.add(Duration(days: 2, hours: 2)), timeslottype:TimeSlotType.openbox),
          Event(startAt: now.add(Duration(days: 2, hours: 1)), endAt: now.add(Duration(days: 2, hours: 2)), timeslottype:TimeSlotType.wod),
        ],
      },      
      today.add(Duration(days: 3)) : {
        now.add(Duration(days: 3, hours: 0)) : [
          Event(startAt: now.add(Duration(days: 3, hours: 0)), endAt: now.add(Duration(days: 3, hours: 1)), timeslottype:TimeSlotType.openbox),
          Event(startAt: now.add(Duration(days: 3, hours: 0)), endAt: now.add(Duration(days: 3, hours: 1)), timeslottype:TimeSlotType.conditionning),
        ],
        now.add(Duration(days: 3, hours: 1)) : [
          Event(startAt: now.add(Duration(days: 3, hours: 1)), endAt: now.add(Duration(days: 3, hours: 2)), timeslottype:TimeSlotType.openbox),
          Event(startAt: now.add(Duration(days: 3, hours: 1)), endAt: now.add(Duration(days: 3, hours: 2)), timeslottype:TimeSlotType.wod),
        ],
      }
    };
  }
}


