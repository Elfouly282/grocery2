import 'package:get_it/get_it.dart';

import '../../features/product_details/data/datasources/product_remote_datasource.dart';
import '../../features/product_details/data/repositories/product_repository_impl.dart';
import '../../features/product_details/domain/repositories/product_repository.dart';
import '../../features/product_details/domain/usecases/get_product_details.dart';
import '../../features/product_details/presentation/cubit/product_details_cubit.dart';
import '../../features/smart_lists/data/datasources/favorites_remote_datasource.dart';
import '../../features/smart_lists/data/datasources/smart_lists_remote_datasource.dart';
import '../../features/smart_lists/data/repositories/favorites_repository_impl.dart';
import '../../features/smart_lists/data/repositories/smart_lists_repository_impl.dart';
import '../../features/smart_lists/domain/repositories/favorites_repository.dart';
import '../../features/smart_lists/domain/repositories/smart_lists_repository.dart';
import '../../features/smart_lists/domain/usecases/get_favorites.dart';
import '../../features/smart_lists/domain/usecases/get_smart_lists.dart';
import '../../features/smart_lists/domain/usecases/toggle_favorite.dart';
import '../../features/smart_lists/presentation/cubit/favorites_cubit.dart';
import '../../features/smart_lists/presentation/cubit/smart_lists_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ============= Product Details Feature =============

  // DataSource
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );

  // UseCase
  sl.registerLazySingleton(() => GetProductDetails(sl()));

  // Cubit
  sl.registerFactory(() => ProductDetailsCubit(sl<GetProductDetails>()));

  // ============= Favorites Feature =============

  // DataSource
  sl.registerLazySingleton<FavoritesRemoteDataSource>(
    () => FavoritesRemoteDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetFavorites(sl()));
  sl.registerLazySingleton(() => ToggleFavorite(sl()));

  // Cubit
  sl.registerFactory(
    () =>
        FavoritesCubit(getFavoritesUseCase: sl(), toggleFavoriteUseCase: sl()),
  );

  // ============= Smart Lists Feature =============
  // Data Source
  sl.registerLazySingleton<SmartListsRemoteDataSource>(
    () => SmartListsRemoteDataSource(),
  );

  // Repository
  // SmartListsRepositoryImpl now takes the remote data source in the constructor
  sl.registerLazySingleton<SmartListsRepository>(
    () => SmartListsRepositoryImpl(sl()),
  );

  // UseCase
  sl.registerLazySingleton<GetSmartLists>(() => GetSmartLists(sl()));

  // Cubit
  sl.registerFactory<SmartListsCubit>(() => SmartListsCubit(sl()));
}
