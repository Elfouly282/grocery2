import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../product_details/domain/entities/product_entity.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_remote_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;

  FavoritesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getFavorites() async {
    try {
      final products = await remoteDataSource.getFavorites();
      return Right(products);
    } on DioException catch (e) {
      return Left(ServerFailure(
        e.response?.data['message'] ?? 'Network error occurred',
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite(int productId) async {
    try {
      final isFavorited = await remoteDataSource.toggleFavorite(productId);
      return Right(isFavorited);
    } on DioException catch (e) {
      return Left(ServerFailure(
        e.response?.data['message'] ?? 'Network error occurred',
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
