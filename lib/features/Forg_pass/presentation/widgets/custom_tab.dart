
import 'package:flutter/material.dart';
import 'package:grocery2/core/constants/app_color.dart' show AppColor;

class CustomTab extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  const CustomTab({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
  });
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: isActive ? 180 : 100,
        height: 60,
        duration: const Duration(milliseconds: 400),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isActive ? AppColor.activetab : AppColor.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
           title,
           style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
             fontWeight: FontWeight.bold,
             fontSize: isActive ? 16 : 14,  
           ),
                      ),
        ),
      ),
    );
  }
}