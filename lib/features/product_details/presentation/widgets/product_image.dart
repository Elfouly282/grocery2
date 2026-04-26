import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/product_entity.dart';

class ProductImage extends StatelessWidget {
  final ProductEntity product;

  final String imageUrl;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const ProductImage({
    super.key,
    required this.product,
    required this.imageUrl,
    this.isFavorite = false,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      height: 220.h,
      width: 340.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
      child: Stack(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                      color: Colors.white,
                      strokeWidth: 2.w,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300.h,
                    color: AppColors.greyLight,
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 80,
                      color: AppColors.grey,
                    ),
                  );
                },
              ),
            ),
          ),

          // Favorite Toggle
          Positioned(
            top: 5.h,
            right: 5.w,
            child: InkWell(
              onTap: onToggleFavorite,
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: const BoxDecoration(
                  color: AppColors.greyLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? AppColors.error : AppColors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
