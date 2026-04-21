import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery2/features/product_details/data/datasources/product_remote_datasource.dart';
import 'package:grocery2/features/product_details/data/repositories/product_repository_impl.dart';
import 'package:grocery2/features/product_details/domain/usecases/get_product_details.dart';
import 'package:grocery2/features/product_details/presentation/cubit/product_details_cubit.dart';

import 'core/utils/app_colors.dart';
import 'features/product_details/presentation/screens/product_details_screen.dart';

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

          home: BlocProvider<ProductDetailsCubit>(
            create: (context) => ProductDetailsCubit(
              GetProductDetails(
                ProductRepositoryImpl(
                  remoteDataSource: ProductRemoteDataSourceImpl(),
                ),
              ),
            ),
            child: const ProductDetailsScreen(productId: 1),
          ),
        );
      },
    );
  }
}
