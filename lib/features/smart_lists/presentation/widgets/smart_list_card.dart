import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../shared/app_button.dart';
import '../../domain/entities/smart_list_entity.dart';
import '../cubit/smart_lists_cubit.dart';

class SmartListCard extends StatelessWidget {
  final SmartListEntity smartList;

  const SmartListCard({super.key, required this.smartList});

  @override
  Widget build(BuildContext context) {
    final meals = smartList.meals ?? [];

    return Container(
      padding: EdgeInsets.all(12.w),

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: smartList.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          smartList.image!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) =>
                              const Icon(Icons.list_alt, color: AppColors.grey),
                        ),
                      )
                    : const Icon(Icons.list_alt, color: AppColors.grey),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🏷️ Title
                    Text(
                      smartList.name,
                      style: AppTextStyles.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // 📂 Category
                    if (smartList.category != null)
                      Text(
                        smartList.category!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    // 📝 Description
                    if (smartList.description != null)
                      Text(
                        smartList.description!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                    SizedBox(height: 4.h),

                    // =========================
                    // 🔢 Items Count + Badges
                    // =========================
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${meals.length} items',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),

                        // 🏷️ Badges
                        if (smartList.notifyOnPriceDrop ||
                            smartList.notifyOnOffers)
                          Row(
                            children: [
                              if (smartList.notifyOnPriceDrop)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.error.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    'Price Drop',
                                    style: AppTextStyles.labelSmall.copyWith(
                                      color: AppColors.error,
                                      fontSize: 9.sp,
                                    ),
                                  ),
                                ),

                              if (smartList.notifyOnPriceDrop &&
                                  smartList.notifyOnOffers)
                                SizedBox(width: 4.w),

                              if (smartList.notifyOnOffers)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor.withOpacity(
                                      0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    'Offers',
                                    style: AppTextStyles.labelSmall.copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 9.sp,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.grey),
                onPressed: () {
                  context.read<SmartListsCubit>().deleteSmartList(smartList.id);
                },
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: AppButton(
                  text: 'Add All To Cart',
                  onPressed: () {},
                  height: 35.h,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AppButton(
                  text: 'Edit',
                  onPressed: () {},
                  height: 35.h,
                  backgroundColor: AppColors.white,
                  textColor: AppColors.primaryColor,
                  borderColor: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
