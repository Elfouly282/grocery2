import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery2/core/constants/api_constant.dart';
import 'package:grocery2/core/constants/dio_helper.dart';
import 'package:grocery2/core/constants/preference_manager.dart';
import 'package:grocery2/core/di/get_it.dart';
 import 'package:grocery2/features/splash/UI/Splach.dart';
 
void main() async{
 WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager().init();
  setupLocator();
  DioHelper.init(
    baseUrl: ApiConstant.baseUrl,
  );
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
        home:   SplashView(),
      ),
    );
  }
}
