import 'package:biome_activity_test/domain/usecases/health_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'step_tracker_state.dart';

class StepTrackerCubit extends Cubit<StepTrackerState> {
  final FetchStepData _fetchStepData;

  StepTrackerCubit(this._fetchStepData) : super(StepTrackerInitial());

  Future<void> loadHealthData() async {
    emit(StepTrackerLoading());

    try {
      bool isAuthorized = await _fetchStepData.authorization();
      if (!isAuthorized) {
        emit(const StepTrackerError('Разрешения не предоставлены'));
      }

      DateTime startDate = DateTime.now().subtract(const Duration(days: 1));
      DateTime endDate = DateTime.now();

      final stepData = await _fetchStepData.steps(startDate, endDate);
      final caloriesData = await _fetchStepData.calories(startDate, endDate);

      emit(
        StepTrackerLoaded(
            steps: stepData.steps
                .fold(0, (sum, stepModel) => sum + stepModel.steps),
            calories: caloriesData.calories
                .fold(0.0, (sum, data) => sum + (data.calories)),
            distance: stepData.steps.fold(
                0.0, (sum, stepModel) => sum + stepModel.steps * 0.000762)),
      );
    } catch (e) {
      emit(const StepTrackerError('Не удалось загрузить данные о состоянии здоровья'));
    }
  }
}
