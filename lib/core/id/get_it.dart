import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:grocery2/core/constants/api_constant.dart';
import '../../features/signup/data/logic/repo/signup_repo_impl.dart';
import '../../features/signup/presentation/cubit/signup_cubit.dart';
import '../constants/dio_helper.dart';


final getIt = GetIt.instance;

Future<void> setupLocator() async {

  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  getIt.registerLazySingleton<Dio>(() => DioHelper.dio);
  getIt.registerLazySingleton<SignupRepoImpl>(
        () => SignupRepoImpl(),
  );

  getIt.registerFactory<SignupCubit>(
        () => SignupCubit(getIt<SignupRepoImpl>()),
  );
}