import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/id/get_it.dart';
import '../../../../core/shared_widgets/categories_horizontal_list.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../../../../core/utils/text_style.dart';
import '../../data/logic/repo/sub_catigory_repo_impl.dart';
import '../../data/models/SubCategoryModel.dart';
import '../cubit/subcategory_cubit.dart';
import '../widgets/dummy_data.dart';

class SubcategoryView extends StatelessWidget {
  const SubcategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      SubcategoryCubit(getIt<CategoryRepoImpl>())..getCategory(),
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<SubcategoryCubit, SubcategoryState>(
            builder: (context, state) {
              final isLoading = state is SubcategoryLoading;
              List<SubCategoryModel> categories = [];
              int selectedIndex = 0;
              if (state is SubcategorySuccess) {
                categories = state.categories.data;
                selectedIndex = state.selectedIndex;
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Text(
                    'Categories',
                    style: AppTextStyle.headlineMedium,
                  ),
                  SizedBox(height: 8.h),
                  Skeletonizer(
                    enabled: isLoading,
                    child: CategoriesHorizontalList(
                      categories: isLoading
                          ? DummyData.categories
                          : categories,
                      selectedIndex: selectedIndex,
                      onTap: (index) {
                        if (!isLoading) {
                          context
                              .read<SubcategoryCubit>()
                              .selectCategory(index);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}