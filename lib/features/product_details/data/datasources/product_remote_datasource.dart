import '../../../../core/constants/api_constant.dart';
import '../../../../core/constants/dio_helper.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getProductDetails(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<ProductModel> getProductDetails(int id) async {
    final response = await DioHelper.get(
      path: ApiConstant.getProductDetails.replaceFirst(':id', id.toString()),
    );
    return ProductModel.fromJson(response.data['data']);
  }
}