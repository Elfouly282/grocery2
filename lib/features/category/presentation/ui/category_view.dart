import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/shared_widgets/categories_horizontal_list.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../../../../core/utils/text_style.dart';
import '../../data/logic/repo/category_repo_impl.dart';
import '../cubit/category_cubit.dart';
import '../widgets/sub_category_vertical_list.dart';
import '../widgets/details_dummy_data.dart';
import '../widgets/dummy_data.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryCubit(getIt<CategoryRepoImpl>())
        ..getCategory(),
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {

              final isCategoriesLoading = state is CategoryLoading;

              final isDetailsLoading = state is CategorySuccess
                  ? state.isDetailsLoading
                  : false;

              final categories = state is CategorySuccess
                  ? state.categories.data
                  : DummyData.categories;

              final selectedIndex = state is CategorySuccess
                  ? state.selectedIndex
                  :0;

              final details = state is CategorySuccess
                  ? state.details?.data.meals ?? []
                  : [];
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    Text(
                      'Categories',
                      style: AppTextStyle.headlineMedium,
                    ),
                    SizedBox(height: 8.h),
                    Skeletonizer(
                      enabled: isCategoriesLoading,
                      child: SubCategoriesHorizontalList(
                        categories: categories,
                        selectedIndex: selectedIndex,
                        onTap: (index) {
                          context
                              .read<CategoryCubit>()
                              .selectCategory(index);
                        },
                      ),
                    ),

                    SizedBox(height: 12.h),
                    if (isDetailsLoading)
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (_, __) =>
                        const CategoriesVerticalListSkeleton(),
                        separatorBuilder: (_, __) =>
                            SizedBox(height: 10.h),
                      )
                    else if (details.isEmpty)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Center(
                            child: Text(
                              "No items found",
                              style: AppTextStyle.titleMedium,
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: details.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: 10.h),
                        itemBuilder: (context, index) {
                          return CategoriesVerticalList(
                            meal: details[index],
                          );
                        },
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}