import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grocery2/core/constants/api_constant.dart';
import 'package:grocery2/core/constants/dio_helper.dart';
import 'package:grocery2/core/constants/snakbar.dart';
import 'package:grocery2/features/Forg_pass/presentation/widgets/feild_input_deco.dart';
import 'package:grocery2/features/Forg_pass/presentation/widgets/show_dialog.dart';
import 'package:grocery2/features/Forg_pass/presentation/widgets/validation.dart';

class ResetPass extends StatefulWidget {
  final String receiver;
  final String otp;
  const ResetPass({super.key, required this.receiver, required this.otp});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isObscure = true;
  bool isConfirmObscure = true;

  bool hasEightCharacters = false;
  bool hasNumber = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Reset Password",
          style: TextStyle(color: Color(0xFF003358)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Create New Password",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003358),
                  ),
                ),
                const SizedBox(height: 30),

                // New Password Field
                const Text(
                  'New Password',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: newPasswordController,
                  obscureText: isObscure,
                  onChanged: (value) {
                    setState(() {
                      hasEightCharacters = value.length >= 8;
                      hasNumber = value.contains(RegExp(r'[0-9]'));
                    });
                  },
                  decoration: buildInputDecoration(
                    hint: "************",
                    isPassword: true,
                    isVisible: !isObscure,
                    onToggle: () => setState(() => isObscure = !isObscure),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Confirm Password',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: isConfirmObscure,
                  decoration: buildInputDecoration(
                    hint: "************",
                    isPassword: true,
                    isVisible: !isConfirmObscure,
                    onToggle: () =>
                        setState(() => isConfirmObscure = !isConfirmObscure),
                  ),
                ),

                const SizedBox(height: 20),

                buildValidationHint(
                  "Must be at least 8 characters",
                  hasEightCharacters,
                ),
                const SizedBox(height: 10),
                buildValidationHint("Contains a number", hasNumber),

                const SizedBox(height: 40),

                // Reset Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003358),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                           final Response response = await DioHelper.post(
                            path: ApiConstant.resetPassword,
                            data: {
                              'identifier': widget.receiver.trim(),
                              'otp': widget.otp.trim(),
                              'password': newPasswordController.text.trim(),
                               'password_confirmation': confirmPasswordController
                                  .text
                                  .trim(),
                            },
                          );

                          if (response.statusCode == 200) {
                            CustomSnackBar().successBar(
                              context,
                              "Password reset successfully",
                            );
                           showSuccessBottomSheet(context);
                          }
                        }     
                        catch (e) {
                           print("Reset Error: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Error: Check your connection or password rules",
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Reset",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
