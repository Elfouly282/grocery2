import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery2/features/product_details/presentation/widgets/quantity_selector.dart';

import '../../../../shared/app_button.dart';

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: QuantitySelector()),

          SizedBox(width: 12.w),

          Expanded(
            child: AppButton(
              text: 'Add to Cart',
              onPressed: () {},
              borderRadius: 10.r,
              width: 200.w,
              height: 42.h,
            ),
          ),
        ],
      ),
    );
  }
}
