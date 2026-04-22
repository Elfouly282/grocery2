import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/service_locator.dart';
import 'core/utils/app_colors.dart';
import 'features/smart_lists/presentation/cubit/favorites_cubit.dart';
import 'features/smart_lists/presentation/cubit/history_cubit.dart';
import 'features/smart_lists/presentation/cubit/smart_lists_cubit.dart';
import 'features/smart_lists/presentation/screens/smart_lists_screen.dart';

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColors.primaryColor,
            scaffoldBackgroundColor: AppColors.white,
            useMaterial3: true,
          ),

          home: MultiBlocProvider(
            providers: [
              BlocProvider<SmartListsCubit>(
                create: (context) => sl<SmartListsCubit>(),
              ),
              BlocProvider<FavoritesCubit>(
                create: (context) => sl<FavoritesCubit>(),
              ),
              BlocProvider<HistoryCubit>(
                create: (context) => sl<HistoryCubit>(),
              ),
            ],
            child: const SmartListsScreen(),
          ),
        );
      },
    );
  }
}
