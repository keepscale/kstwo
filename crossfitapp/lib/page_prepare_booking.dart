
import 'package:crossfitapp/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class PrepareBookingPage extends StatefulWidget {
  PrepareBookingPage({Key key, this.event}) : super(key: key);

  final Event event;

  @override
  _PrepareBookingPageState createState() => _PrepareBookingPageState();
}

class _PrepareBookingPageState extends State<PrepareBookingPage> {
  DateFormat dateFormat = DateFormat("EEEE dd MMM 'à' HH:mm");
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Détail d'une séance"),
        ),
        body: Card(          
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
                title: Text("Séance " + widget.event.name, textAlign: TextAlign.center,),
                subtitle: Text(dateFormat.format(widget.event.startAt)),
            ),
          ),
        ),
      ),
    );
  }
}