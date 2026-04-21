import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grocery2/add_new_list/custom_button.dart';
import 'package:grocery2/models/meal.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;
  final bool isSelected;

  const MealCard({
    super.key,
    required this.meal,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Color(0xffE3EBF0) : Color(0xffDAD8D8),
          border: isSelected
              ? Border.all(color: Color(0xff014162), width: 1)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  meal.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              meal.title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 10),

            Text(
              "${meal.price} EGP",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xff014162),
              ),
            ),
            const SizedBox(height: 10),
            CustomButton(
              color: Color(0xff014162),
              // TODO: Connect this to "Shopping Cart" Screen
              onPressed: () {},
              text: "Add to Cart",
            ),
          ],
        ),
      ),
    );
  }
}
