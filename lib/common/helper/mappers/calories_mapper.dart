import 'package:biome_activity_test/data/%20models/calories_data_model.dart';
import 'package:biome_activity_test/domain/entities/calories_entity.dart';

class CaloriesMapper {
  static CaloriesEntity toEntity(CaloriesDataModel caloriesDataModel) {
    return CaloriesEntity(
      calories: caloriesDataModel.calories,
      startTime: caloriesDataModel.startTime,
      endTime: caloriesDataModel.endTime,
    );
  }
}
