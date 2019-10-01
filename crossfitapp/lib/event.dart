class Event{

  Event({this.startAt, this.endAt, this.name});

  final String name;
  final DateTime startAt;
  final DateTime endAt;

  int timeslotId = 1;
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
          Event(startAt: now.add(Duration(hours: 0)), endAt: now.add(Duration(hours: 1)), name:"Open Box"),
          Event(startAt: now.add(Duration(hours: 0)), endAt: now.add(Duration(hours: 1)), name:"Conditionning"),
        ],
        now.add(Duration(hours: 1)) : [
          Event(startAt: now.add(Duration(hours: 1)), endAt: now.add(Duration(hours: 2)), name:"Open Box"),
          Event(startAt: now.add(Duration(hours: 1)), endAt: now.add(Duration(hours: 2)), name:"WOD"),
        ],
        now.add(Duration(hours: 2)) : [
          Event(startAt: now.add(Duration(hours: 2)), endAt: now.add(Duration(hours: 3)), name:"Open Box"),
        ],
        now.add(Duration(hours: 3)) : [
          Event(startAt: now.add(Duration(hours: 2)), endAt: now.add(Duration(hours: 3)), name:"Open Box"),
        ],
        now.add(Duration(hours: 4, minutes: 30)) : [
          Event(startAt: now.add(Duration(hours: 4)), endAt: now.add(Duration(hours: 5)), name:"Conditionning"),
        ],
      },      
      today.add(Duration(days: 1)) : {
        now.add(Duration(days: 1, hours: 0)) : [
          Event(startAt: now.add(Duration(days: 1, hours: 0)), endAt: now.add(Duration(days: 1, hours: 1)), name:"Open Box"),
          Event(startAt: now.add(Duration(days: 1, hours: 0)), endAt: now.add(Duration(days: 1, hours: 1)), name:"Conditionning"),
        ],
        now.add(Duration(days: 1, hours: 1)) : [
          Event(startAt: now.add(Duration(days: 1, hours: 1)), endAt: now.add(Duration(days: 1, hours: 2)), name:"Open Box"),
          Event(startAt: now.add(Duration(days: 1, hours: 1)), endAt: now.add(Duration(days: 1, hours: 2)), name:"WOD"),
        ],
      },      
      today.add(Duration(days: 2)) : {
        now.add(Duration(days: 2, hours: 0)) : [
          Event(startAt: now.add(Duration(days: 2, hours: 0)), endAt: now.add(Duration(days: 2, hours: 1)), name:"Open Box"),
          Event(startAt: now.add(Duration(days: 2, hours: 0)), endAt: now.add(Duration(days: 2, hours: 1)), name:"Conditionning"),
        ],
        now.add(Duration(days: 2, hours: 1)) : [
          Event(startAt: now.add(Duration(days: 2, hours: 1)), endAt: now.add(Duration(days: 2, hours: 2)), name:"Open Box"),
          Event(startAt: now.add(Duration(days: 2, hours: 1)), endAt: now.add(Duration(days: 2, hours: 2)), name:"WOD"),
        ],
      },      
      today.add(Duration(days: 3)) : {
        now.add(Duration(days: 3, hours: 0)) : [
          Event(startAt: now.add(Duration(days: 3, hours: 0)), endAt: now.add(Duration(days: 3, hours: 1)), name:"Open Box"),
          Event(startAt: now.add(Duration(days: 3, hours: 0)), endAt: now.add(Duration(days: 3, hours: 1)), name:"Conditionning"),
        ],
        now.add(Duration(days: 3, hours: 1)) : [
          Event(startAt: now.add(Duration(days: 3, hours: 1)), endAt: now.add(Duration(days: 3, hours: 2)), name:"Open Box"),
          Event(startAt: now.add(Duration(days: 3, hours: 1)), endAt: now.add(Duration(days: 3, hours: 2)), name:"WOD"),
        ],
      }
    };
  }
}


