import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails(int id) async {
    try {
      final product = await remoteDataSource.getProductDetails(id);
      return Right(product);
    } on DioException catch (e) {
      return Left(ServerFailure(
        e.response?.data['message'] ?? 'Failed to fetch product details',
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
