
import 'package:crossfitapp/model/booking.dart';
import 'package:crossfitapp/model/event.dart';
import 'package:crossfitapp/store/planning_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class PrepareBookingPage extends StatelessWidget {
  PrepareBookingPage({Key key, this.event, this.booking, this.store}) : super(key: key);

  final Event event;
  final Booking booking;
  final PlanningPageStore store;
  final DateFormat dateFormat = DateFormat("EEEEE dd 'à' HH:mm", "fr");
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(event.timeslottype.name + " " +  dateFormat.format(event.startAt)),
        ),
        body: Card(          
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(event.timeslottype.icon),
                title: Text(event.timeslottype.name),
                trailing: Text(dateFormat.format(event.startAt)),                
              ),
              Text(booking.error.message),
              Column(children: booking.error.errors.expand((detail)=>detail.reasons.map((s)=>Text(s)).toList()).toList()),
              ButtonBarTheme( // make buttons use the appropriate styles for cards
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text("RESERVER"),
                      onPressed: () { 
                        Navigator.pop(context);
                       },
                    )
                  ],
                ), data: ButtonBarThemeData(),
              ),
            ]
          )
        ),
      ),
    );
  }
}