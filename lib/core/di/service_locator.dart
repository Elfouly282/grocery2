import 'package:get_it/get_it.dart';

// feature imports
import '../../features/product_details/data/datasources/product_remote_datasource.dart';
import '../../features/product_details/data/repositories/product_repository_impl.dart';
import '../../features/product_details/domain/repositories/product_repository.dart';
import '../../features/product_details/domain/usecases/get_product_details.dart';
import '../../features/product_details/presentation/cubit/product_details_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // DataSource
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );

  // UseCase
  sl.registerLazySingleton(
    () => GetProductDetails(sl()),
  );

  // Cubit
  sl.registerFactory(
    () => ProductDetailsCubit(sl()),
  );
}