import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/custom_form_field.dart';
import '../../../../core/utils/app_validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/images/rectangle.png",
                width: 402,
                height: 186,
                fit: BoxFit.fill,
              ),
            ),


            //form
            Positioned(
              top: 230,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 358,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Hug
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        //logo
                        Image.asset(
                          'assets/images/grocery.png',
                          width: 201,
                          height: 43.27,
                        ),

                        SizedBox(height: 20.h,),

                        Text(
                          "Login with email",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600, // Semi-Bold
                            color: Colors.black,
                          ),
                        ),

                        SizedBox(height: 8.h,),

                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              autofillHints: [AutofillHints.email, AutofillHints.telephoneNumber],
                              controller: _emailOrPhoneController,
                              keyboardType: TextInputType.visiblePassword,
                              validator: AppValidators.emailOrPhone,
                              hintText: 'Sarahem@gmail.com',
                              isPhoneField: true,
                              prefixIcon: Image.asset('assets/icons/email_icon.png',
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
                            // 1. Forgot Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF1B2E58),
                                  ),
                                ),
                              ),
                            ),

                            Gap(10.h),

                           // 2. Login Button
                            CustomButton(
                              title: "Login",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                }
                              },
                            ),

                            Gap(12.h),

// 3. Or Login With
                            Text(
                              "Or Login with",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                              ),
                            ),

                            Gap(12.h),

// 4. Google Login Button (Outline)
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                fixedSize: Size(double.infinity, 48.h),
                                side: const BorderSide(color: Color(0xFFE0E0E0)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/googleicon.png", height: 20.h),
                                  Gap(8.w),
                                  Text(
                                    "Login with Google",
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Gap(15.h),

// 5. Sign Up Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have any account? ",
                                  style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey),
                                ),
                                GestureDetector(
                                  onTap: () {
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1B2E58),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
                  )
                )
              )
            )
                    ]
                )
      ),
    );
  }
}

