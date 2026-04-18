import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../feature/subcategory/data/models/SubCategoryModel.dart';
import '../constants/app_color.dart';
import '../utils/text_style.dart';

class CategoriesHorizontalList extends StatelessWidget {
  const CategoriesHorizontalList({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<SubCategoryModel> categories;
  final int selectedIndex;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 100.w,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.greyLight.withOpacity(0.1)
                    : AppColor.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? AppColor.primaryColor
                      : AppColor.grey,
                  width: isSelected ? 1.5 : 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: category.imageUrl != null &&
                        category.imageUrl!.isNotEmpty
                        ? Image.network(
                      category.imageUrl!,
                      height: 45.h,
                      width: 63.w,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      height: 45.h,
                      width: 63.w,
                      color: Colors.grey.shade300,
                      child: Icon(
                        CupertinoIcons.photo,
                        size: 20.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    category.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.titleMedium16.copyWith(
                      color: isSelected
                          ? AppColor.primaryColor
                          : Colors.black,
                      fontWeight: isSelected
                          ? FontWeight.w800
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}