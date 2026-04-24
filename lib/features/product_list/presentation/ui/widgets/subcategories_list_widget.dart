import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery2/core/constants/app_color.dart';
import 'package:grocery2/core/constants/app_sizes.dart';
import 'package:grocery2/core/enums/request_status_enum.dart';
import 'package:grocery2/features/product_list/presentation/logic/product_list_cubit.dart';

class SubcategoriesListWidget extends StatelessWidget {
        final  int id;
  SubcategoriesListWidget({super.key,required this.id});
 
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
            // Show filtered subcategories
            if (state.filteredSubcategories.isEmpty) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSizes.h20),
                    child: Text(
                      'No subcategories found',
                      style: GoogleFonts.inter(
                        fontSize: AppSizes.sp14,
                        color: AppColor.textSecondBlack,
                      ),
                    ),
                  ),
                ),
              );
            }

            return SliverToBoxAdapter(
              child: SizedBox(
                height: AppSizes.h130,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.filteredSubcategories.length,
                  separatorBuilder: (context, index) => SizedBox(width: AppSizes.w8),
                  itemBuilder: (BuildContext context, int index) {
                    final subcategory = state.filteredSubcategories[index];
                    
                    // Safely parse subId to int
                    final subIdInt = int.tryParse(subcategory.subId);
                    if (subIdInt == null) {
                      // Skip if subId cannot be parsed
                      return SizedBox.shrink();
                    }

                    final isSelected = state.selectedSubcategoryId == subIdInt;

                    return GestureDetector(
                      onTap: () {
                        context
                            .read<ProductListCubit>()
                            .selectSubcategory(subIdInt);
                      },
                      child: Container(
                        width: AppSizes.w80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? AppColor.secondBorderColor
                                : AppColor.borderColor,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(AppSizes.r16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: AppSizes.h12),
                            Container(
                              height: AppSizes.h60,
                              width: AppSizes.w64,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSizes.r16),
                                color: AppColor.greyLight,
                              ),
                              child: subcategory.image != null &&
                                      subcategory.image!.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          AppSizes.r16),
                                      child: Image.network(
                                        subcategory.image!,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child:
                                                CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                        errorBuilder: (context, error,
                                            stackTrace) {
                                          return Center(
                                            child: Icon(
                                              Icons
                                                  .image_not_supported_outlined,
                                              color: Colors.grey,
                                              size: AppSizes.w24,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Center(
                                      child: Icon(
                                        Icons.photo_outlined,
                                        color: Colors.grey,
                                        size: AppSizes.w24,
                                      ),
                                    ),
                            ),
                            SizedBox(height: AppSizes.h6),
                            Text(
                              subcategory.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: AppSizes.sp14,
                                fontWeight: isSelected
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                                color: isSelected
                                    ? AppColor.textBlueDark
                                    : AppColor.textSecondBlack,
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
