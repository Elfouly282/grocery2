import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery2/core/constants/app_color.dart';
import 'package:grocery2/core/constants/app_sizes.dart';
import 'package:grocery2/core/enums/request_status_enum.dart';
import 'package:grocery2/features/product_list/data/datasource/remote_datasource/subcategories_datasource.dart';
import 'package:grocery2/features/product_list/data/repository/subcategories_repository.dart';
import 'package:grocery2/features/product_list/presentation/logic/product_list_cubit.dart';
import 'package:grocery2/features/product_list/presentation/ui/widgets/product_item_widget.dart';
import 'package:grocery2/features/product_list/presentation/ui/widgets/subcategories_list_widget.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductListCubit>(
      create: (context) =>
          ProductListCubit(SubcategoriesRepository(SubCategoriesDatasource())),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColor.black, size: AppSizes.w20),
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.search_sharp, color: AppColor.blueDark, size: AppSizes.r30),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(color: Colors.grey[300], height: 2.0),
          ),
        ),
        body: BlocBuilder<ProductListCubit, ProductListState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      AppSizes.w16,
                      AppSizes.h16,
                      AppSizes.w16,
                      AppSizes.h8,
                    ),
                    child: Text(
                      'Sub Categories',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SubcategoriesListWidget(),
                if (state.mealsRequestStatus == RequestStatusEnum.loading &&
                    state.meals.isEmpty)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.mealsRequestStatus == RequestStatusEnum.error &&
                    state.meals.isEmpty)
                  SliverFillRemaining(
                    child: Center(child: Text(state.errorMessage ?? "An error occurred")),
                  )
                else if (state.mealsRequestStatus == RequestStatusEnum.loaded &&
                    state.meals.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Text(
                        "Added Soon",
                        style: TextStyle(
                          fontSize: AppSizes.sp20,
                          color: AppColor.textPrimary,
                        ),
                      ),
                    ),
                  )
                else ...[
                  SliverPadding(
                    padding: EdgeInsets.all(AppSizes.w16),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        mainAxisSpacing: AppSizes.h16,
                        crossAxisSpacing: AppSizes.w16,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return ProductItemWidget(meal: state.meals[index]);
                      }, childCount: state.meals.length),
                    ),
                  ),
                  if (state.mealsRequestStatus == RequestStatusEnum.loading)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
