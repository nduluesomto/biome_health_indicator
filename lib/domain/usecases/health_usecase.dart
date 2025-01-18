import 'package:biome_activity_test/domain/entities/calories_entity.dart';
import 'package:biome_activity_test/domain/entities/step_count_entity.dart';
import 'package:biome_activity_test/domain/repositories/health_repository.dart';

class FetchStepData {
  final HealthRepository repository;

  FetchStepData(this.repository);

  Future<bool> authorization(){
    return repository.authorization();
  }

  Future<StepCountEntity> steps(DateTime startTime, DateTime endTime) {
    return repository.getStepData(startTime, endTime);
  }

  Future<CaloriesEntity> calories(DateTime startTime, DateTime endTime){
    return repository.getCaloriesData(startTime, endTime);
  }
}