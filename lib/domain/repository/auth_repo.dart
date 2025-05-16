import 'package:mediation_app/domain/models/user/user_model.dart';
import 'package:mediation_app/domain/result_model.dart';

abstract class AuthRepository {
  Future<Resource<UserModel>> signIn(String email, String password);
  Future<Resource<void>> signUp(String email, String password, String confirmPassword);
}

