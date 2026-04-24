import 'package:flutter/material.dart';
import 'package:grocery2/core/constants/app_color.dart';
import 'package:grocery2/core/constants/dio_helper.dart' show DioHelper;
import 'package:grocery2/core/constants/snakbar.dart';
import 'package:grocery2/features/Forg_pass/presentation/UI/verify_otp.dart';
import 'package:grocery2/features/Forg_pass/presentation/widgets/custom_tab.dart';

class ForgPass extends StatefulWidget {
  const ForgPass({super.key});

  @override
  State<ForgPass> createState() => _ForgPassState();
}

class _ForgPassState extends State<ForgPass> {
  bool isEmailTabActive = true;
  final form_key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String get inputmethod =>
      isEmailTabActive ? emailController.text : phoneController.text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTab(
                        title: "By Email",
                        isActive: isEmailTabActive,
                        onTap: () {
                          setState(() {
                            FocusScope.of(context).unfocus();
                            isEmailTabActive = true;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomTab(
                        title: "By Phone number",
                        isActive: !isEmailTabActive,
                        onTap: () {
                          setState(() {
                            isEmailTabActive = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  isEmailTabActive
                      ? "Enter the email associated with your account."
                      : "Enter the phone number associated with your account.",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Text(
                isEmailTabActive ? 'Email' : 'Phone Number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                key: ValueKey(isEmailTabActive ? 'email' : 'phone'),
                controller: isEmailTabActive
                    ? emailController
                    : phoneController,
                decoration: InputDecoration(
                  hintText: isEmailTabActive
                      ? 'Sarahem@gmail.com'
                      : '+20 1163982057',
                  prefixIcon: isEmailTabActive
                      ? Icon(Icons.email_outlined, color: Colors.grey[400])
                      : Icon(Icons.phone_outlined, color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColor.primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                keyboardType: isEmailTabActive
                    ? TextInputType.emailAddress
                    : TextInputType.phone,
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  // Handle send reset link action
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColor.activetab,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GestureDetector(
                    // onTap: () async {
                    //   // جوه الـ OnPressed بتاع زرار "Send Code"
                    //   try {
                    //     final response = await DioHelper.post(
                    //       path: '/api/auth/forgot-password',
                    //       data: {
                    //         'identifier': emailController .text,
                    //           // الإيميل اللي المستخدم كتبه
                    //       },
                    //     );

                    //     if (response.statusCode == 200) {
                    //       // لو الطلب نجح، انقل المستخدم لشاشة الـ OTP
                    //       // وممكن تبعت الإيميل معاك عشان تحتاجه في الشاشة الجاية
                    //       Navigator.push(context, MaterialPageRoute(builder: (context){
                    //         return OTPScreen(receiver: '');
                    //       }));
                    //      }
                    //   } catch (e) {
                    //     // اظهر رسالة خطأ للمستخدم (مثلاً الإيميل مش موجود)
                    //     print(e.toString());
                    //   }
                    // },
                    onTap: () async {
                      // 1. جمع القيمة بناءً على التاب النشط
                      String valueToSend = isEmailTabActive
                          ? emailController.text
                          : phoneController.text;

                      // 2. التأكد إن الحقل مش فاضي قبل ما نبعت (Validation بسيط)
                      if (valueToSend.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isEmailTabActive
                                  ? "Please enter your email"
                                  : "Please enter your phone number",
                            ),
                          ),
                        );
                        return;
                      }

                      try {
                        final response = await DioHelper.post(
                          path: '/auth/forgot-password',
                          data: {'identifier': valueToSend},
                        );

                        if (response.statusCode == 200) {
                          CustomSnackBar().successBar(
                            context,
                            "OTP sent successfully!",
                          );
                          await Future.delayed(Duration(milliseconds: 200));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return OTPScreen(receiver: valueToSend);
                              },
                            ),
                          );
                        }
                      } catch (e) {
                        // إظهار رسالة الخطأ اللي جاية من السيرفر
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Error: User not found or invalid data",
                            ),
                          ),
                        );
                        print(e.toString());
                      }
                    },
                    child: const Center(
                      child: Text(
                        "Send Code",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
