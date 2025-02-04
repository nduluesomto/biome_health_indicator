import 'package:biome_activity_test/common/helper/mappers/calories_mapper.dart';
import 'package:biome_activity_test/common/helper/mappers/step_mapper.dart';
import 'package:biome_activity_test/data/datasources/health_datasource.dart';
import 'package:biome_activity_test/di.dart';
import 'package:biome_activity_test/domain/entities/calories_entity.dart';
import 'package:biome_activity_test/domain/entities/step_count_entity.dart';
import 'package:biome_activity_test/domain/repositories/health_repository.dart';
import 'package:flutter/material.dart';

class HealthRepositoryImpl extends HealthRepository {
  @override
  Future<void> authorize() async {
    return await locator<HealthDataSource>().authorize();
  }

  @override
  Future<void> installHealthConnect() async {
    return await locator<HealthDataSource>().installHealthConnect();
  }

  @override
  Future<void> addCaloriesData() async {
    return await locator<HealthDataSource>().addCaloriesData();
  }

  @override
  Future<void> addStepData() async {
    return await locator<HealthDataSource>().addStepData();
  }

  @override
  Future<CaloriesEntity> fetchCaloriesData() async {
    try {
      final caloriesData =
          await locator<HealthDataSource>().fetchCaloriesData();
      if (caloriesData == null) {
        throw Exception('No Calories Data available');
      }
      final data = CaloriesMapper.toEntity(caloriesData);

      return data;
    } catch (e) {
      print('Error in getCaloriesData: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<StepCountEntity> fetchStepData() async {
    try {
      final stepData = await locator<HealthDataSource>().fetchStepData();
      if (stepData == null) {
        throw Exception('No step Data available');
      }
      final data = StepMapper.toEntity(stepData);
      return data;
    } catch (e) {
      debugPrint("Exception at $e");
      rethrow;
    }
  }
}
