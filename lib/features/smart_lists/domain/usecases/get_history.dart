import '../entities/history_item_entity.dart';
import '../repositories/smart_lists_repository.dart';

class GetHistory {
  final SmartListsRepository repository;

  GetHistory(this.repository);

  Future<List<HistoryItemEntity>> call() async {
    // TODO: Implement logic to fetch history
    return await repository.getHistory();
  }
}