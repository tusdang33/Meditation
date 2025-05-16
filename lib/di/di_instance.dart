import 'package:get_it/get_it.dart';
import 'package:mediation_app/di/app_di.dart';
import 'package:mediation_app/di/network_di.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  await setupAppDI();
  setupNetworkDI();
}
