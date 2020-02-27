
import 'package:crossfitapp/common/main_widget.dart';
import 'package:crossfitapp/login/login_widget.dart';
import 'package:crossfitapp/model/user.dart';
import 'package:crossfitapp/page_login.dart';
import 'package:crossfitapp/planning/event.dart';
import 'package:crossfitapp/planning/page_planning.dart';
import 'package:crossfitapp/services/auth.dart';
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

class LandingPage extends StatefulWidget {

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  User user;

  @override
  Widget build(BuildContext context) {

    if (this.user != null)
      return PlanningPage(title: 'Planning', startDate: Event.getToday(), user: user);
    else
      return FutureBuilder<User>(
        future: AuthService.account(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              if (snapshot.data == null){
                return LoginPage(onLoginSucess: (){
                  setState(() {});
                });
              }
              else{
                this.user = snapshot.data;
                return PlanningPage(title: 'Planning', startDate: Event.getToday(), user: user);
              }
          }
          return null; // unreachable
        }
      );
  }
}