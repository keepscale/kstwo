
import 'package:crossfitapp/planning/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class PrepareBookingPage extends StatelessWidget {
  PrepareBookingPage({Key key, this.event}) : super(key: key);

  final Event event;
  final DateFormat dateFormat = DateFormat("EEEE dd 'à' HH:mm");
  
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
                subtitle: Text(dateFormat.format(event.startAt)),
              ),
              ButtonBarTheme( // make buttons use the appropriate styles for cards
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text("RESERVER"),
                      onPressed: () { /* ... */ },
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