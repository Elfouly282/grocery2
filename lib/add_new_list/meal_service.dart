import 'package:dio/dio.dart'; // Ensure this import is added
import 'package:grocery2/core/constants/dio_helper.dart';
import 'package:grocery2/models/meal.dart';

class MealService {
  Future<List<Meal>> fetchMeals() async {
    try {
      final response = await DioHelper.get(
        path: "/api/meals/recommendations",
        withAuth: false,
      );
      final List data = response.data['data'];
      return data.map((json) => Meal.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  /// Search meals (API-based)
  Future<List<Meal>> searchMeals(String query) async {
    try {
      final response = await DioHelper.get(
        path: "/api/meals/recommendations",
        query: {"q": query},
        withAuth: false,
      );

      final List data = response.data;

      return data.map((json) => Meal.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  /// 🧠 Error Handling (clean & reusable)
  String _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout";
      case DioExceptionType.receiveTimeout:
        return "Server took too long to respond";
      case DioExceptionType.badResponse:
        return "Server error: ${e.response?.statusCode}";
      case DioExceptionType.cancel:
        return "Request was cancelled";
      default:
        return "Unexpected error occurred";
    }
  }
}
