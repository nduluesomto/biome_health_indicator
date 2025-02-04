import 'package:biome_activity_test/data/%20models/calories_data_model.dart';
import 'package:biome_activity_test/data/%20models/step_data_model.dart';

abstract class HealthDataSource {
  Future<void> installHealthConnect();

  Future<void> authorize();

  Future<void> addStepData();

  Future<void> addCaloriesData();

  Future<StepDataModel?> fetchStepData();

  Future<CaloriesDataModel?> fetchCaloriesData();

  Future isAuthorized();
}
