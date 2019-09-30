
import 'package:crossfitapp/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class PlanningPage extends StatelessWidget {
  PlanningPage({Key key, this.title}) : super(key: key);

  final String title;
  final DateFormat dayFormat = DateFormat("'Planning du ' EEEE dd MMMM");
  final DateFormat hourFormat = DateFormat("HH:mm");

  final DateTime day = DateTime.now();
  final List<DateTime> days = Event.getTestData().keys.toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: buildCustomScrollView(),
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

  CustomScrollView buildCustomScrollView() {
    return CustomScrollView(
        slivers: <Widget>[
          // Add the app bar to the CustomScrollView.
          SliverAppBar(
            // Provide a standard title.
            title: Text(dayFormat.format(day) ),
            // Allows the user to reveal the app bar if they begin scrolling
            // back up the list of items.
            floating: true,
            // Display a placeholder widget to visualize the shrinking size.
            flexibleSpace: Placeholder(),
            // Make the initial height of the SliverAppBar larger than normal.
            expandedHeight: 100,
          ),
          // Next, create a SliverList
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
              (context, index) => ListTile(title: Card( child: Text('Item #$index'))),
              // Builds 1000 ListTiles
              childCount: 1000,
            ),
          ),
        ],
      );
  }

  ListView buildListViewHours(DateTime day) {
    List<DateTime> hours = Event.getTestData()[day].keys.toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: buildListViewEvents(day, hours[index]),
        );
      },
      itemCount: hours.length,
      shrinkWrap: true, // todo comment this out and check the result
      physics: ClampingScrollPhysics(), // todo comment this out and check the result
    );
  }
  
  Widget buildListViewEvents(DateTime day, DateTime hour) {
    List<Event> events = Event.getTestData()[day][hour];
    return Row(
      children: <Widget>[
        ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Card(
                child : Text(events[index].name)
              ),
            );
          },
          itemCount: events.length,
          shrinkWrap: true, // todo comment this out and check the result
          physics: ClampingScrollPhysics(), // todo comment this out and check the result
        ),
      ],
    );
  }
}

class WidgetPlanningDay {
}

class _WidgetPlanningDay extends StatelessWidget {
  _WidgetPlanningDay(this.date, this.eventsByHour);

  final DateTime date;
  final Map<DateTime, List<Event>> eventsByHour;

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView(
        children: <Widget>[
          //Text(dayFormat.format(date)),
          ListView.builder(
            itemCount: eventsByHour.length,
            itemBuilder: (BuildContext context, int index){
              return _WidgetPlanningHour(eventsByHour[index]);
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