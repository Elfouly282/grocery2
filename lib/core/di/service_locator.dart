import 'package:get_it/get_it.dart';

import '../../features/smart_lists/data/datasources/smart_lists_remote_datasource.dart';
import '../../features/smart_lists/data/repositories/smart_lists_repository_impl.dart';
import '../../features/smart_lists/domain/repositories/smart_lists_repository.dart';
import '../../features/smart_lists/domain/usecases/get_favorites.dart';
import '../../features/smart_lists/domain/usecases/get_history.dart';
import '../../features/smart_lists/domain/usecases/get_smart_lists.dart';
import '../../features/smart_lists/presentation/cubit/favorites_cubit.dart';
import '../../features/smart_lists/presentation/cubit/history_cubit.dart';
import '../../features/smart_lists/presentation/cubit/smart_lists_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ============= Smart Lists Feature =============
  // Single Remote DataSource (shared)
  sl.registerLazySingleton<SmartListsRemoteDataSource>(
    () => SmartListsRemoteDataSource(),
  );

  // Single Repository (shared)
  sl.registerLazySingleton<SmartListsRepository>(
    () => SmartListsRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Cases (each gets the same repository)
  sl.registerLazySingleton(() => GetSmartLists(sl()));
  sl.registerLazySingleton(() => GetFavorites(sl()));
  sl.registerLazySingleton(() => GetHistory(sl()));

  // Individual Cubits (factory - new instance each time)
  sl.registerFactory(() => SmartListsCubit(getSmartListsUseCase: sl()));
  sl.registerFactory(() => FavoritesCubit(getFavoritesUseCase: sl()));
  sl.registerFactory(() => HistoryCubit(getHistoryUseCase: sl()));
}
