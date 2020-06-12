
import 'package:crossfitapp/common/main_widget.dart';
import 'package:crossfitapp/planning/page_planning.dart';
import 'package:crossfitapp/push/push_nofitications.dart';
import 'package:crossfitapp/service/auth_service.dart';
import 'package:crossfitapp/service/event_service.dart';
import 'package:crossfitapp/service/network_client.dart';
import 'package:crossfitapp/store/app_store.dart';
import 'package:crossfitapp/widget/login_widget.dart';
import 'package:crossfitapp/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';   
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main(){    
  initializeDateFormatting('fr_FR', null);

  runApp(App(NetworkClient()));
} 

class App extends StatelessWidget {

  final NetworkClient _networkClient;
  App(this._networkClient);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_)  =>  _networkClient),
        Provider(create: (_)  =>  AuthService(_networkClient)),
        Provider(create: (_)  =>  EventService(_networkClient)),
      ],
      child: Consumer<AuthService>(
        builder: (context, authService, _) => 
          Provider(
            create: (_) => AppStore(authService),
            child: Consumer<AppStore>(
              builder: (context, appStore, _) => CrossfitApp(appStore)
            )
          ),
      )
    );
  }
}

class CrossfitApp extends StatefulWidget {

  PushNotificationsManager manager = new PushNotificationsManager();
  final AppStore appStore;
  CrossfitApp(this.appStore);

  @override
  _CrossfitAppState createState() => _CrossfitAppState();
}

class _CrossfitAppState extends State<CrossfitApp> {

  @override
  void initState() {
    super.initState();
    widget.manager.init();
    widget.appStore.fetchAccount();
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
          home: (!widget.appStore.loggedIn) ?
              LoginWidget(widget.appStore) :              
              MainWidget(widget.appStore, [
                new WidgetOption(
                  icon: Icon(Icons.event),
                  title: 'Planning',
                  body: PlanningPage(widget.appStore)
                ),
                new WidgetOption(
                  icon: Icon(Icons.trending_up),
                  title: 'Activités',
                  body: new Text("Httlo")
                ),
                new WidgetOption(
                  icon: Icon(Icons.account_circle),
                  title: 'Profile',
                  body: ProfileWidget(widget.appStore.user.value)
                )
              ])
          );
        });
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