import 'dart:async';

import 'package:keepwod/model/user.dart';
import 'package:keepwod/service/network_client.dart';
import 'package:dio/dio.dart';


class AuthService{
  final NetworkClient _network;
  AuthService(this._network);

  Future<User> account() async {
    Response<Map> response = await _network.get("/api/account");
    return response.statusCode == 200 ? User.fromJson(response.data) : Future.value(null);
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