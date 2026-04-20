import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isSuccess;
  final bool isMasked;
  final bool isLast;

  const DetailRow({super.key,
    required this.label,
    required this.value,
    this.isSuccess = false,
    this.isMasked = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isLast
          ? null
          : const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE8EDF2), width: 0.5)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF666666))),
          Text(
            value,
            style: TextStyle(
              fontSize: isMasked ? 12 : 13,
              fontWeight: FontWeight.w500,
              color: isSuccess
                  ? const Color(0xFF1C6B2E)
                  : isMasked
                  ? const Color(0xFF888888)
                  : const Color(0xFF1A1A1A),
              letterSpacing: isMasked ? 2 : 0,
            ),
          ),
        ],
      ),
    );
  }
}