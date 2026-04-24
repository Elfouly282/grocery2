import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/snakbar.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/shared_widgets/custom_form_field.dart';
import '../../../../core/utils/app_validation.dart';
import '../../../../core/utils/text_style.dart';
import '../../data/models/SignupRequest.dart';
import '../cubit/signup_cubit.dart';
import '../widgets/policies_terms.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (_) => getIt<SignupCubit>(),
        child: BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              CustomSnackBar().successBar(
                context,
                state.response.message ?? 'Signup success',
              );
            } else if (state is SignupError) {
              CustomSnackBar().errorBar(context, state.message);
            }
          },
          child: Scaffold(
            backgroundColor: AppColor.white,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/rectangleHeaderAuth.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: 24.h),
                              Image.asset(
                                'assets/images/grocery.png',
                                height: 44.h,
                                width: 201.w,
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                'Create your Account',
                                style: AppTextStyle.titleMedium,
                              ),
                              Text(
                                'Just a few things to get started',
                                style: AppTextStyle.bodyMedium,
                              ),
                              SizedBox(height: 22.h),
                              CustomTextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: AppValidators.email,
                                hintText: 'Email',
                                prefixIcon: Image.asset(
                                  'assets/icons/email_icon.png',
                                  height: 24.h,
                                  width: 24.w,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              CustomTextFormField(
                                controller: _phoneController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(11),
                                ],
                                keyboardType: TextInputType.phone,
                                validator: AppValidators.phone,
                                hintText: 'Phone Number',
                                isPhoneField: true,
                                prefixIcon: Image.asset(
                                  'assets/icons/phone.png',
                                  height: 24.h,
                                  width: 24.w,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              CustomTextFormField(
                                controller: _nameController,
                                validator: AppValidators.username,
                                hintText: 'User Name',
                                prefixIcon: Image.asset(
                                  'assets/icons/user_icon.png',
                                  height: 24.h,
                                  width: 24.w,
                                ),
                                keyboardType: TextInputType.text,
                              ),
                              SizedBox(height: 8.h),
                              CustomTextFormField(
                                controller: _passwordController,
                                validator: AppValidators.password,
                                hintText: 'Password',
                                isPassword: true,
                                prefixIcon: Image.asset(
                                  'assets/icons/lock.png',
                                  height: 24.h,
                                  width: 24.w,
                                ),
                                keyboardType: TextInputType.visiblePassword,
                              ),
                              SizedBox(height: 8.h),
                              CustomTextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: _confirmPasswordController,
                                validator: (value) =>
                                    AppValidators.confirmPassword(
                                      value,
                                      _passwordController.text,
                                    ),
                                hintText: 'Confirm Password',
                                isPassword: true,
                                prefixIcon: Image.asset(
                                  'assets/icons/lock.png',
                                  height: 24.h,
                                  width: 24.w,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                                  final cubit = context.read<SignupCubit>();

                                  final isLoading = state is SignupLoading;
                                  return CheckboxWithButton(
                                    isChecked: cubit.isAccepted,
                                    isLoading: isLoading,
                                    onChanged: (value) {
                                      cubit.toggleAccepted(value ?? false);
                                    },
                                    onPressed: () {
                                      if (!_formKey.currentState!.validate())
                                        return;

                                      if (!cubit.isAccepted) {
                                        CustomSnackBar().errorBar(
                                          context,
                                          'Please accept terms',
                                        );
                                        return;
                                      }

                                      cubit.signup(
                                        request: SignupRequest(
                                          username: _nameController.text,
                                          email: _emailController.text,
                                          phone: cubit.formatPhone(
                                            _phoneController.text,
                                          ),
                                          password: _passwordController.text,
                                          agreeTerms: cubit.isAccepted,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account?',
                                    style: AppTextStyle.bodyMedium,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Login',
                                      style: AppTextStyle.bodyMedium.copyWith(
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
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
        ),
      ),
    );
  }
}
