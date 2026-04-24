import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery2/core/di/get_it.dart';
import 'package:grocery2/core/di/service_locator.dart';
import 'package:grocery2/core/theme/app_theme.dart';
import 'package:grocery2/features/profile&setting/data/logic/theme.dart';
import 'package:grocery2/features/splash/ui/splash_screen.dart';

import 'core/constants/api_constant.dart';
import 'core/constants/bloc_abserver.dart';
import 'core/constants/dio_helper.dart';
import 'core/constants/preference_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager().init();
  await ScreenUtil.ensureScreenSize();
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  Bloc.observer = AppBlocObserver();
  await setupLocator();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            child: MaterialApp(
              title: 'Grocery',
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: AppTheme.lightTheme(),
              darkTheme: AppTheme.darkTheme(),
              home: const SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
