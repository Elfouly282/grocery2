import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/text_style.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.width = double.infinity,
    this.height = 50,
    this.backgroundColor = AppColors.primaryColor,
    this.borderColor = AppColors.primaryColor,
    this.textColor = AppColors.white,
    this.borderRadius = 12,
    this.elevation = 0,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.textStyle,
  });

  final String text;
  final VoidCallback? onPressed;

  final bool isLoading;
  final bool isDisabled;

  final double width;
  final double height;

  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  final double borderRadius;
  final double elevation;

  final Widget? icon;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final disabled = isDisabled || isLoading || onPressed == null;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(elevation),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.grey;
            }
            return backgroundColor;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.white.withOpacity(0.6);
            }
            return textColor;
          }),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(color: borderColor),
            ),
          ),
          padding: WidgetStatePropertyAll(padding),
        ),
        child: _buildChild(),
      ),
    );
  }

  Widget _buildChild() {
    if (isLoading) {
      return SizedBox(
        height: 20.h,
        width: 20.w,
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      );
    }

    final textWidget = Text(
      text,
      style: textStyle ?? AppTextStyle.titleMedium.copyWith(color: textColor),
    );

    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          SizedBox(width: 8.w),
          textWidget,
        ],
      );
    }

    return textWidget;
  }
}
