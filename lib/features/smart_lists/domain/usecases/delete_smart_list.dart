import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/smart_list_repository.dart';

class DeleteSmartList {
  final SmartListRepository repository;

  DeleteSmartList(this.repository);

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteSmartList(id);
  }
}
