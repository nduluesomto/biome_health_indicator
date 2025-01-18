class CaloriesDataModel {
  final double calories;

  CaloriesDataModel({required this.calories});

  factory CaloriesDataModel.fromJson(Map<String, dynamic> json) {
    return CaloriesDataModel(calories: json['calories'] as double);
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
    };
  }
}
