
import 'package:crossfitapp/activite/page_activite.dart';
import 'package:crossfitapp/common/main_widget.dart';
import 'package:crossfitapp/planning/page_planning.dart';
import 'package:crossfitapp/push/push_nofitications.dart';
import 'package:crossfitapp/service/auth_service.dart';
import 'package:crossfitapp/service/booking_service.dart';
import 'package:crossfitapp/service/event_service.dart';
import 'package:crossfitapp/service/network_client.dart';
import 'package:crossfitapp/service/wod_result_service.dart';
import 'package:crossfitapp/store/app_store.dart';
import 'package:crossfitapp/widget/login_widget.dart';
import 'package:crossfitapp/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/network_file_translation_loader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';   
import 'package:provider/provider.dart';


Future<void> main() async {    
  
  runApp(App(NetworkClient()));
} 

class App extends StatelessWidget {

  final NetworkClient _networkClient;
  App(this._networkClient);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter login UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        
        FlutterI18nDelegate(
          translationLoader: NetworkFileTranslationLoader(baseUri: Uri.https("booking.crossfit-nancy.fr", "front-app/assets/i18n/"), useCountryCode: false),
          missingTranslationHandler: (key, locale) {
            print("--- Missing Key: $key, languageCode: ${locale.languageCode}");
          }
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        Locale("fr")
      ],
      home: MultiProvider(
        providers: [
          Provider(create: (_)  =>  _networkClient),
          Provider(create: (_)  =>  AuthService(_networkClient)),
          Provider(create: (_)  =>  EventService(_networkClient)),
          Provider(create: (_)  =>  BookingService(_networkClient)),
          Provider(create: (_)  =>  WodResultService(_networkClient)),
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
        return 
              (widget.appStore.logginPending) ?

              LoadingWidget() :

              (!widget.appStore.loggedIn) ?
              
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
                  body: ActivitePage()
                ),
                new WidgetOption(
                  icon: Icon(Icons.account_circle),
                  title: 'Profile',
                  body: ProfileWidget(widget.appStore.user.value)
                )
              ]);
        });
  }
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Chargement en cours"),
            CircularProgressIndicator(),
          ],
        ),
      )
    );
  }
}