import 'package:flutter/material.dart';
import 'package:grocery2/core/constants/dio_helper.dart';
import 'core/constants/api_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/bloc_abserver.dart';
import 'features/product_list/presentation/ui/product_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'grocery2',
        theme: ThemeData.light(),
        home: const ProductListScreen(),
      ),
    );
  }
}
