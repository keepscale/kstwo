
import 'package:crossfitapp/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix1;
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart' as prefix0;
import 'package:intl/intl.dart';

class PlanningPage extends StatefulWidget {
  PlanningPage({Key key, this.title, this.startDate}) : super(key: key);

  final String title;
  final DateTime startDate;

  _PlanningPageState createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  PageController _pageController;

  DateTime _day;

  final DateFormat dayFormat = DateFormat("EEEE dd MMM");
  final DateFormat hourFormat = DateFormat("HH:mm");

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _day = widget.startDate;
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index){
    setState(() {
      _day = widget.startDate.add(new Duration(days: index));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(dayFormat.format(_day)),
        ),
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) => _onPageChanged(index),
          itemCount: Event.getTestData().keys.length,
          itemBuilder: (context, index){
            return buildCustomScrollView();
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

  Widget buildCustomScrollView() {
    Map<DateTime, List<Event>> eventsByHours = Event.getTestData()[_day];
    List<DateTime> hours = eventsByHours.keys.toList();

    return ListView.builder(
      itemCount: hours.length,
      itemBuilder: (context, index){
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
                Expanded(
                  child: Container(
                    child: ListView.builder(    
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: eventsByHours[hours[index]].length,
                      itemBuilder: (BuildContext context, int index2) {
                        var event = eventsByHours[hours[index]][index2];
                        var rest = event.maxAttendees - event.totalAttendees;
                        return Card(
                          elevation: 2.0,
                          child: Container(
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                              leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: new BorderSide(width: 1.0, color: Colors.white24))),
                                child: Icon(Icons.autorenew),
                              ),
                              title: Text(
                                event.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              subtitle: Text("$rest places disponibles"),
                              trailing:
                                  Icon(Icons.keyboard_arrow_right, size: 30.0)),
                          ),
                        );
                      }, 
                      shrinkWrap: true,
                    ), 
                  )
                ),
              ],
            );
      }
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
            ;
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