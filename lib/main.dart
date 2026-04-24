import 'package:flutter/material.dart';
import 'package:grocery2/core/constants/dio_helper.dart';
import 'package:grocery2/core/constants/preference_manager.dart';
import 'package:grocery2/core/di/get_it.dart';
import 'package:grocery2/features/splash/ui/splash_screen.dart';
import 'core/constants/api_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/bloc_abserver.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize SharedPreferences
  await PreferenceManager().init();
  // Initialize ScreenUtil
  await ScreenUtil.ensureScreenSize();
  // Initialize Dio
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  // Initialize AppBlocObserver
  Bloc.observer = AppBlocObserver();
  // Initialize dependency injection
  setupLocator();
  // Run the app
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MaterialApp(
        title: 'Grocery',
        debugShowCheckedModeBanner: false,
        home:   SplashScreen(),
      ),
    );
  }
}
 