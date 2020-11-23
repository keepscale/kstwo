import 'package:keepwod/store/app_store.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget(this.appStore, {Key key}) : super(key: key);

  final AppStore appStore;

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void onLoginPressed() {
    if (_formKey.currentState.validate()) {
      this.widget.appStore.login(emailController.text, passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: ListView(
                children: <Widget>[
                  Image.network(
                    "https://www.crossfit-nancy.fr/img/logo_web.png",
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Connexion",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Adresse e-mail',
                      labelText: "Adresse e-mail",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.length == 0) {
                        return "L'identifiant est obligatoire";
                      }
                      return null;
                    },
                  ),
                  ButtonBar(
                    children: <Widget>[
                      ElevatedButton(
                        child: const Text("Suivant"),
                        onPressed: onLoginPressed,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
