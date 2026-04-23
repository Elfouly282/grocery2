import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_color.dart';

class CategoriesVerticalListSkeleton extends StatelessWidget {
  const CategoriesVerticalListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 365.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColor.grey, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 145.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),

          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120.w,
                    height: 14.h,
                    color: Colors.grey.shade300,
                  ),

                  SizedBox(height: 8.h),

                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: Colors.grey.shade300,
                  ),

                  SizedBox(height: 6.h),

                  Container(
                    width: 160.w,
                    height: 12.h,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}