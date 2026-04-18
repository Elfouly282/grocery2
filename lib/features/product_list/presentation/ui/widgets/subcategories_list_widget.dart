import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery2/core/constants/app_color.dart';
import 'package:grocery2/core/constants/app_sizes.dart';
import 'package:grocery2/core/enums/request_status_enum.dart';
import 'package:grocery2/features/product_list/presentation/logic/product_list_cubit.dart';

class SubcategoriesListWidget extends StatelessWidget {
  const SubcategoriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListCubit, ProductListState>(
      builder: (context, state) {
        switch (state.subcategoriesRequestStatus) {
          case RequestStatusEnum.initial:
          case RequestStatusEnum.loading:
            return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          case RequestStatusEnum.error:
            return SliverToBoxAdapter(
                child: Center(child: Text(state.errorMessage ?? "Error")));
          case RequestStatusEnum.loaded:
            return SliverToBoxAdapter(
              child: SizedBox(
                height: AppSizes.h130,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.subcategories.length,
                  separatorBuilder: (context, index) => SizedBox(width: AppSizes.w8),
                  itemBuilder: (BuildContext context, int index) {
                    final subcategory = state.subcategories[index];
                    final isSelected =state.selectedSubcategoryId == int.parse(subcategory.subId);
                    return GestureDetector(
                      onTap: () {
                        context.read<ProductListCubit>().selectSubcategory(int.parse(subcategory.subId));

                      },
                      child: Container(
                        width: AppSizes.w80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? AppColor.secondBorderColor : AppColor.borderColor,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(AppSizes.r16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: AppSizes.h12,),
                            Container(
                              height: AppSizes.h60,
                              width: AppSizes.w64,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppSizes.r16),
                                image: subcategory.image != null
                                    ? DecorationImage(
                                  image: AssetImage(subcategory.image!),
                                  fit: BoxFit.cover,
                                )
                                    : DecorationImage(
                                  image: AssetImage('assets/images/grocery_local_image.png'),
                                  fit: BoxFit.cover,
                                ),
                                color: AppColor.greyLight,
                              ),
                            ),
                            SizedBox(height: AppSizes.h6),
                            Text(
                              subcategory.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.inter(
                                fontSize: AppSizes.sp14,
                                fontWeight: isSelected ? FontWeight.w500 : FontWeight
                                    .normal,
                                color: isSelected ? AppColor.textBlueDark : AppColor.textSecondBlack,
                            ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
        }
      },
    );
  }
}
