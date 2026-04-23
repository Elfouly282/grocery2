import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/favorites_repository.dart';

class ToggleFavorite {
  final FavoritesRepository repository;

  ToggleFavorite(this.repository);

  Future<Either<Failure, bool>> call(int productId) async {
    return await repository.toggleFavorite(productId);
  }
}
