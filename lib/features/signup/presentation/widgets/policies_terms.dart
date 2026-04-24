import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/shared_widgets/custom_button.dart';

class CheckboxWithButton extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;
  final VoidCallback? onPressed;
  final bool isLoading;

  const CheckboxWithButton({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = isChecked && !isLoading;

    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: onChanged,
              activeColor: AppColor.primaryColor,
            ),
            const Expanded(child: Text('I agree to the policies and terms')),
          ],
        ),

        const SizedBox(height: 12),

        CustomButton(
          title: isLoading ? 'Loading...' : 'Sign Up',
          onPressed: isEnabled ? onPressed : null,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
