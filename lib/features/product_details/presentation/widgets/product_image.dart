import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const ProductImage({
    super.key,
    required this.imageUrl,
    this.isFavorite = false,
    this.onFavoriteTap,
  });

  /// Check if the image URL is valid and not empty
  bool _isValidImageUrl() {
    return imageUrl.isNotEmpty &&
        (imageUrl.startsWith('http://') || imageUrl.startsWith('https://'));
  }

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
              child: _isValidImageUrl()
                  ? Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                      cacheHeight: 400,
                      cacheWidth: 400,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: AppColors.greyLight,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                              color: AppColors.primaryColor,
                              strokeWidth: 2.w,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: AppColors.greyLight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported_outlined,
                                size: 60.w,
                                color: AppColors.grey,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Image not available',
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : _buildPlaceholder(),
            ),
          ),

          // Favorite Toggle
          Positioned(
            top: 5.h,
            right: 5.w,
            child: GestureDetector(
              onTap: onFavoriteTap,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8.r,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : AppColors.grey,
                  size: 22.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build a placeholder when image URL is not valid
  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.greyLight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, size: 60.w, color: AppColors.grey),
          SizedBox(height: 8.h),
          Text(
            'No image provided',
            style: TextStyle(color: AppColors.grey, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
