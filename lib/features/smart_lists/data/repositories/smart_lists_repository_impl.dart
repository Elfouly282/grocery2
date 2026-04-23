import '../../../product_details/domain/entities/product_entity.dart';
import '../../domain/entities/history_item_entity.dart';
import '../../domain/entities/smart_list_entity.dart';
import '../../domain/repositories/smart_lists_repository.dart';
import '../datasources/smart_lists_remote_datasource.dart';

class SmartListsRepositoryImpl implements SmartListsRepository {
  final SmartListsRemoteDataSource remoteDataSource;

  SmartListsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<SmartListEntity>> getSmartLists() async {
    // TODO: Implement logic
    // final models = await remoteDataSource.getSmartLists();
    // return models.map((e) => e.toEntity()).toList();
    return [];
  }

  @override
  Future<List<ProductEntity>> getFavorites() async {
    // TODO: Implement logic
    return [];
  }

  @override
  Future<List<HistoryItemEntity>> getHistory() async {
    final models = await remoteDataSource.getHistory();
    return models.map((e) => e.toEntity()).toList();
  }
}
