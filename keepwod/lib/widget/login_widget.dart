import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:keepwod/main.dart';
import 'package:keepwod/store/app_store.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget(this.appStore, {Key key}) : super(key: key);

  final AppStore appStore;

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool loginPending = false;
  String email = "";
  String errorMessage = "";
  final storage = new FlutterSecureStorage();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    storage.read(key: "username").then((value) {
      setState(() {
        this.email = value;
        this.email ??= "";
        this.emailController.text = email;
      });
    });
  }

  void clearEmail() {
    setState(() {
      this.email = "";
    });
  }

  void onNextPressed() {
    if (email.isEmpty && _formKey.currentState.validate()) {
      setState(() {
        this.email = emailController.value.text.trim();
        storage.write(key: "username", value: this.email);
      });
    } else if (email.isNotEmpty && _formKey.currentState.validate()) {
      setState(() {
        this.loginPending = true;
        this.errorMessage = "";
      });
      this
          .widget
          .appStore
          .login(email, passwordController.text)
          .then((loggedIn) => setState(() {
                this.loginPending = false;
                if (!loggedIn) {
                  this.errorMessage =
                      "Mauvais e-mail ou mot de passe incorrect";
                }
              }));
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
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: ListView(
                children: <Widget>[
                  Image.network(
                    "https://www.crossfit-nancy.fr/img/logo_web.png",
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Connexion",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Visibility(
                    visible: email.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              email,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                        onPressed: clearEmail,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: email.isEmpty,
                    child: TextFormField(
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
                          return "L'e-mail est obligatoire'";
                        } else {
                          if (!value.contains("@")) {
                            return "Veuillez saisir un e-mail valide";
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  Visibility(
                    visible: email.isNotEmpty &&
                        !loginPending &&
                        !widget.appStore.loggedIn,
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Saisissez votre mot de passe',
                        labelText: "Mot de passe",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.length == 0) {
                          return "Le mot de passe est obligatoire";
                        }
                        return null;
                      },
                    ),
                  ),
                  Visibility(
                    visible: !loginPending && !widget.appStore.loggedIn,
                    child: ButtonBar(
                      children: <Widget>[
                        ElevatedButton(
                          child: Row(
                            children: [
                              Text("Suivant"),
                            ],
                          ),
                          onPressed: onNextPressed,
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: loginPending || widget.appStore.userLoadPending,
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                  Center(
                      child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
