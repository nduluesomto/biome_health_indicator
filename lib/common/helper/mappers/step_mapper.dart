import 'package:biome_activity_test/data/%20models/step_data_model.dart';
import 'package:biome_activity_test/domain/entities/step_count_entity.dart';

class StepMapper {
  static StepCountEntity toEntity(StepDataModel stepDataModel) {
    return StepCountEntity(
        steps: stepDataModel.steps,
        startTime: stepDataModel.startTime,
        endTime: stepDataModel.endTime);
  }
}
