import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../shared/app_button.dart';
import '../../../product_details/domain/entities/product_entity.dart';

class HistoryProductCard extends StatelessWidget {
  final ProductEntity product;
  final bool isFavorite;

  const HistoryProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount = product.hasOffer && product.discountPrice != null;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.borderColor.withOpacity(0.5),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            AspectRatio(
              aspectRatio: 13 / 9,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: AppColors.greyLight.withOpacity(0.5),
                    child: product.image.isNotEmpty
                        ? Image.network(
                            product.image,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildPlaceholder(),
                          )
                        : _buildPlaceholder(),
                  ),

                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        product.isFavorited
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isFavorited
                            ? AppColors.error
                            : AppColors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// INFO
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE
                    Text(
                      product.title,
                      style: AppTextStyle.titleSmall.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 6.h),

                    /// PRICE
                    Row(
                      children: [
                        Text(
                          '£${product.finalPrice.toStringAsFixed(2)}',
                          style: AppTextStyle.titleMedium.copyWith(
                            color: hasDiscount
                                ? AppColors.error
                                : AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        if (hasDiscount) ...[
                          SizedBox(width: 6.w),
                          Text(
                            '£${product.price.toStringAsFixed(2)}',
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ],
                    ),

                    const Spacer(),

                    /// BUTTON
                    AppButton(
                      text: 'Add to Cart',
                      onPressed: () {},
                      width: double.infinity,
                      height: 32.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(
        Icons.image_not_supported_outlined,
        size: 32.sp,
        color: AppColors.grey.withOpacity(0.5),
      ),
    );
  }
}
