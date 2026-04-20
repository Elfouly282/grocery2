import 'package:flutter/material.dart';
import 'package:grocery2/features/payment_success/presentation/logic/payment_details_cubit.dart';
import 'package:grocery2/features/payment_success/presentation/ui/payment_status_screen.dart';

import 'core/constants/api_constant.dart';
import 'core/constants/bloc_abserver.dart';
import 'core/constants/dio_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/di_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  DioHelper.setToken("752|sPXsQf1wo0D3aXTYnbu4j6VI5k6HxawLuAqLljBZ28e0202c");
  Bloc.observer = AppBlocObserver();
  await initDependencies();
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
        home: BlocProvider(
          create: (context) => sl<PaymentDetailsCubit>(),
          child: PaymentStatusScreen(orderId: 36),
        ),
      ),
    );
  }
}
