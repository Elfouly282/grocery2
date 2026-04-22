import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_color.dart';
import '../utils/text_style.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  final String? hintText;

  final double borderRadius;

  final bool isPassword;
  final bool isPhoneField;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;

  final String? errorText;
  final Function(String)? onChanged;

  final List<String>? autofillHints;

  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
     this.validator,
    this.hintText,
    this.borderRadius = 8,
    this.isPassword = false,
    this.isPhoneField = false,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.errorText,
    this.onChanged,
    this.autofillHints,
    this.inputFormatters,
  });
  @override
  State<CustomTextFormField> createState() =>
      _CustomTextFormFieldState();
}
class _CustomTextFormFieldState
    extends State<CustomTextFormField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatters,
      cursorHeight: 15,
      cursorColor: AppColor.primaryColor,
      autofillHints: widget.autofillHints,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      obscureText: widget.isPassword ? isObscure : false,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyle.bodyMedium.copyWith(
          color: AppColor.grey,
        ),
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon,
        prefixText: widget.prefixText,
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            isObscure
                ? CupertinoIcons.eye_slash_fill
                : Icons.visibility_outlined,
          ),
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
        )
            : widget.suffixIcon,
        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(widget.borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: AppColor.primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: AppColor.grey,
          ),
        ),
      ),
    );
  }
}