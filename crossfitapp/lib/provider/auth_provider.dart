import 'dart:async';

import 'package:crossfitapp/model/user.dart';
import 'package:crossfitapp/provider/network.dart';
import 'package:dio/dio.dart';


class AuthApiProvider{

  Future<User> account() async {
    Response<User> response = await network.get("/api/account");
    return response.data;
  }

  Future<Response> login({String email, String password}) async {

    Response response = await network.post(
      "/api/token", 
      data: {
        "username": email,
        "password": password,
      }
    );

    return response;
  }

}