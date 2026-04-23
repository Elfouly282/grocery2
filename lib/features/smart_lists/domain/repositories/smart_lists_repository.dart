import '../../../product_details/domain/entities/product_entity.dart';
import '../entities/history_item_entity.dart';
import '../entities/smart_list_entity.dart';

abstract class SmartListsRepository {
  Future<List<SmartListEntity>> getSmartLists();

  Future<List<ProductEntity>> getFavorites();

  Future<List<HistoryItemEntity>> getHistory();
}
