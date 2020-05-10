import 'package:crossfitapp/model/error.dart';
import 'package:crossfitapp/store/booking_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class PrepareBookingPage extends StatelessWidget {
  PrepareBookingPage({Key key, this.booking}) : super(key: key);

  final BookingStore booking;
  final DateFormat dateFormat = DateFormat("EEEEE dd 'à' HH:mm", "fr");
  
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(booking.event.timeslottype.name + " " +  dateFormat.format(booking.event.startAt)),
            ),
            body: Card(          
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(booking.event.timeslottype.icon),
                    title: Text(booking.event.timeslottype.name),
                    subtitle: Text(dateFormat.format(booking.event.startAt)),
                  ),
                  ErrorDetail(error: booking.error),
                  ButtonBarTheme( // make buttons use the appropriate styles for cards
                    child: ButtonBar(
                      children: <Widget>[
                        Button(
                          text: "Réserver", 
                          onPressed: ()=> booking.book(), 
                          visible: booking.isBookable),
                        Button(
                          text: "Annuler ma réservation", 
                          onPressed: ()=> booking.cancel(), 
                          visible: booking.isBooked),

                      ],
                    ), data: ButtonBarThemeData(),
                  ),
                ]
              )
            ),
          ),
        ),
    );
  }
}
class ErrorDetail extends StatelessWidget {
  ErrorDetail({Key key, this.error}) : super(key: key);
  ErrorMessage error;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: 
        Column(
          children: <Widget>[
            Text(error.message??""),
            Column(children: error.errors.expand((detail)=>detail.reasons.map((s)=>Text(s)).toList()).toList()),
          ],
        ),
      visible: error != null,
    );
  }
}
class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool visible;

  const Button({Key key, this.text, this.onPressed, this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        child: FlatButton(
          child: Text(text),
          onPressed: onPressed,
        ),
        visible: visible,
    );
  }
}