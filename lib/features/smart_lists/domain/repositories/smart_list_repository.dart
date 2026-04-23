import 'dart:io';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/smart_list_entity.dart';

abstract class SmartListRepository {
  Future<Either<Failure, List<SmartListEntity>>> getSmartLists();
  
  Future<Either<Failure, SmartListEntity>> getSmartListDetails(int id);
  
  Future<Either<Failure, Unit>> createSmartList({
    required String name,
    required String description,
    File? image,
    required List<int> mealIds,
  });
  
  Future<Either<Failure, Unit>> updateSmartList({
    required int id,
    String? name,
    String? description,
    File? image,
    List<int>? mealIds,
  });
  
  Future<Either<Failure, Unit>> deleteSmartList(int id);
}
