import 'CategoryModel.dart';

class CategoriesResponse {
  final bool success;
  final String message;
  final List<CategoryModel> data;

  CategoriesResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}