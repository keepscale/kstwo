
import 'package:dio/dio.dart';

class NetworkProvider {

  static BaseOptions options = new BaseOptions(
      baseUrl: "https://booking.crossfit-nancy.fr/",
      connectTimeout: 5000,
      receiveTimeout: 3000,
  );
  
  Dio _dio;
  NetworkProvider(){
    _dio = new Dio(NetworkProvider.options);
    _dio.interceptors.add(LogInterceptor());
  }

  Future<Response<T>> get<T>(String path, {Map<String, dynamic> queryParameters}){
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response<T>> post<T>(String path, {data, Map<String, dynamic> queryParameters}){
    return _dio.post(path, data: data, queryParameters: queryParameters);
  }

}
  
final NetworkProvider network = new NetworkProvider();