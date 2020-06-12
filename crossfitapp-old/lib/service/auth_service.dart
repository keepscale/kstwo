import 'dart:async';

import 'package:crossfitapp/model/user.dart';
import 'package:crossfitapp/service/network_client.dart';
import 'package:dio/dio.dart';


class AuthService{
  final NetworkClient _network;
  AuthService(this._network);

  Future<User> account() async {
    Response<Map> response = await _network.get("/api/account");
    return User.fromJson(response.data);
  }

  Future<Response> login({String email, String password}) async {

    Response response = await _network.post(
      "/api/token", 
      queryParameters: {
        "username": email,
        "password": password,
      }
    );

    return response;
  }

  Future<void> logout() {
    return _network.logout();
  }

}