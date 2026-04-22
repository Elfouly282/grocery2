import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery2/features/login/presentation/ui/login_screen.dart';
import 'core/constants/api_constant.dart';
import 'core/constants/dio_helper.dart';
import 'core/constants/preference_manager.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager().init();
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'grocery app',
            home: const  LoginScreen(),
          );
        },
    );
  }
}
