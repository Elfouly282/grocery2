
import 'package:grocery2/core/constants/api_constant.dart';
import 'package:grocery2/core/constants/dio_helper.dart';
import 'package:dio/dio.dart';
import '../../models/SubCategoriesResponse.dart';

class CategoryRepoImpl {


  Future<SubCategoriesResponse> getSubCategories() async {
    try {
      final response = await DioHelper.get(path: ApiConstant.categories);
      return SubCategoriesResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Network error');
    }
  }




}