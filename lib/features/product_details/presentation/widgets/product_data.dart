import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_style.dart';

class ProductInfo extends StatelessWidget {
  final String title;
  final double price;
  final double finalPrice;
  final bool hasOffer;
  final String? offerTitle;
  final double rating;
  final int ratingCount;

  const ProductInfo({
    super.key,
    required this.title,
    required this.price,
    required this.finalPrice,
    required this.hasOffer,
    this.offerTitle,
    required this.rating,
    required this.ratingCount,
  });

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final hasHalfStar = (rating - fullStars) >= 0.5;
    final emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.titleLarge,
              ),
            ),

            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (hasOffer && price != finalPrice)
                      Text(
                        '£${finalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),

                    if (hasOffer && price != finalPrice) SizedBox(width: 6.w),

                    Text(
                      '£${price.toStringAsFixed(2)}',
                      style: AppTextStyle.bodySmall.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),

                if (hasOffer && offerTitle != null)
                  Text(
                    offerTitle!,
                    style: AppTextStyle.titleMedium.copyWith(
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ],
        ),

        Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(
                  fullStars,
                  (index) => Icon(Icons.star, size: 18.w, color: Colors.amber),
                ),
                if (hasHalfStar)
                  Icon(Icons.star_half, size: 18.w, color: Colors.amber),
                ...List.generate(
                  emptyStars,
                  (index) =>
                      Icon(Icons.star_border, size: 18.w, color: Colors.amber),
                ),
              ],
            ),

            SizedBox(width: 8.w),

            Text(
              '($ratingCount)',
              style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
