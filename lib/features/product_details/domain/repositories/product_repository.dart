import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductEntity>> getProductDetails(int id);
}
