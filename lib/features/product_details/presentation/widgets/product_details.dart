import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/functions/expiry_calculator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_style.dart';
import 'detail_card_item.dart';

class ProductDetails extends StatelessWidget {
  final String includes;
  final String size;
  final DateTime expiryDate;
  final bool isExpired;
  final String title;
  final double price;
  final double? discountPrice;
  final double finalPrice;
  final bool hasOffer;
  final String? offerTitle;
  final double rating;
  final int ratingCount;

  const ProductDetails({
    super.key,
    required this.includes,
    required this.size,
    required this.expiryDate,
    required this.isExpired,
    required this.title,
    required this.price,
    this.discountPrice,
    required this.finalPrice,
    required this.hasOffer,
    this.offerTitle,
    required this.rating,
    required this.ratingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductInfo(
            title: title,
            price: price,
            finalPrice: finalPrice,
            rating: rating,
            ratingCount: ratingCount,
            hasOffer: hasOffer,
            offerTitle: offerTitle,
          ),
          SizedBox(height: 12.h),
          Text('Details', style: AppTextStyles.titleLarge),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: DetailCardItem(
                  title: 'Includes',
                  value: includes,
                  isExpired: false,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: DetailCardItem(
                  title: 'Size',
                  value: size,
                  isExpired: false,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: DetailCardItem(
                  title: 'Expiry',
                  value: ExpiryCalculator.calculateMonthsUntilExpiry(
                    expiryDate,
                  ),
                  isExpired: isExpired,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
                style: AppTextStyles.titleLarge,
              ),
            ),
            const Spacer(),
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
                      style: AppTextStyles.bodySmall.copyWith(
                        decoration: hasOffer && price != finalPrice
                            ? TextDecoration.lineThrough
                            : null,
                        color: hasOffer && price != finalPrice
                            ? AppColors.grey
                            : AppColors.primaryColor,
                        fontSize: (hasOffer && price != finalPrice)
                            ? 14.sp
                            : 20.sp,
                        fontWeight: (hasOffer && price != finalPrice)
                            ? FontWeight.normal
                            : FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                if (hasOffer && offerTitle != null)
                  Text(
                    offerTitle!,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.error,
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
