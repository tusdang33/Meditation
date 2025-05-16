import 'package:dio/dio.dart';
import 'package:mediation_app/di/di_instance.dart';

class LoginService {
  final Dio _dioClient = getIt<Dio>();

  Future<Response> login(String email, String password) async {
    return await _dioClient.post(
      '/auth/login',
      data: {
        'username': 'emilys',
        'password': 'emilyspass',
        'expiresInMins': 30,
      },
      options: Options(
        validateStatus: (status) => status! < 500,
        sendTimeout: 60000,
      ),
    );
  }
}
