import 'package:dio/dio.dart';
import '../../../../core/constants/api_constant.dart';
import '../../../../core/constants/dio_helper.dart';
import '../models/smart_list_model.dart';

abstract class SmartListRemoteDataSource {
  Future<List<SmartListModel>> getSmartLists();
  Future<SmartListModel> getSmartListDetails(int id);
  Future<void> createSmartList({
    required String name,
    required String description,
    MultipartFile? image,
    required List<int> mealIds,
  });
  Future<void> updateSmartList({
    required int id,
    String? name,
    String? description,
    MultipartFile? image,
    List<int>? mealIds,
  });
  Future<void> deleteSmartList(int id);
}

class SmartListRemoteDataSourceImpl implements SmartListRemoteDataSource {
  @override
  Future<List<SmartListModel>> getSmartLists() async {
    final response = await DioHelper.get(
      path: ApiConstant.getSmartLists,
      withAuth: true,
    );
    
    return (response.data['data'] as List)
        .map((e) => SmartListModel.fromJson(e))
        .toList();
  }

  @override
  Future<SmartListModel> getSmartListDetails(int id) async {
    final response = await DioHelper.get(
      path: ApiConstant.smartList.replaceFirst(':id', id.toString()),
      withAuth: true,
    );
    
    return SmartListModel.fromJson(response.data['data']);
  }

  @override
  Future<void> createSmartList({
    required String name,
    required String description,
    MultipartFile? image,
    required List<int> mealIds,
  }) async {
    final Map<String, dynamic> data = {
      "name": name,
      "description": description,
    };
    
    if (image != null) {
      data["image"] = image;
    }
    
    for (int i = 0; i < mealIds.length; i++) {
      data["meal_ids[$i]"] = mealIds[i];
    }

    await DioHelper.postFormData(
      path: ApiConstant.smartLists,
      formData: FormData.fromMap(data),
      withAuth: true,
    );
  }

  @override
  Future<void> updateSmartList({
    required int id,
    String? name,
    String? description,
    MultipartFile? image,
    List<int>? mealIds,
  }) async {
    final Map<String, dynamic> data = {
      "_method": "PUT", // Often required for multipart PUT in Laravel
    };
    
    if (name != null) data["name"] = name;
    if (description != null) data["description"] = description;
    if (image != null) data["image"] = image;
    
    if (mealIds != null) {
      for (int i = 0; i < mealIds.length; i++) {
        data["meal_ids[$i]"] = mealIds[i];
      }
    }

    await DioHelper.postFormData(
      path: ApiConstant.smartList.replaceFirst(':id', id.toString()),
      formData: FormData.fromMap(data),
      withAuth: true,
    );
  }

  @override
  Future<void> deleteSmartList(int id) async {
    await DioHelper.delete(
      path: ApiConstant.smartList.replaceFirst(':id', id.toString()),
      withAuth: true,
    );
  }
}
