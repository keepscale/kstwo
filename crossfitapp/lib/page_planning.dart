
import 'package:crossfitapp/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class PlanningPage extends StatefulWidget {
  PlanningPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PlanningPageState createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {


  List<DateTime> days = Event.getTestData().keys.toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: days.length,
          itemBuilder: (BuildContext context, int index) {
            return _WidgetPlanningDay(days[index], Event.getTestData()[days[index]]);
            /*
            return InkWell(
              child: Card(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          events[index].name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  )
                ),                
                onTap: (){                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrepareBookingPage(event: events[index]))
                  );
                }
            );*/
          },
        ),
      ),
    );
  }
}

class WidgetPlanningDay {
}

class _WidgetPlanningDay extends StatefulWidget {
  _WidgetPlanningDay(this.date, this.eventsByHour);

  final DateTime date;
  final Map<DateTime, List<Event>> eventsByHour;

  @override
  __WidgetPlanningDayState createState() => __WidgetPlanningDayState();
}

class __WidgetPlanningDayState extends State<_WidgetPlanningDay> {

  DateFormat dayFormat = DateFormat("EEEE dd MMM");

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView(
        children: <Widget>[
          Text(dayFormat.format(widget.date)),
          ListView.builder(
            itemCount: widget.eventsByHour.length,
            itemBuilder: (BuildContext context, int index){
              return _WidgetPlanningHour(widget.eventsByHour[index]);
            },
          )
        ],
      )       
    );
  }
}

class _WidgetPlanningHour extends StatefulWidget {
  _WidgetPlanningHour(this.events);
  
  final List<Event> events;


  @override
  __WidgetPlanningHourState createState() => __WidgetPlanningHourState();
  
}

class __WidgetPlanningHourState extends State<_WidgetPlanningHour>{
  
  DateFormat hourFormat = DateFormat("HH:mm");
  
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      SizedBox(width: 32, child: Text(hourFormat.format(widget.events[0].startAt))),
      ListView.builder(
          itemCount: widget.events.length,
          itemBuilder: (BuildContext context, int index){
            return ListTile(
              title: Text(widget.events[index].name),
              subtitle: Text(widget.events[index].totalAttendees.toString() + "/" + widget.events[index].maxAttendees.toString()),
            );
          },
        )
    ],);
  }
}