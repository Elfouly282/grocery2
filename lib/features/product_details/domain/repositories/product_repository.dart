import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<ProductEntity> getProductDetails(int id);
}
