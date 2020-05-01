import 'package:crossfitapp/common/app_store.dart';
import 'package:crossfitapp/login/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CrossfitApp();
  }
}

class CrossfitApp extends StatefulWidget {

  @override
  _CrossfitAppState createState() => _CrossfitAppState();
}

class _CrossfitAppState extends State<CrossfitApp> {

  final appStore = AppStore();

  @override
  void initState() {
    super.initState();
    appStore.fetchAccount();
  }


  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return MaterialApp(
          title: 'Flutter login UI',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: appStore.loggedIn ? Text("logged in") : LoginWidget(appStore: appStore),
        );
      }
    );
  }
}

/*
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator(this.appStore);

  final App appStore;

  @override
  Widget build(BuildContext context) => Observer(
      builder: (_) => appStore.user.status == FutureStatus.pending
          ? const LinearProgressIndicator()
          : Container());
}

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
              */