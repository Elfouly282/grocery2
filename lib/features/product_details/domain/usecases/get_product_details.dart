import 'package:fpdart/fpdart.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';
import '../../../../core/errors/failures.dart';

class GetProductDetails {
  final ProductRepository repository;

  GetProductDetails(this.repository);

  Future<Either<Failure, ProductEntity>> call(int id) async {
    return await repository.getProductDetails(id);
  }
}
