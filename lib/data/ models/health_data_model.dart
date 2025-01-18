class HealthDataModel {
  final int steps;
  final double calories;

  HealthDataModel({required this.steps, required this.calories});

  factory HealthDataModel.fromJson(Map<String, dynamic> json) {
    return HealthDataModel(
      steps: json['steps'] as int,
      calories: json['calories'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'steps': steps,
      'calories': calories,
    };
  }
}