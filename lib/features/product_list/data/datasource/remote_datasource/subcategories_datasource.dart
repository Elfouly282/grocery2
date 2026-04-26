import 'package:flutter/material.dart';
import 'package:grocery2/core/constants/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:grocery2/features/product_list/data/model/all_data_model.dart';
import 'package:grocery2/features/product_list/data/model/subcategories_model.dart';
import 'package:grocery2/core/constants/api_constant.dart';

abstract class BaseSubCategoriesDatasource {
  Future<List<SubCategoriesModel>?> getSubCategories();

  Future<DataModel> getMeals({required int id, int page = 1});
}

class SubCategoriesDatasource extends BaseSubCategoriesDatasource {
  final dio = DioHelper.dio;

  @override
  Future<List<SubCategoriesModel>> getSubCategories() async {
    try {
      final response = await dio.get(ApiConstant.subcategories);
      return List<SubCategoriesModel>.from(
        (response.data["data"] as List).map(
          (e) => SubCategoriesModel.fromJson(e),
        ),
      );
    } on DioException catch (e) {
      _handleDioException(e);
      rethrow;
    } catch (e) {
      throw Exception("Failed to load data");
    }
  }

  @override
  Future<DataModel> getMeals({required int id, int page = 1}) async {
    try {
      final response = await dio.get("${ApiConstant.meals(id)}?page=$page");
      print(response.data);
      return DataModel.fromJson(response.data);
    } on DioException catch (e) {
      _handleDioException(e);
      rethrow;
    } catch (e, stackTrace) {
      debugPrint('❌ PARSE ERROR: $e');
      debugPrint('📍 STACK: $stackTrace'); // tells you exact line
      rethrow;
    }
  }
}

void _handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw Exception('Connection timeout - Please check your internet');
    case DioExceptionType.sendTimeout:
      throw Exception('Send timeout - Please try again');
    case DioExceptionType.receiveTimeout:
      throw Exception('Receive timeout - Server took too long to respond');
    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final message = e.response?.data?['message'] ?? 'Failed to load news';
      throw Exception('Server error ($statusCode): $message');
    case DioExceptionType.cancel:
      throw Exception('Request was cancelled');
    case DioExceptionType.connectionError:
      throw Exception('No internet connection');
    default:
      throw Exception('Failed to load data');
  }
}
