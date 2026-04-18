import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/core/constants/app_color.dart';
import 'package:grocery2/core/constants/app_sizes.dart';
import 'package:grocery2/core/utils/text_style.dart';
import 'package:grocery2/features/product_list/data/model/meals_model.dart';
import 'package:grocery2/features/product_list/presentation/logic/product_list_cubit.dart';

class ProductItemWidget extends StatelessWidget {
  final MealsModel meal;

  const ProductItemWidget({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppSizes.r10),
        border: Border.all(color: AppColor.greyLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppSizes.r10),
                ),
                child: Image.network(
                  meal.mealImage ?? 'https://via.placeholder.com/150',
                  height: AppSizes.h100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: AppSizes.h100,
                    color: AppColor.greyLight,
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
              Positioned(
                top: AppSizes.h8,
                right: AppSizes.w8,
                child: GestureDetector(
                  onTap: () => context.read<ProductListCubit>().toggleFavorite(meal.mealId),
                  child: CircleAvatar(
                    backgroundColor: AppColor.white,
                    radius: AppSizes.r16,
                    child: Icon(
                      Icons.favorite_border,
                      size: AppSizes.sp16,
                      color: AppColor.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(AppSizes.w8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        meal.mealTitle,
                        style: AppTextStyle.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '(stock:${meal.inStock})',
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.bodySmall.copyWith(color: AppColor.grey),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.h4),
                Row(
                  children: [
                    ...List.generate(
                      5,
                      (index) => Icon(
                        index < (double.tryParse(meal.rating) ?? 0.0).floor()? Icons.star : Icons.star_border,
                        color: Colors.orange,
                        size: AppSizes.sp14,
                      ),
                    ),
                    SizedBox(width: AppSizes.w4),
                    Text(
                      '(${meal.ratingCount})',
                      style: AppTextStyle.bodySmall.copyWith(color: AppColor.grey),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.h8),
                Row(
                  children: [
                    Text(
                      '£${meal.finalPrice}',
                      style: AppTextStyle.titleLarge.copyWith(
                        color: const Color(0xFF004466),
                      ),
                    ),
                    if (meal.hasOffer) ...[
                      SizedBox(width: AppSizes.w8),
                      Text(
                        '£${meal.price}',
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColor.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: AppSizes.h8),
                SizedBox(
                  width: double.infinity,
                  height: AppSizes.h40,
                  child: ElevatedButton(
                    onPressed: () => context.read<ProductListCubit>().addToCart(meal),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004466),
                      foregroundColor: AppColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.r8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: AppSizes.h8),
                    ),
                    child: const Text('Add to cart'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
