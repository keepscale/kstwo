import 'package:crossfitapp/event.dart';
import 'package:crossfitapp/model/user.dart';
import 'package:crossfitapp/page_login.dart';
import 'package:crossfitapp/page_planning.dart';
import 'package:crossfitapp/services/auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
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