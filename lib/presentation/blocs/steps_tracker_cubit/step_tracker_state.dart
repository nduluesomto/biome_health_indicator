part of 'step_tracker_cubit.dart';

sealed class StepTrackerState extends Equatable {
  const StepTrackerState();
}

final class StepTrackerInitial extends StepTrackerState {
  @override
  List<Object> get props => [];
}

class StepTrackerLoading extends StepTrackerState {
  @override
  List<Object?> get props => [];
}

class StepTrackerLoaded extends StepTrackerState {
  final List<StepCountEntity> steps;
  final List<CaloriesEntity> calories;

  final double distance;

  @override
  List<Object?> get props => [steps, calories, distance];

  const StepTrackerLoaded({
    required this.steps,
    required this.calories,
    required this.distance,
  });
}

class StepTrackerError extends StepTrackerState {
  final String message;

  const StepTrackerError(this.message);

  @override
  List<Object?> get props => [message];
}
