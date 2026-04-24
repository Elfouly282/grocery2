import '../entities/smart_list_entity.dart';
import '../entities/favorite_entity.dart';
import '../entities/history_item_entity.dart';

abstract class SmartListsRepository {
  Future<List<SmartListEntity>> getSmartLists();
  Future<List<FavoriteEntity>> getFavorites();
  Future<List<HistoryItemEntity>> getHistory();
}
