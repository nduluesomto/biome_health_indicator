import 'package:biome_activity_test/di.dart';
import 'package:biome_activity_test/domain/entities/calories_entity.dart';
import 'package:biome_activity_test/domain/entities/step_count_entity.dart';
import 'package:biome_activity_test/domain/usecases/health_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'step_tracker_state.dart';

class StepTrackerCubit extends Cubit<StepTrackerState> {
  StepTrackerCubit() : super(StepTrackerInitial());

  Future<void> loadHealthData() async {
    emit(StepTrackerLoading());

    try {
      await locator<FetchStepData>().installHealthConnect();
      await locator<FetchStepData>().authorize();

      await locator<FetchStepData>().addStepData();
      await locator<FetchStepData>().addCaloriesData();

      final stepData = await locator<FetchStepData>().fetchStepData();
      print(stepData);
      final caloriesData = await locator<FetchStepData>().fetchCaloriesData();

      emit(StepTrackerLoaded(
        steps: [stepData],
        calories: [caloriesData],
        distance: stepData.steps * 0.000762,
      ));
    } catch (e, stacktrace) {
      print('Error: $e');
      print('Stacktrace: $stacktrace');
      emit(const StepTrackerError(
          'Не удалось загрузить данные о состоянии здоровья'));
    }
  }
}
