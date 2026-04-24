import 'package:flutter/material.dart';

Widget buildValidationHint(String text, bool isValid) {
  return Row(
    children: [
      Icon(
        Icons.check_circle_outline,
        size: 20,
        color: isValid ? Colors.green : Colors.blueGrey.shade300,
      ),
      const SizedBox(width: 10),
      Text(
        text,
        style: TextStyle(
          color: isValid ? Colors.black : Colors.grey.shade500,
          fontSize: 14,
        ),
      ),
    ],
  );
}
