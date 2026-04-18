import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = '',
    this.isVisible = false,
  });

  final String title;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Image.asset('assets/icons/back_arrow.png'),
      title: Visibility(
        visible: isVisible,
        child: Text(title),
      ),
      centerTitle: true,
      actions: [
        Image.asset(
          'assets/icons/search.png',
          color: AppColor.black,
        ),
        SizedBox(width: 18.w),
        Image.asset('assets/icons/cart.png'),
        SizedBox(width: 16.w),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}