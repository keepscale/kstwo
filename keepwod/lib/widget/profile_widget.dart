import 'package:keepwod/model/user.dart';
import 'package:keepwod/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(this.user, {Key key}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    final AppStore appStore = Provider.of(context);
    return Observer(builder: (_) {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(user.firstName + " " + user.lastName),
              subtitle: Text(user.email),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Se déconnecter'),
                  onPressed: () {
                    appStore.logout();
                  },
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
