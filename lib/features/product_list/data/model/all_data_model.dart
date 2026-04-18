import 'package:grocery2/features/product_list/data/model/pagination_model.dart';
import 'package:grocery2/features/product_list/data/model/subcategories_model.dart';
import 'meals_model.dart';

class DataModel {
  final SubCategoriesModel? subcategory;
  final List<MealsModel> meals;
  final Pagination? pagination;

  DataModel({
    this.subcategory,
    required this.meals,
    this.pagination,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    var data = json['data'];
    if (data == null) {
       return DataModel(meals: []);
    }

    return DataModel(
      subcategory: data['subcategory'] != null 
          ? SubCategoriesModel.fromJson(data['subcategory']) 
          : null,
      meals: data['meals'] != null
          ? List<MealsModel>.from(
              (data['meals'] as List).map((e) => MealsModel.fromJson(e)))
          : [],
      pagination: data['pagination'] != null 
          ? Pagination.fromJson(data['pagination']) 
          : null,
    );
  }
}
