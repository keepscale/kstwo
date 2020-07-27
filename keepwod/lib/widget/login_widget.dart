
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

  void onLoginPressed(){
    
    if (_formKey.currentState.validate()){
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
                  SizedBox(height: 45.0),
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Identifiant",
                    ),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.length==0) {
                        return "L'identifiant est obligatoire";
                      }
                      return null;
                    },
                  ),

                  TextFormField(
                    autofocus: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Mot de passe",
                    ),
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.length==0) {
                        return "Mot de passe obligatoire";
                      }
                      return null;
                    },
                  ),
                  ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        child: const Text("Se connecter"),
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
