import 'package:get_it/get_it.dart';

import '../../features/product_details/data/datasources/product_remote_datasource.dart';
import '../../features/product_details/data/repositories/product_repository_impl.dart';
import '../../features/product_details/domain/repositories/product_repository.dart';
import '../../features/product_details/domain/usecases/get_product_details.dart';
import '../../features/product_details/presentation/cubit/product_details_cubit.dart';
import '../../features/smart_lists/data/datasources/favorites_remote_datasource.dart';
import '../../features/smart_lists/data/datasources/history_remote_datasource.dart';
import '../../features/smart_lists/data/datasources/smart_list_remote_data_source.dart';
import '../../features/smart_lists/data/repositories/favorites_repository_impl.dart';
import '../../features/smart_lists/data/repositories/history_repository_impl.dart';
import '../../features/smart_lists/data/repositories/smart_list_repository_impl.dart';
import '../../features/smart_lists/domain/repositories/favorites_repository.dart';
import '../../features/smart_lists/domain/repositories/history_repository.dart';
import '../../features/smart_lists/domain/repositories/smart_list_repository.dart';
import '../../features/smart_lists/domain/usecases/delete_smart_list.dart';
import '../../features/smart_lists/domain/usecases/get_favorites.dart';
import '../../features/smart_lists/domain/usecases/get_order_history.dart';
import '../../features/smart_lists/domain/usecases/get_smart_list_details.dart';
import '../../features/smart_lists/domain/usecases/get_smart_lists.dart';
import '../../features/smart_lists/domain/usecases/toggle_favorite.dart';
import '../../features/smart_lists/domain/usecases/update_smart_list.dart';
import '../../features/smart_lists/presentation/cubit/favorites_cubit.dart';
import '../../features/smart_lists/presentation/cubit/history_cubit.dart';
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

  // ============= History Feature =============

  // DataSource
  sl.registerLazySingleton<HistoryRemoteDataSource>(
    () => HistoryRemoteDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(remoteDataSource: sl()),
  );

  // UseCase
  sl.registerLazySingleton(() => GetOrderHistory(sl()));

  // Cubit
  sl.registerFactory(() => HistoryCubit(getOrderHistoryUseCase: sl()));

  // ============= Smart Lists Feature =============

  // DataSource
  sl.registerLazySingleton<SmartListRemoteDataSource>(
    () => SmartListRemoteDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<SmartListRepository>(
    () => SmartListRepositoryImpl(sl()),
  );

  // UseCase
  sl.registerLazySingleton(() => GetSmartLists(sl()));
  sl.registerLazySingleton(() => GetSmartListDetails(sl()));
  sl.registerLazySingleton(() => UpdateSmartList(sl()));
  sl.registerLazySingleton(() => DeleteSmartList(sl()));

  // Cubit
  sl.registerFactory(
    () => SmartListsCubit(
      getSmartListsUseCase: sl(),
      getSmartListDetailsUseCase: sl(),
      updateSmartListUseCase: sl(),
      deleteSmartListUseCase: sl(),
    ),
  );
}
