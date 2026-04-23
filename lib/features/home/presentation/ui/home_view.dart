import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery2/features/home/presentation/cubit/recommendation/recommded_cubit_cubit.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/shared_widgets/categories_horizontal_list.dart';
import '../../../../core/utils/text_style.dart';

import '../../../category/data/models/CategoryModel.dart';
import '../../../category/data/logic/repo/category_repo_impl.dart';
import '../../../category/presentation/cubit/category_cubit.dart';
import '../../../category/presentation/ui/category_view.dart';
import '../../../category/presentation/widgets/dummy_data.dart';

import '../../data/logic/repo/repo_recommendation.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../cubit/recommendation/recommded_cubit_state.dart';
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
              CategoryCubit(getIt<CategoryRepoImpl>())
                ..getCategoryWithIndex(0),
        ),

        // ✅ Recommended Cubit
        BlocProvider(
          create: (_) => RecommendationCubit(RecommendationRepository())
            ..loadRecommendations(),
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

              // ✅ Recommended Section
              SizedBox(height: 20.h),

              Text(
                "Recommended For You",
                style: AppTextStyle.headlineMedium,
              ),

              SizedBox(height: 12.h),

              BlocBuilder<RecommendationCubit, RecommendationState>(
                builder: (context, state) {
                  if (state is RecommendationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is RecommendationSuccess) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.meals.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final meal = state.meals[index];

                        return _buildProductItem(
                          meal.title,
                          meal.categoryName,
                          meal.finalPrice.toString(),
                          meal.imageUrl,
                          oldPrice:
                              meal.hasOffer ? meal.price.toString() : null,
                        );
                      },
                    );
                  } else if (state is RecommendationError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox();
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

// ✅ Product Item Widget
Widget _buildProductItem(
  String name,
  String weight,
  String price,
  String imageUrl, {
  String? oldPrice,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
            ),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                weight,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  Text(
                    "£$price",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003D61),
                    ),
                  ),
                  if (oldPrice != null) ...[
                    const SizedBox(width: 5),
                    Text(
                      "£$oldPrice",
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ],
              ),
              Container(
            width: double.infinity,
            margin: const EdgeInsets.all(8),
            height: 35,
            child: ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003D61),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Add to cart",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
            ],
          ),
        ),
      ],
    ),
  );
}