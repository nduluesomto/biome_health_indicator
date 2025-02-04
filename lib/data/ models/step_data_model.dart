class StepDataModel {
  final DateTime startTime;
  final DateTime endTime;
  final int steps;

  StepDataModel({
    required this.startTime,
    required this.endTime,
    required this.steps,
  });

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'steps': steps,
    };
  }

  factory StepDataModel.fromJson(Map<String, dynamic> json) {
    return StepDataModel(
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      steps: json['steps'] as int,
    );
  }
}
