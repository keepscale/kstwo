import 'dart:async';
import 'dart:convert';

import 'package:crossfitapp/model/user.dart';
import 'package:crossfitapp/services/network.dart';
import 'package:http/http.dart' as http;


class AuthService{

  static Future<User> account() async {

    final response = await NetworkService.get("/api/account");


    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } 
    else if (response.statusCode == 401) {
      return null;
    }
    else {
      throw Exception('Failed to load post');
    }
  }

  static Future<bool> doLogin(String email, String password) async {

    return await NetworkService.postFormData(
      "/api/authentication", 
      body: {
        "j_username": email,
        "j_password": password,
        "remember-me": "true",
        "submit": "Login"
      }
    ).then((http.Response response) {
      return response.statusCode == 200;
    });

  }

}