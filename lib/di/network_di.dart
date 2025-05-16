import 'package:dio/dio.dart';
import 'package:mediation_app/data/repository/auth_repo_impl.dart';
import 'package:mediation_app/data/repository/topic_repo_impl.dart';
import 'package:mediation_app/data/services/login_service.dart';
import 'package:mediation_app/di/di_instance.dart';
import 'package:mediation_app/domain/repository/auth_repo.dart';
import 'package:mediation_app/domain/repository/topic_repository.dart';
import 'package:mediation_app/network/dio_client.dart';

void setupNetworkDI() {
  getIt.registerLazySingleton<Dio>(() => DioClient().dio);
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<LoginService>(() => LoginService());
  getIt.registerLazySingleton<TopicRepository>(() => TopicRepositoryImpl());
}
