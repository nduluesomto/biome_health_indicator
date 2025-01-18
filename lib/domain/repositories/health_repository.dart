import 'package:biome_activity_test/domain/entities/calories_entity.dart';
import 'package:biome_activity_test/domain/entities/step_count_entity.dart';

abstract class HealthRepository {
  //Authorization
  Future<bool> authorization();

  //Get steps Data
  Future<StepCountEntity> getStepData(DateTime startDate, DateTime endDate);

  //Get Calories Burned
  Future<CaloriesEntity> getCaloriesData(DateTime startDate, DateTime endDate);
}
