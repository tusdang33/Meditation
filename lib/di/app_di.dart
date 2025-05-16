import 'package:mediation_app/data/services/token_service.dart';
import 'package:mediation_app/di/di_instance.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setupAppDI() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<TokenService>(() => TokenService());
}
