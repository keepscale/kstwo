
import 'package:crossfitapp/event.dart';
import 'package:crossfitapp/page_prepare_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlanningPage extends StatefulWidget {
  PlanningPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PlanningPageState createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {

  List<Event> events = Event.getTestData();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (index >= events.length){
              return null;
            }
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
            );
          },
        ),
      ),
    );
  }
}