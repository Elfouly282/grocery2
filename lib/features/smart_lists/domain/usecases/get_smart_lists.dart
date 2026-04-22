import '../entities/smart_list_entity.dart';
import '../repositories/smart_lists_repository.dart';

class GetSmartLists {
  final SmartListsRepository repository;

  GetSmartLists(this.repository);

  Future<List<SmartListEntity>> call() async {
    // TODO: Implement logic to fetch smart lists
    return await repository.getSmartLists();
  }
}