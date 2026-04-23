import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../product_details/domain/entities/product_entity.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<ProductEntity>>> getFavorites();

  Future<Either<Failure, bool>> toggleFavorite(int productId);
}
