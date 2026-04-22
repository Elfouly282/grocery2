import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:grocery2/core/constants/api_constant.dart';
import '../../features/category/data/logic/repo/category_repo_impl.dart';
import '../../features/category/presentation/cubit/category_cubit.dart';
import '../constants/dio_helper.dart';


final getIt = GetIt.instance;

Future<void> setupLocator() async {

  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  getIt.registerLazySingleton<Dio>(() => DioHelper.dio);
  getIt.registerLazySingleton<CategoryRepoImpl>(
        () => CategoryRepoImpl(),
  );

  getIt.registerLazySingleton<CategoryCubit>(
        () => CategoryCubit(getIt<CategoryRepoImpl>(),),
  );

}