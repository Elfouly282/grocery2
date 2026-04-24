import 'package:grocery2/core/constants/api_constant.dart';
import 'package:grocery2/core/constants/dio_helper.dart';
import 'package:dio/dio.dart';
import '../../models/CategoriesResponse.dart';
import '../../models/categories_meals/category_meals_response.dart';

class CategoryRepoImpl {
  Future<CategoriesResponse> getSubCategories() async {
    try {
      final response = await DioHelper.get(path: ApiConstant.category);
      return CategoriesResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Network error');
    }
  }

  Future<DetailsMealsResponse> getDetailsSubCategories(int id) async {
    try {
      final response = await DioHelper.get(
        path: ApiConstant.detailsOfSubcategories(id),
      );

      return DetailsMealsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Network error');
    }
  }
}
