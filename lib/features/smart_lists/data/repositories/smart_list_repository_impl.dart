import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/smart_list_entity.dart';
import '../../domain/repositories/smart_list_repository.dart';
import '../datasources/smart_list_remote_data_source.dart';

class SmartListRepositoryImpl implements SmartListRepository {
  final SmartListRemoteDataSource remoteDataSource;

  SmartListRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<SmartListEntity>>> getSmartLists() async {
    try {
      final result = await remoteDataSource.getSmartLists();
      return Right(result);
    } on DioException catch (e) {
      return Left(handleDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SmartListEntity>> getSmartListDetails(int id) async {
    try {
      final result = await remoteDataSource.getSmartListDetails(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(handleDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> createSmartList({
    required String name,
    required String description,
    File? image,
    required List<int> mealIds,
  }) async {
    try {
      MultipartFile? multipartImage;
      if (image != null) {
        multipartImage = await MultipartFile.fromFile(image.path);
      }
      
      await remoteDataSource.createSmartList(
        name: name,
        description: description,
        image: multipartImage,
        mealIds: mealIds,
      );
      return const Right(unit);
    } on DioException catch (e) {
      return Left(handleDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateSmartList({
    required int id,
    String? name,
    String? description,
    File? image,
    List<int>? mealIds,
  }) async {
    try {
      MultipartFile? multipartImage;
      if (image != null) {
        multipartImage = await MultipartFile.fromFile(image.path);
      }
      
      await remoteDataSource.updateSmartList(
        id: id,
        name: name,
        description: description,
        image: multipartImage,
        mealIds: mealIds,
      );
      return const Right(unit);
    } on DioException catch (e) {
      return Left(handleDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteSmartList(int id) async {
    try {
      await remoteDataSource.deleteSmartList(id);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(handleDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
