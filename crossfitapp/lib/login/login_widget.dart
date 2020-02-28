import 'package:crossfitapp/services/auth.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  
  LoginWidget({Key key, this.onLoginSucess}) : super(key: key);

  final Function() onLoginSucess;

  @override
  _LoginWidgetState createState() => _LoginWidgetState();

}

class _LoginWidgetState extends State<LoginWidget> {

  final emailController = TextEditingController(text: "loic.gangloff@gmail.com");
  final passwordController = TextEditingController();
  

  void onLoginPressed(){
    AuthService.doLogin(emailController.text, passwordController.text).then((bool loggedIn){
      if (!loggedIn){
        print("Bad login or password");
      }
      else{
        widget.onLoginSucess();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.account_box),
                SizedBox(height: 45.0),
                TextField(controller: emailController,),
                SizedBox(height: 25.0),
                TextField(obscureText: true, controller: passwordController,),
                SizedBox(
                  height: 35.0,
                ),
                ButtonBarTheme( // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text("Se connecter"),
                        onPressed: onLoginPressed,
                      )
                    ],
                  ), data: ButtonBarThemeData(),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
