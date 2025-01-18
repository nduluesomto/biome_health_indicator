import 'package:biome_activity_test/data/%20models/calories_data_model.dart';
import 'package:biome_activity_test/data/datasources/health_datasource.dart';
import 'package:biome_activity_test/domain/entities/calories_entity.dart';
import 'package:biome_activity_test/domain/entities/step_count_entity.dart';
import 'package:biome_activity_test/domain/repositories/health_repository.dart';

class HealthRepositoryImpl implements HealthRepository {
  final HealthDataSource dataSource;

  HealthRepositoryImpl(this.dataSource);

  @override
  Future<StepCountEntity> getStepData(
      DateTime startDate, DateTime endDate) async {
    final stepDataModels = await dataSource.fetchStep(startDate, endDate);

    //final steps = stepDataModels.map((e) => e.steps).toList();
    return StepCountEntity(steps: stepDataModels);
  }

  @override
  Future<CaloriesEntity> getCaloriesData(
      DateTime startDate, DateTime endDate) async {
    final calories = await dataSource.fetchCalories(startDate, endDate);

    List<CaloriesDataModel> caloriesList = [
      CaloriesDataModel(calories: calories)
    ];
    return CaloriesEntity(calories: caloriesList);
  }

  @override
  Future<bool> authorization() async {
    final authorized = await dataSource.isAuthorized();

    return authorized;
  }
}
