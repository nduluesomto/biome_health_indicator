import 'package:biome_activity_test/common/helper/health_handler.dart';
import 'package:biome_activity_test/data/%20models/calories_data_model.dart';
import 'package:biome_activity_test/data/%20models/step_data_model.dart';
import 'package:biome_activity_test/di.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

import 'health_datasource.dart';

class HealthDataSourceImpl extends HealthDataSource {
  @override
  Future<void> installHealthConnect() async {
    final healthConnect = await locator<Health>().installHealthConnect();
    return healthConnect;
  }

  @override
  Future<void> authorize() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();

    List<HealthDataType> types = [
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.DISTANCE_WALKING_RUNNING,
      HealthDataType.WALKING_HEART_RATE,
      HealthDataType.EXERCISE_TIME,
      HealthDataType.HEART_RATE,
    ];

    HealthPermissionHandler healthPermissionHandler =
        HealthPermissionHandler(types);

    bool? hasPermissions = await locator<Health>().hasPermissions(types,
        permissions: healthPermissionHandler.permissions);

    hasPermissions = false;

    if (!hasPermissions) {
      try {
        await locator<Health>().requestAuthorization(types,
            permissions: healthPermissionHandler.permissions);
      } catch (e) {
        debugPrint('Exception in authorize: $e');
      }
    }
  }

  @override
  Future<void> addStepData() async {
    final now = DateTime.now();
    final earlier = now.subtract(const Duration(minutes: 20));

    bool supported =
        await locator<Health>().isDataTypeAvailable(HealthDataType.STEPS);
    print("Step data type supported? $supported");

    bool stepsPermission =
        await locator<Health>().hasPermissions([HealthDataType.STEPS]) ?? false;

    if (!stepsPermission) {
      stepsPermission =
          await locator<Health>().requestAuthorization([HealthDataType.STEPS]);
    }

    print("Steps permission granted: $stepsPermission");

    if (stepsPermission) {
      try {
        bool success = await locator<Health>().writeHealthData(
          value: 90,
          type: HealthDataType.STEPS,
          startTime: earlier,
          endTime: now,
          recordingMethod: RecordingMethod.manual, // Try manual if this fails
        );

        if (success) {
          print('✅ Step data added successfully');
        } else {
          print('❌ Failed to add step data');
        }
      } catch (e, stackTrace) {
        print('⚠️ Error adding step data: $e');
        print('StackTrace: $stackTrace');
      }
    } else {
      print('🚫 Health permissions not granted.');
    }
  }

  @override
  Future<void> addCaloriesData() async {
    final now = DateTime.now();
    final earlier = now.subtract(const Duration(minutes: 20));

    bool success = await locator<Health>().writeHealthData(
        value: 200,
        type: HealthDataType.ACTIVE_ENERGY_BURNED,
        startTime: earlier,
        endTime: now);

    if (success) {
      print('Calories data added succesfully');
    } else {
      print('Failed to add calories data');
    }
  }

  @override
  Future<StepDataModel?> fetchStepData() async {
    StepDataModel? stepData;
    int steps = 0;
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool stepsPermission =
        await locator<Health>().hasPermissions([HealthDataType.STEPS]) ?? false;
    if (!stepsPermission) {
      stepsPermission =
          await locator<Health>().requestAuthorization([HealthDataType.STEPS]);
    }

    if (stepsPermission) {
      try {
        final stepsOne =
            await locator<Health>().getTotalStepsInInterval(midnight, now);
        if (stepsOne != null) {
          steps = stepsOne;
        }
      } catch (e) {
        debugPrint("Exception in getTotalStepsInterval: $e");
        steps = 0; // Set to 0 if there's an error fetching the data
      }
    } else {
      debugPrint("Permission denied for accessing steps data.");
    }

    stepData = StepDataModel(startTime: midnight, endTime: now, steps: steps);

    return stepData;
  }

  @override
  Future<CaloriesDataModel?> fetchCaloriesData() async {
    double calories = 0.0;
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool caloriesPermission = await locator<Health>()
            .hasPermissions([HealthDataType.ACTIVE_ENERGY_BURNED]) ??
        false;
    if (!caloriesPermission) {
      caloriesPermission = await locator<Health>()
          .requestAuthorization([HealthDataType.ACTIVE_ENERGY_BURNED]);
    }

    if (caloriesPermission) {
      try {
        final List<HealthDataPoint> caloriesData = await locator<Health>()
            .getHealthDataFromTypes(
                types: [HealthDataType.ACTIVE_ENERGY_BURNED],
                startTime: midnight,
                endTime: now);

        calories =
            caloriesData.fold(0.0, (sum, data) => sum + (data.value as double));
      } catch (e) {
        debugPrint("Exception in Calories: $e");
      }
    }
    return CaloriesDataModel(
        calories: calories, startTime: midnight, endTime: now);
  }

  @override
  Future isAuthorized() async {
    try {
      final request = await locator<Health>().requestAuthorization([
        HealthDataType.STEPS,
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataType.DISTANCE_WALKING_RUNNING,
      ]);
      return request;
    } catch (e) {
      return e.toString();
    }
  }
}
