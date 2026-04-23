import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/shared_widgets/categories_horizontal_list.dart';
import '../../../../core/utils/text_style.dart';

import '../../../category/data/models/CategoryModel.dart';
import '../../../category/data/logic/repo/category_repo_impl.dart';
import '../../../category/presentation/cubit/category_cubit.dart';
import '../../../category/presentation/ui/category_view.dart';
import '../../../category/presentation/widgets/dummy_data.dart';

import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_search.dart';
import '../widgets/home_deals_slider.dart';

import '../../data/model/deals_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeCubit()..getHomeData(),
        ),
        BlocProvider(
          create: (_) =>
          CategoryCubit(getIt<CategoryRepoImpl>())..getCategoryWithIndex(0),
        ),
      ],
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              const HomeSearch(),

              SizedBox(height: 10.h),

              Text(
                "Today's Deals",
                style: AppTextStyle.headlineMedium,
              ),

              SizedBox(height: 12.h),

              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final isLoading = state is HomeLoading;

                  final List<DealModel> deals =
                  state is HomeSuccess ? state.deals : [];

                  return HomeDealsSlider(
                    deals: deals,
                    isLoading: isLoading,
                  );
                },
              ),

              SizedBox(height: 10.h),

              Text(
                'Categories',
                style: AppTextStyle.headlineMedium,
              ),

              SizedBox(height: 10.h),

              BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  final isLoading = state is CategoryLoading;

                  final List<CategoryModel> categories =
                  state is CategorySuccess
                      ? state.categories.data
                      : DummyData.categories;

                  final selectedIndex =
                  state is CategorySuccess ? state.selectedIndex : 0;

                  return SizedBox(
                    height: 120.h,
                    child: SubCategoriesHorizontalList(
                      categories: categories,
                      selectedIndex: selectedIndex,
                      onTap: (index) {
                        context.read<CategoryCubit>().selectCategory(index);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CategoryView(initialIndex: index),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}