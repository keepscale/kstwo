import 'dart:async';

import 'package:keepwod/model/box.dart';
import 'package:keepwod/service/network_client.dart';
import 'package:dio/dio.dart';

class BoxService {
  final NetworkClient _network;
  BoxService(this._network);

  Future<Box> get() async {
    Response<Map> response = await _network.get("/api/boxs/current");
    return response.statusCode == 200
        ? Box.fromJson(response.data)
        : Future.value(null);
  }
}
