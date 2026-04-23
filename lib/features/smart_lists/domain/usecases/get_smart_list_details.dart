import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/smart_list_entity.dart';
import '../repositories/smart_list_repository.dart';

class GetSmartListDetails {
  final SmartListRepository repository;

  GetSmartListDetails(this.repository);

  Future<Either<Failure, SmartListEntity>> call(int id) async {
    return await repository.getSmartListDetails(id);
  }
}
