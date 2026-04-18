import 'SubCategoryModel.dart';

class SubCategoriesResponse {
  final bool success;
  final String message;
  final List<SubCategoryModel> data;

  SubCategoriesResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SubCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return SubCategoriesResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SubCategoryModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}