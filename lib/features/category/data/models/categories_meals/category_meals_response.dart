import 'category_meals_model.dart';

class DetailsMealsResponse {
  final bool success;
  final String message;
  final DetailsMealsData data;

  DetailsMealsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DetailsMealsResponse.fromJson(Map<String, dynamic> json) {
    return DetailsMealsResponse(
      success: json['success'],
      message: json['message'],
      data: DetailsMealsData.fromJson(json['data']),
    );
  }
}

class DetailsMealsData {
  final Category category;
  final List<Meal> meals;

  DetailsMealsData({required this.category, required this.meals});

  factory DetailsMealsData.fromJson(Map<String, dynamic> json) {
    return DetailsMealsData(
      category: Category.fromJson(json['category']),
      meals: (json['meals'] as List).map((e) => Meal.fromJson(e)).toList(),
    );
  }
}
