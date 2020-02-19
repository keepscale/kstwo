
import 'package:crossfitapp/common/main_widget.dart';
import 'package:crossfitapp/login/login_widget.dart';
import 'package:crossfitapp/planning/event.dart';
import 'package:crossfitapp/planning/page_planning.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool loggedIn = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: loggedIn ? MainWidget(widgetOptions: [
        new WidgetOption(
          icon: Icon(Icons.event),
          title: 'Planning',
          body: PlanningPage(startDate: Event.getToday(),)
        ),
        new WidgetOption(
          icon: Icon(Icons.trending_up),
          title: 'Activités',
          body: new Text("Httlo")
        ),
        new WidgetOption(
          icon: Icon(Icons.account_circle),
          title: 'Profile',
          body: new Text("yopythyt")
        )
      ]) : LoginWidget(),
    );
  }
}