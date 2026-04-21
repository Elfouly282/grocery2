// lib/features/product_details/presentation/widgets/detail_card_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_style.dart';

class DetailCardItem extends StatelessWidget {
  final String title;
  final String value;
  final bool isExpired;

  const DetailCardItem({
    super.key,
    required this.title,
    required this.value,
    required this.isExpired,
  });

  @override
  Widget build(BuildContext context) {
    final valueColor = isExpired ? Colors.red : Colors.black;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),

          SizedBox(height: 4.h),

          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(color: valueColor),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ],
      ),
    );
  }
}
