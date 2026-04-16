import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/snakbar.dart';
import '../../../../core/shared_widgets/custom_form_field.dart';
import '../../../../core/utils/app_validation.dart';
import '../../../../core/utils/text_style.dart';
import '../widgets/policies_terms.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.primaryLight,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/images/rectangleHeaderAuth.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 44.h,),
                          Image.asset('assets/images/Group 25.png', height: 44.h, width: 201.w,),
                          SizedBox(height: 20.h,),
                          Text('Create your Account', style: AppTextStyle.titleMedium,),
                          Text('Just a few things to get started', style: AppTextStyle.bodyMedium,),
                          SizedBox(height: 32.h,),
                          CustomTextFormField(
                            autofillHints: [AutofillHints.email, AutofillHints.telephoneNumber],
                            controller: _emailOrPhoneController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: AppValidators.emailOrPhone,
                            hintText: 'Email or Phone Number',
                            isPhoneField: true,
                            prefixIcon: Image.asset('assets/icons/email_icon.png',
                            height: 24.h,
                            width: 24.w,
                            ),
                          ),
                          SizedBox(height: 8.h,),
                          CustomTextFormField(
                            autofillHints: [AutofillHints.name],
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              final required = AppValidators.required(value);
                              if (required != null) return required;
                              return AppValidators.minLength(value, 5);
                            },
                            hintText: 'User Name',
                            isPassword: false,
                            isPhoneField: false,
                            prefixIcon: Image.asset('assets/icons/user_icon.png',
                            height: 24.h,
                            width: 24.w,
                            ),
                          ),
                          SizedBox(height: 8.h,),
                          CustomTextFormField(
                            autofillHints: [AutofillHints.newPassword],
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: AppValidators.password,
                            hintText: 'password',
                            isPassword: true,
                            isPhoneField: false,
                            prefixIcon: Image.asset('assets/icons/lock.png',
                            height: 24.h,
                            width: 24.w,
                            ),
                          ),
                          SizedBox(height: 8.h,),
                          CustomTextFormField(
                            autofillHints: [AutofillHints.newPassword],
                            controller: _confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) => AppValidators.confirmPassword(
                              value,
                              _passwordController.text,
                            ),
                            hintText: 'Confirm Password',
                            isPassword: true,
                            isPhoneField: false,
                            prefixIcon: Image.asset('assets/icons/lock.png',
                            height: 24.h,
                            width: 24.w,
                            ),
                          ),
                          CheckboxWithButton(
                            isChecked: isAccepted,
                            onChanged: (value) {
                              setState(() {
                                isAccepted = value ?? false;
                              });
                            },
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) return;
                              CustomSnackBar().successBar(context, 'Signup success');
                            },
                          ),
                          SizedBox(height: 20.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account?',
                              style: AppTextStyle.bodyMedium,
                              ),
                              TextButton(
                                onPressed: (){},
                                child: Text('Login',
                                style: AppTextStyle.bodyMedium.copyWith(
                                  color: AppColor.primaryColor,
                                ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
