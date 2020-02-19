import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
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
                Icon(Icons.trending_up),
                SizedBox(height: 45.0),
                TextField(),
                SizedBox(height: 25.0),
                TextField(obscureText: true,),
                SizedBox(
                  height: 35.0,
                ),
                ButtonBarTheme( // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text("RESERVER"),
                        onPressed: () { /* ... */ },
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
