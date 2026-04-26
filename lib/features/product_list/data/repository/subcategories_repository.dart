import 'package:grocery2/features/product_list/data/datasource/remote_datasource/subcategories_datasource.dart';
import 'package:grocery2/features/product_list/data/model/all_data_model.dart';
import 'package:grocery2/features/product_list/data/model/subcategories_model.dart';

abstract class BaseSubcategoriesRepository {
  Future<List<SubCategoriesModel>?> getSubCategories();

  Future<DataModel> getMeals({required int id, int page = 1});
}

class SubcategoriesRepository extends BaseSubcategoriesRepository {
  final BaseSubCategoriesDatasource subcategoriesApiServices;

  SubcategoriesRepository(this.subcategoriesApiServices);

  @override
  Future<List<SubCategoriesModel>?> getSubCategories() async {
    final response = await subcategoriesApiServices.getSubCategories();
    try {
      return response;
    } catch (e) {
      throw Exception("Failed to load data");
    }
  }

  @override
  Future<DataModel> getMeals({required int id, int page = 1}) {
    final response = subcategoriesApiServices.getMeals(id: id, page: page);
    try {
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
