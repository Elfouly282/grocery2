import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({super.key});

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: quantity > 1 ? decrement : null,
              child: Icon(
                Icons.remove,
                size: 24.w,
                color: quantity > 1 ? AppColors.primaryColor : AppColors.grey,
              ),
            ),

            Spacer(),

            Text(
              quantity.toString(),
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),

            Spacer(),

            GestureDetector(
              onTap: increment,
              child: Icon(Icons.add, size: 24.w, color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
