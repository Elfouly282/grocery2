
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return     Container(
      height: 42.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 22.sp, color: Colors.blueGrey),
          SizedBox(width: 10.w),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for any Product',
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Icon(Icons.qr_code_scanner,
              size: 22.sp, color: Colors.blueGrey),
          SizedBox(width: 10.w),
          Icon(Icons.mic_none, size: 22.sp, color: Colors.blueGrey),
        ],
      ),
    );

  }
}








