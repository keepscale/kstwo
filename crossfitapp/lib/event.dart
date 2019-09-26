class Event{

  Event({this.startAt, this.endAt, this.name});

  final String name;
  final DateTime startAt;
  final DateTime endAt;

  int timeslotId;
  int totalAttendees;
  int maxAttendees;



  static List<Event> getTestData() {
    DateTime now = DateTime.now();
    return [
      Event(startAt: now.add(Duration(hours: 0)), endAt: now.add(Duration(hours: 1)), name:"Open Box"),
      Event(startAt: now.add(Duration(hours: 2)), endAt: now.add(Duration(hours: 3)), name:"Conditionning"),
      Event(startAt: now.add(Duration(hours: 4)), endAt: now.add(Duration(hours: 5)), name:"WOD"),
    ];
  }
}


