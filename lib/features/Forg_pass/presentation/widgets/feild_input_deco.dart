import 'package:flutter/material.dart';

InputDecoration buildInputDecoration({
  required String hint,
  bool isPassword = false,
  bool isVisible = false,
  VoidCallback? onToggle,
}) {
  return InputDecoration(
    prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
    suffixIcon: isPassword
        ? IconButton(
            icon: Icon(
              isVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Colors.grey,
            ),
            onPressed: onToggle,
          )
        : null,
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.grey),
    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF003358), width: 1.5),
    ),
  );
}
