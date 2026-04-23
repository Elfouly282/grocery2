import 'dart:io';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/smart_list_repository.dart';

class UpdateSmartList {
  final SmartListRepository repository;

  UpdateSmartList(this.repository);

  Future<Either<Failure, Unit>> call({
    required int id,
    String? name,
    String? description,
    File? image,
    List<int>? mealIds,
  }) async {
    return await repository.updateSmartList(
      id: id,
      name: name,
      description: description,
      image: image,
      mealIds: mealIds,
    );
  }
}
