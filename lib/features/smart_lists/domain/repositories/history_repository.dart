import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../product_details/domain/entities/product_entity.dart';

abstract class HistoryRepository {
  Future<Either<Failure, List<ProductEntity>>> getOrderHistory();
}