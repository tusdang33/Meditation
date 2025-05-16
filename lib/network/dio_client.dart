import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: 'https://dummyjson.com',
          connectTimeout: 10000,
          receiveTimeout: 10000,
          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
}
