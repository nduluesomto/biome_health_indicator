import 'package:health/health.dart';

class HealthPermissionHandler {
  final List<HealthDataType> types;

  HealthPermissionHandler(this.types);

  List<HealthDataAccess> get permissions => types
      .map((type) => _readOnlyTypes.contains(type)
      ? HealthDataAccess.READ
      : HealthDataAccess.READ_WRITE)
      .toList();

  static final Set<HealthDataType> _readOnlyTypes = {
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.DISTANCE_WALKING_RUNNING,
    HealthDataType.WALKING_HEART_RATE,
    HealthDataType.ELECTROCARDIOGRAM,
    HealthDataType.HIGH_HEART_RATE_EVENT,
    HealthDataType.LOW_HEART_RATE_EVENT,
    HealthDataType.IRREGULAR_HEART_RATE_EVENT,
    HealthDataType.EXERCISE_TIME,
  };
}
