

import 'package:flutter/material.dart';

Widget customListTile(
    {required BuildContext context,
    required Icon icon,
    required Text title,
    required Function() onTap}) {
  return ListTile(
    onTap: onTap,
    leading: suffixIcon(context: context, icon: icon),
    title: title,
  );
}

Widget suffixIcon({required BuildContext context, required Icon icon}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final bgColor = isDark ? Colors.grey.shade800 : const Color(0xFFEBEBF2);

  return CircleAvatar(
    radius: 23,
    backgroundColor: bgColor,
    child: icon,
  );
}