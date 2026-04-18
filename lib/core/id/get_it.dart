import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:grocery2/core/constants/api_constant.dart';
import '../../feature/subcategory/data/logic/repo/sub_catigory_repo_impl.dart';
import '../../feature/subcategory/presentation/cubit/subcategory_cubit.dart';
import '../constants/dio_helper.dart';


final getIt = GetIt.instance;

Future<void> setupLocator() async {

  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  getIt.registerLazySingleton<Dio>(() => DioHelper.dio);
  getIt.registerLazySingleton<CategoryRepoImpl>(
        () => CategoryRepoImpl(),
  );

}