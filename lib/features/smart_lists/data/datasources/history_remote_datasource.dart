import '../../../../core/constants/api_constant.dart';
import '../../../../core/constants/dio_helper.dart';
import '../../../product_details/data/models/product_model.dart';

abstract class HistoryRemoteDataSource {
  Future<List<ProductModel>> getOrderHistory();
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  @override
  Future<List<ProductModel>> getOrderHistory() async {
    final response = await DioHelper.get(
      path: ApiConstant.ordersHistory,
      withAuth: true,
    );
    final List orders = response.data['data'] ?? [];

    final List<ProductModel> products = [];
    for (final order in orders) {
      final List items = order['items'] ?? [];
      for (final item in items) {
        final meal = item['meal'];
        if (meal != null) {
          products.add(ProductModel.fromJson(meal));
        }
      }
    }
    return products;
  }
}