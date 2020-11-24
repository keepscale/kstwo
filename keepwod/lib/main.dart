import 'dart:developer';

import 'package:keepwod/activite/page_activite.dart';
import 'package:keepwod/common/main_widget.dart';
import 'package:keepwod/planning/page_planning.dart';
import 'package:keepwod/push/push_nofitications.dart';
import 'package:keepwod/service/auth_service.dart';
import 'package:keepwod/service/booking_service.dart';
import 'package:keepwod/service/box_service.dart';
import 'package:keepwod/service/event_service.dart';
import 'package:keepwod/service/network_client.dart';
import 'package:keepwod/service/wod_result_service.dart';
import 'package:keepwod/store/app_store.dart';
import 'package:keepwod/widget/login_widget.dart';
import 'package:keepwod/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/network_file_translation_loader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
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
        localizationsDelegates: [
          FlutterI18nDelegate(
              translationLoader: NetworkFileTranslationLoader(
                  baseUri: Uri.https(
                      "booking.crossfit-nancy.fr", "front-app/assets/i18n/"),
                  useCountryCode: false),
              missingTranslationHandler: (key, locale) {
                print(
                    "--- Missing Key: $key, languageCode: ${locale.languageCode}");
              }),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [Locale("fr")],
        home: MultiProvider(
            providers: [
              Provider(create: (_) => _networkClient),
              Provider(create: (_) => AuthService(_networkClient)),
              Provider(create: (_) => BoxService(_networkClient)),
              Provider(create: (_) => EventService(_networkClient)),
              Provider(create: (_) => BookingService(_networkClient)),
              Provider(create: (_) => WodResultService(_networkClient)),
            ],
            child: Consumer2<AuthService, BoxService>(
              builder: (context, authService, boxService, _) => Provider(
                  create: (_) => AppStore(authService, boxService),
                  child: Consumer<AppStore>(
                      builder: (context, appStore, _) => Keepwod(appStore))),
            )));
  }
}

class Keepwod extends StatefulWidget {
  PushNotificationsManager manager = new PushNotificationsManager();
  final AppStore appStore;
  Keepwod(this.appStore);

  @override
  _Keepwodtate createState() => _Keepwodtate();
}

class _Keepwodtate extends State<Keepwod> {
  ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();
    widget.manager.init();
    widget.appStore.fetchAccount();
    widget.appStore.fetchBox();

    disposer = reaction((_) => widget.appStore.user, (user) {
      log(user);
    });
  }

  @override
  void dispose() {
    this.disposer();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return (!widget.appStore.loggedIn)
          ? LoginWidget(widget.appStore)
          : MainWidget(widget.appStore, [
              new WidgetOption(
                  icon: Icon(Icons.event),
                  title: 'Planning',
                  body: PlanningPage(widget.appStore)),
              new WidgetOption(
                  icon: Icon(Icons.trending_up),
                  title: 'Activités',
                  body: ActivitePage()),
              new WidgetOption(
                  icon: Icon(Icons.account_circle),
                  title: 'Profile',
                  body: ProfileWidget(widget.appStore.user.value))
            ]);
    });
  }
}
