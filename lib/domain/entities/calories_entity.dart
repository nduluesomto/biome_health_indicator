class CaloriesEntity {
  final double calories;
  final DateTime startTime;
  final DateTime endTime;

  const CaloriesEntity({
    required this.calories,
    required this.startTime,
    required this.endTime,
  });

  @override
  String toString() {
    return 'CaloriesEntity(calories: $calories, startTime: $startTime, endTime: $endTime)';
  }
}
