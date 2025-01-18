import 'package:biome_activity_test/data/%20models/step_data_model.dart';
import 'package:health/health.dart';

class HealthDataSource {
  final Health _health;

  HealthDataSource(this._health);

  Future<bool> isAuthorized() async {
    await _health.requestAuthorization([
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.DISTANCE_WALKING_RUNNING,
    ]);
    return true;
  }

  Future<List<StepDataModel>> fetchStep(
      DateTime startTime, DateTime endTime) async {
    final stepsData = await _health.getHealthDataFromTypes(
      types: [HealthDataType.STEPS],
      startTime: startTime,
      endTime: endTime,
    );

    return stepsData.map((data) {
      return StepDataModel(
          startTime: data.dateFrom,
          endTime: data.dateTo,
          steps: data.value as int);
    }).toList();
  }

  Future<double> fetchCalories(DateTime startDate, DateTime endDate) async {
    final caloriesData = await _health.getHealthDataFromTypes(
      types: [HealthDataType.ACTIVE_ENERGY_BURNED],
      startTime: startDate,
      endTime: endDate,
    );

    double totalCalories =
        caloriesData.fold(0.0, (sum, data) => sum + (data.value as double));
    return totalCalories;
  }
}
