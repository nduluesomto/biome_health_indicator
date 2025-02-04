import 'package:biome_activity_test/domain/entities/calories_entity.dart';
import 'package:biome_activity_test/domain/entities/step_count_entity.dart';

abstract class HealthRepository {
  Future<void> installHealthConnect();

  Future<void> authorize();

  Future<void> addStepData();

  Future<void> addCaloriesData();

  Future<StepCountEntity> fetchStepData();

  Future<CaloriesEntity> fetchCaloriesData();
}
