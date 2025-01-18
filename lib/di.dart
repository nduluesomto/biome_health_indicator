import 'package:biome_activity_test/data/datasources/health_datasource.dart';
import 'package:biome_activity_test/data/repositories/health_repo_impl.dart';
import 'package:biome_activity_test/domain/usecases/health_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:health/health.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => HealthDataSource(Health()));
  locator.registerLazySingleton(
      () => HealthRepositoryImpl(locator<HealthDataSource>()));
  locator.registerLazySingleton(
      () => FetchStepData(locator<HealthRepositoryImpl>()));
}
