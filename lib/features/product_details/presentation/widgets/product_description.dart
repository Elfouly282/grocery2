import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_style.dart';
import '../../domain/entities/product_entity.dart';

class ProductDescription extends StatelessWidget {
  final ProductEntity product;

  const ProductDescription({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description', style: AppTextStyle.headlineSmall),
          SizedBox(height: 5.h),
          Text(
            product.description,
            style: AppTextStyle.bodyLarge.copyWith(color: AppColors.greyDark),
          ),

          SizedBox(height: 20.h),
          if (product.howToUse != null && product.howToUse!.isNotEmpty) ...[
            Text('How to Use', style: AppTextStyle.headlineSmall),
            SizedBox(height: 5.h),
            Text(
              product.howToUse!,
              style: AppTextStyle.bodyLarge.copyWith(
                color: AppColors.greyDark,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
