import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/utils/text_style.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Left
          Row(
            children: [
              Image.asset(
                'assets/icons/app_bar_logo.png',
                height: 24.h,
              ),
              SizedBox(width: 10.w),
              Image.asset(
                'assets/icons/notification.png',
                height: 22.h,
              ),
            ],
          ),

          /// Location
          Container(
            height: 20.h,
            width: 170.w,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: AppColor.grey, width: 1),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/map_point.png',
                  height: 16.h,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    'Villa 14, Street 23, District 5',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColor.grey,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Image.asset(
                  'assets/icons/down_arrow.png',
                  height: 14.h,
                ),
              ],
            ),
          ),

          /// Cart
          Image.asset(
            'assets/icons/cart_icon.png',
            height: 24.h,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}