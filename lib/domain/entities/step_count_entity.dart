class StepCountEntity {
  final DateTime startTime;
  final DateTime endTime;
  final int steps;

  const StepCountEntity({
    required this.steps,
    required this.startTime,
    required this.endTime,
  });

  @override
  String toString() {
    return 'StepCountEntity(steps: $steps, startTime: $startTime, endTime: $endTime)';
  }
}
