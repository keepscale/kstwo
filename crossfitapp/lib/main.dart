import 'package:crossfitapp/bloc/account_bloc.dart';
import 'package:crossfitapp/common/main_widget.dart';
import 'package:crossfitapp/login/login_widget.dart';
import 'package:crossfitapp/model/user.dart';
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
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  User user;

  @override
  void initState() {
    super.initState();
    accountBloc.getAccount();
  }


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User>(
      stream: accountBloc.subject.stream, 
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return new Center(
              child: new CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            if (snapshot.data == null){
              return LoginWidget(onLoginSucess: (){
                setState(() {});
              });
            }
            else{
              this.user = snapshot.data;
              return MainWidget(widgetOptions: [
                new WidgetOption(
                  icon: Icon(Icons.event),
                  title: 'Planning',
                  body: PlanningPage(startDate: Event.getToday(), user: user)
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
              ]);
            }
        }
        return null; // unreachable
      }
    );
  }
}