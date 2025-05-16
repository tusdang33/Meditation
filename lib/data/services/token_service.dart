import 'package:mediation_app/di/di_instance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const String _tokenKey = 'auth_token';
  final SharedPreferences _prefs = getIt<SharedPreferences>();

  TokenService();

  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    await _prefs.remove(_tokenKey);
  }

  bool hasToken() {
    return getToken() != null;
  }
}
