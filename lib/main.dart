import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/api_constant.dart';
import 'core/constants/dio_helper.dart';
import 'core/constants/preference_manager.dart';
import 'core/di/get_it.dart';
import 'feature/signup/presentation/ui/signup_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager().init();
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MaterialApp(
        title: 'Grocery',
        debugShowCheckedModeBanner: false,
        home: SignupView(),
      ),
    );
  }
}
