import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/shared_widgets/categories_horizontal_list.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../../../product_list/presentation/ui/product_list_screen.dart';
import '../../../../core/utils/text_style.dart';

import '../../data/logic/repo/category_repo_impl.dart';
import '../../data/models/CategoryModel.dart';
import '../../data/models/categories_meals/category_meals_model.dart';
import '../cubit/category_cubit.dart';
import '../widgets/category_meal_list_item.dart';
import '../widgets/category_meal_list_skeleton.dart';
import '../widgets/dummy_data.dart';

class CategoryScreen extends StatelessWidget {
  final int initialIndex;

  const CategoryScreen({super.key, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CategoryCubit(getIt<CategoryRepoImpl>())
            ..getCategoryWithIndex(initialIndex),
      child: const _CategoryScreenBody(),
    );
  }
}

class _CategoryScreenBody extends StatelessWidget {
  const _CategoryScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            final isCategoriesLoading = state is CategoryLoading;

            final isDetailsLoading = state is CategorySuccess
                ? state.isDetailsLoading
                : false;

            final List<CategoryModel> categories = state is CategorySuccess
                ? state.categories.data
                : <CategoryModel>[];

            final selectedIndex = state is CategorySuccess
                ? state.selectedIndex
                : 0;

            final List<Meal> details = state is CategorySuccess
                ? state.details?.data.meals ?? <Meal>[]
                : <Meal>[];

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),

                  Text('Categories', style: AppTextStyle.headlineMedium),

                  SizedBox(height: 8.h),

                  Skeletonizer(
                    enabled: isCategoriesLoading && categories.isEmpty,
                    child: SizedBox(
                      height: 120.h,
                      child: SubCategoriesHorizontalList(
                        categories: isCategoriesLoading && categories.isEmpty
                            ? DummyData.categories
                            : categories,
                        selectedIndex: selectedIndex,
                        onTap: (index) {
                          context.read<CategoryCubit>().selectCategory(index);
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Skeletonizer(
                    enabled: isDetailsLoading,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: isDetailsLoading ? 4 : details.length,
                      itemBuilder: (context, index) {
                        if (isDetailsLoading || details.isEmpty) { // Added details.isEmpty check for skeleton
                          return const CategoryMealListSkeleton();
                        }

                        return CategoryMealListItem(
                          meal: details[index],
                          ontp: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProductListScreen(
                                    categoryId:details[index].id, // Pass selected category ID
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
