import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../product_details/domain/entities/product_entity.dart';
import '../repositories/favorites_repository.dart';

class GetFavorites {
  final FavoritesRepository repository;

  GetFavorites(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await repository.getFavorites();
  }
}
