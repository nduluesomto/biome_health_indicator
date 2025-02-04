import 'package:biome_activity_test/data/datasources/health_datasource.dart';
import 'package:biome_activity_test/data/repositories/health_repo_impl.dart';
import 'package:biome_activity_test/domain/usecases/health_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:health/health.dart';

import 'data/datasources/health_datasoure_impl.dart';
import 'domain/repositories/health_repository.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  //Health Datasource
  locator.registerSingleton<Health>(Health());

  //Services
  locator.registerSingleton<HealthDataSource>(HealthDataSourceImpl());

  //Repositories
  locator.registerSingleton<HealthRepository>(HealthRepositoryImpl());

  //Usecases
  locator.registerSingleton<FetchStepData>(FetchStepData());
}
