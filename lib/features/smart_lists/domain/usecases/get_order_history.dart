import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../product_details/domain/entities/product_entity.dart';
import '../../domain/repositories/history_repository.dart';

class GetOrderHistory {
  final HistoryRepository repository;

  GetOrderHistory(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call() async {
    return repository.getOrderHistory();
  }
}