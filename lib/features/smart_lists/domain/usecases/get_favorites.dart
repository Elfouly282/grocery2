import '../entities/favorite_entity.dart';
import '../repositories/smart_lists_repository.dart';

class GetFavorites {
  final SmartListsRepository repository;

  GetFavorites(this.repository);

  Future<List<FavoriteEntity>> call() async {
    // TODO: Implement logic to fetch favorites
    return await repository.getFavorites();
  }
}