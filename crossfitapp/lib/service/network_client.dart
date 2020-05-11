
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NetworkClient {

  static BaseOptions options = new BaseOptions(
      baseUrl: "https://booking.crossfit-nancy.fr/",
      //baseUrl: "http://10.0.2.2:8080/",
      connectTimeout: 5000,
      receiveTimeout: 3000,
  );
  
  Dio _dio;
  TokenInterceptor tokenInterceptor = new TokenInterceptor();

  NetworkClient(){
    _dio = new Dio(NetworkClient.options);
    _dio.interceptors.add(tokenInterceptor);
    _dio.interceptors.add(LogInterceptor(request: false, requestHeader: false, requestBody: true, responseBody: true, responseHeader: false));
  }

  Future<Response<T>> get<T>(String path, {Map<String, dynamic> queryParameters}){
    return new Future.delayed(const Duration(seconds: 0), () => 
    _dio.get(path, queryParameters: queryParameters));
  }

  Future<Response<T>> post<T>(String path, {data, Map<String, dynamic> queryParameters}){
    return _dio.post(path, data: data, queryParameters: queryParameters);
  }
  Future<Response<T>> delete<T>(String path){
    return _dio.delete(path);
  }

  Future<void> logout() {
    return this.tokenInterceptor.clearToken();
  }

}

class TokenInterceptor extends Interceptor{
  String _token;
  final storage = new FlutterSecureStorage();

  @override
  Future onRequest(RequestOptions options) async {
    if (_token == null){
      _token = await storage.read(key: "jwt_token");
    }

    if (_token != null)
      options.headers["Authorization"] = "Bearer $_token";
    return options;
  }

  @override
  Future onResponse(Response response) async {
    if(response.headers["jwt_token"] != null){
      _token = response.headers["jwt_token"][0];
      await storage.write(key: "jwt_token", value: _token);
    }
    return super.onResponse(response);
  }

  Future<void> clearToken(){
    this._token = null;
    return storage.delete(key: "jwt_token");
  }
}