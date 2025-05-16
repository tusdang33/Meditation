import 'package:dio/dio.dart';
import 'package:mediation_app/data/services/login_service.dart';
import 'package:mediation_app/di/di_instance.dart';
import 'package:mediation_app/domain/models/user/user_model.dart';
import 'package:mediation_app/domain/repository/auth_repo.dart';
import 'package:mediation_app/domain/result_model.dart';
import 'package:mediation_app/data/services/token_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  final loginService = getIt<LoginService>();
  final tokenService = getIt<TokenService>();

  @override
  Future<Resource<UserModel>> signIn(String email, String password) async {
    try {
      final response = await loginService.login(email, password);

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data);
        await tokenService.saveToken(user.accessToken);
        return Success(user);
      } else {
        return Fail('Invalid credentials');
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return Fail('Invalid credentials');
      }
      return Fail('Network error occurred');
    } catch (e) {
      return Fail('An unexpected error occurred');
    }
  }

  @override
  Future<Resource<void>> signUp(
    String email,
    String password,
    String confirmPassword,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    return Success(null);
  }
}
