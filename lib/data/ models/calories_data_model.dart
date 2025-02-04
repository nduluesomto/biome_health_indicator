class CaloriesDataModel {
  final double calories;
  final DateTime startTime;
  final DateTime endTime;

  CaloriesDataModel({required this.calories, required this.startTime, required this.endTime});

  factory CaloriesDataModel.fromJson(Map<String, dynamic> json) {
    return CaloriesDataModel(calories: json['calories'] as double, startTime: json['startTime'], endTime: json['endTime']);
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'startTime': startTime,
      'endTime' : endTime,
    };
  }
}
