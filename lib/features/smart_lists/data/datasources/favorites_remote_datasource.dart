import '../../../../core/constants/api_constant.dart';
import '../../../../core/constants/dio_helper.dart';
import '../../../product_details/data/models/product_model.dart';

abstract class FavoritesRemoteDataSource {
  Future<List<ProductModel>> getFavorites();
  Future<bool> toggleFavorite(int productId);
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  @override
  Future<List<ProductModel>> getFavorites() async {
    final response = await DioHelper.get(
      path: ApiConstant.getFavorites,
      withAuth: true,
    );
    final List data = response.data['data'];
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<bool> toggleFavorite(int productId) async {
    final response = await DioHelper.post(
      path: ApiConstant.toggleFavorite.replaceFirst(
        ':id',
        productId.toString(),
      ),
      withAuth: true,
    );
    return response.data['data']['is_favorited'];
  }
}
