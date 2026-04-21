import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery2/features/product_details/presentation/widgets/product_data.dart';

import '../../../../core/functions/expiry_calculator.dart';
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

          Text(
            'Details',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

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
