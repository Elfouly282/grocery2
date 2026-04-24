import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_color.dart';
import '../../data/models/categories_meals/category_meals_model.dart';

class CategoryMealListItem extends StatelessWidget {
  final Meal meal;
  final Function() ontp;
  const CategoryMealListItem({
    required this.ontp,
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontp,
      child: Container(
        width: 365.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColor.grey, width: 1),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                meal.imageUrl,
                width: 145.w,
                height: 100.h,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Text(meal.title),
                  SizedBox(
                    width: 160.w,
                    child: Text(
                      meal.features,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
