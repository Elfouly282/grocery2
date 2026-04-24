import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:grocery2/core/constants/api_constant.dart';
import 'package:grocery2/features/category/data/logic/repo/category_repo_impl.dart';
import 'package:grocery2/features/category/presentation/cubit/category_cubit.dart';
import 'package:grocery2/features/product_details/data/datasources/product_remote_datasource.dart';
import 'package:grocery2/features/product_details/data/repositories/product_repository_impl.dart';
import 'package:grocery2/features/product_details/domain/usecases/get_product_details.dart';
import 'package:grocery2/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:grocery2/features/profile&setting/data/logic/theme.dart';
import 'package:grocery2/features/profile&setting/data/repo/profile_repo.dart';
import 'package:grocery2/features/profile&setting/presentation/cubit/profile_cubit.dart';
import '../../features/signup/data/logic/repo/signup_repo_impl.dart';
import '../../features/signup/presentation/cubit/signup_cubit.dart';
import '../constants/dio_helper.dart';
import '../constants/preference_manager.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  getIt.registerLazySingleton<Dio>(() => DioHelper.dio);
  getIt.registerLazySingleton<PreferenceManager>(() => PreferenceManager());
  getIt.registerLazySingleton<SignupRepoImpl>(() => SignupRepoImpl());
  getIt.registerLazySingleton<CategoryRepoImpl>(() => CategoryRepoImpl());
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo());
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ProductRepositoryImpl>(
    () => ProductRepositoryImpl(
      remoteDataSource: getIt<ProductRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<GetProductDetails>(
    () => GetProductDetails(getIt<ProductRepositoryImpl>()),
  );

  getIt.registerFactory<CategoryCubit>(
    () => CategoryCubit(getIt<CategoryRepoImpl>()),
  );
  getIt.registerFactory<SignupCubit>(
    () => SignupCubit(getIt<SignupRepoImpl>()),
  );
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      repo: getIt<ProfileRepo>(),
      preferenceManager: getIt<PreferenceManager>(),
    ),
  );
  getIt.registerFactory<ProductDetailsCubit>(
    () => ProductDetailsCubit(getIt<GetProductDetails>()),
  );
}