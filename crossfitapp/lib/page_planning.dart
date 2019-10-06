
import 'package:crossfitapp/event.dart';
import 'package:crossfitapp/model/user.dart';
import 'package:crossfitapp/page_prepare_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class PlanningPage extends StatefulWidget {
  PlanningPage({Key key, this.title, this.startDate, this.user}) : super(key: key);

  final String title;
  final DateTime startDate;
  final User user;

  _PlanningPageState createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  PageController _pageController;

  String _title;

  final DateFormat dayFormat = DateFormat("EEEE dd MMM");

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _title = dayFormat.format(widget.startDate);
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index){
    setState(() {
      _title = dayFormat.format(widget.startDate.add(new Duration(days: index)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          centerTitle: true,
          actions: <Widget>[
            new Text(widget.user.firstname + " " + widget.user.lastname)
          ],
        ),
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) => _onPageChanged(index),
          itemCount: Event.getTestData().keys.length,
          itemBuilder: (context, index){            
            DateTime day = widget.startDate.add(Duration(days: index));
            Map<DateTime, List<Event>> eventsByHours = Event.getTestData()[day];
            List<DateTime> hours = eventsByHours.keys.toList();

            return new DayEventsWidget(day: day, hours: hours, eventsByHours: eventsByHours);
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.event),
              title: Text('Planning'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              title: Text('Activités'),
            )
          ],
        ),
      ),
    );
  }
}

class DayEventsWidget extends StatelessWidget {
  DayEventsWidget({
    Key key,
    @required this.day,
    @required this.hours,
    @required this.eventsByHours,
  }) : super(key: key);

  final DateTime day;
  final List<DateTime> hours;
  final Map<DateTime, List<Event>> eventsByHours;
  final DateFormat hourFormat = DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hours.length,
      itemBuilder: (context, index){
        DateTime hour = hours[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                hourFormat.format(hours[index])
              ),  
            ),
            HourEventsWidget(events: eventsByHours[hour], hour: hour),
          ],
        );
      }
    );
  }
}

class HourEventsWidget extends StatelessWidget {
  const HourEventsWidget({
    Key key,
    @required this.events,
    @required this.hour,
  }) : super(key: key);

  final List<Event> events;
  final DateTime hour;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView.builder(    
          physics: const NeverScrollableScrollPhysics(),
          itemCount: events.length,
          itemBuilder: (BuildContext context, int index) {
            return new EventWidget(event: events[index]);
          }, 
          shrinkWrap: true,
        ), 
      )
    );
  }
}

class EventWidget extends StatelessWidget {
  const EventWidget({
    Key key,
    @required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    int rest = event.maxAttendees - event.totalAttendees;
    return InkWell(
      child: Card(
        elevation: 2.0,
        child: Container(
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.white24))),
              child: Icon(event.timeslottype.icon),
            ),
            title: Text(
              event.timeslottype.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            subtitle: Text("$rest places disponibles"),
            trailing:
                Icon(Icons.keyboard_arrow_right, size: 30.0)),
        ),
      ),                
      onTap: (){                  
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PrepareBookingPage(event: event))
        );
      }
    );
  }
}