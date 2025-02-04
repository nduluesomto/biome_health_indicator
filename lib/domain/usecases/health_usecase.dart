import 'package:biome_activity_test/di.dart';
import 'package:biome_activity_test/domain/entities/calories_entity.dart';
import 'package:biome_activity_test/domain/entities/step_count_entity.dart';
import 'package:biome_activity_test/domain/repositories/health_repository.dart';

class FetchStepData {
  Future<void> installHealthConnect() async {
    return await locator<HealthRepository>().installHealthConnect();
  }

  Future<void> authorize() async {
    return await locator<HealthRepository>().authorize();
  }

  Future<void> addStepData() async {
    return await locator<HealthRepository>().addStepData();
  }

  Future<void> addCaloriesData() async {
    return await locator<HealthRepository>().addCaloriesData();
  }

  Future<StepCountEntity> fetchStepData() async {
    return await locator<HealthRepository>().fetchStepData();
  }

  Future<CaloriesEntity> fetchCaloriesData() async {
    return await locator<HealthRepository>().fetchCaloriesData();
  }
}
