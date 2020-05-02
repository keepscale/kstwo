
import 'dart:collection';

import 'package:crossfitapp/common/main_widget.dart';
import 'package:crossfitapp/model/user.dart';
import 'package:crossfitapp/planning/event.dart';
import 'package:crossfitapp/planning/page_prepare_booking.dart';
import 'package:crossfitapp/service/event_service.dart';
import 'package:crossfitapp/store/app_store.dart';
import 'package:crossfitapp/store/planning_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import "package:collection/collection.dart";
import 'package:provider/provider.dart';


class PlanningPage extends StatefulWidget {
  PlanningPage(this.planningStore, this.appStore, {Key key}) : super(key: key);

  final PlanningStore planningStore;
  final AppStore appStore;


  _PlanningPageState createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  PageController _pageController;

  final DateFormat dayFormat = DateFormat("EEEEE dd MMMM", "fr_FR");

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    this.widget.planningStore.load();
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index, BuildContext context){
    widget.planningStore.add(Duration(days: index));
    widget.appStore.setAppBatTitle(
      dayFormat.format(widget.planningStore.currenDate));
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) => _onPageChanged(index, context),
      itemCount: 14,
      itemBuilder: (context, index){  
        return new DayEventsWidget(day: widget.planningStore.currenDate, eventsByHours: widget.planningStore.eventsByHours);
      },
    );
  }
}

class DayEventsWidget extends StatelessWidget {
  DayEventsWidget({
    Key key,
    @required this.day,
    @required this.eventsByHours,
  }) : super(key: key){
    this.hours = eventsByHours.keys.toList();
  }

  final DateTime day;
  final Map<DateTime, List<Event>> eventsByHours;
  List<DateTime> hours;
  final DateFormat hourFormat = DateFormat("H:mm");

  @override
  Widget build(BuildContext context) {
    if (hours.isEmpty)
      return Text("Aucun créneau disponible");
    return ListView.builder(
      itemCount: hours.length,
      itemBuilder: (context, index){
        DateTime hour = hours[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HourEventsWidget(events: eventsByHours[hour], hour: hour),
          ],
        );
      }
    );
  }
}

class HourEventsWidget extends StatelessWidget {
  HourEventsWidget({
    Key key,
    @required this.events,
    @required this.hour,
  }) : super(key: key);

  final List<Event> events;
  final DateTime hour;
  final DateFormat hourFormat = DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 15.0,
                bottom: 2.0
              ),
              child:  Text(
                hourFormat.format(hour),
              )
            ),
            ListView.builder(    
              physics: const NeverScrollableScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (BuildContext context, int index) {
                return new EventWidget(event: events[index]);
              }, 
              shrinkWrap: true,
              )
          ]
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
              event.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            subtitle: Text("$rest places disponibles", style: TextStyle(color: event.color)),
            trailing: event.type == EventType.BOOKED ? Icon(Icons.star, size: 30.0, color: Colors.yellowAccent,) : Icon(Icons.keyboard_arrow_right, size: 30.0)
          ),
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