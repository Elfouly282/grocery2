import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../shared/app_button.dart';
import '../../../product_details/domain/entities/product_entity.dart';

class FavoriteCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onToggleFavorite;

  const FavoriteCard({
    super.key,
    required this.product,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.greyLight, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  product.image,
                  width: 124.w,
                  height: 124.h,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: 2,
                left: 2,
                child: InkWell(
                  onTap: onToggleFavorite,
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: const BoxDecoration(
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
              ),
            ],
          ),

          SizedBox(width: 12.w),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                style: AppTextStyles.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 6.h),

              Row(
                children: [
                  Text(
                    '£${product.finalPrice.toStringAsFixed(2)}',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  if (product.hasOffer) ...[
                    SizedBox(width: 8.w),
                    Text(
                      '£${product.price.toStringAsFixed(2)}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ],
              ),

              SizedBox(height: 10.h),

              AppButton(
                text: 'Add to Cart',
                width: 120.w,
                height: 40.h,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
