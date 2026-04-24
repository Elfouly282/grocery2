import '../../domain/entities/smart_list_entity.dart';
import '../../domain/entities/favorite_entity.dart';
import '../../domain/entities/history_item_entity.dart';
import '../../domain/repositories/smart_lists_repository.dart';
import '../datasources/smart_lists_remote_datasource.dart';

class SmartListsRepositoryImpl implements SmartListsRepository {
  final SmartListsRemoteDataSource remoteDataSource;

  SmartListsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<SmartListEntity>> getSmartLists() async {
    // TODO: Implement logic
    // final models = await remoteDataSource.getSmartLists();
    // return models.map((e) => e.toEntity()).toList();
    return [];
  }

  @override
  Future<List<FavoriteEntity>> getFavorites() async {
    // TODO: Implement logic
    return [];
  }

  @override
  Future<List<HistoryItemEntity>> getHistory() async {
    // TODO: Implement logic
    return [];
  }
}