import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grocery2/core/constants/api_constant.dart';
import 'package:grocery2/core/constants/dio_helper.dart';
import 'package:grocery2/core/constants/snakbar.dart';
import 'package:grocery2/features/Forg_pass/presentation/UI/reset_pass.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  final String receiver;

  const OTPScreen({super.key, required this.receiver});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController pinController = TextEditingController();
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color(0xFF003358)),
      borderRadius: BorderRadius.circular(12),
    );
    return Scaffold(
      appBar: AppBar(title: const Text("OTP Verification"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                "Enter Digits Code",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Enter the digits code that you received to\n${widget.receiver}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 30),

              Pinput(
                controller: pinController,
                length: 6,
                showCursor: true,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                onChanged: (value) {
                  setState(() {});  
                },
                validator: (s) {
                  return null;
                },
              ),

              const SizedBox(height: 40),

              // زرار التحقق
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003358),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    // Get and trim OTP code
                    String otpCode = pinController.text.trim();
                    String identifier = widget.receiver.trim();

                    if (otpCode.isEmpty || otpCode.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please enter the complete 6-digit code",
                          ),
                        ),
                      );
                      return;
                    }

                    try {
                      // Debug logs before sending
                      print('OTP Code Length: ${otpCode.length}');
                      print('OTP Type: ${otpCode.runtimeType}');
                      print('OTP Value: "$otpCode"');
                      print('Identifier: "$identifier"');

                      // Create request body and use jsonEncode to ensure OTP stays as String
                      final requestBody = jsonEncode({
                        'identifier': identifier,
                        'otp': otpCode, // Explicitly kept as String in JSON
                      });

                      print('Request Body (JSON): $requestBody');

                      // Send request to server with explicit contentType
                      final response = await DioHelper.post(
                        path: ApiConstant.verifyOtp,
                        data: requestBody, // Send as JSON string
                      );

                      if (response.statusCode == 200) {
                        CustomSnackBar().successBar(
                          context,
                          "OTP verified successfully!",
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ResetPass( receiver: widget.receiver, otp: otpCode)),
                        );
                      }
                    } on DioException catch (dioError) {
                      // Handle Dio-specific errors
                      print('═══════════════════════════════════');
                      print('DioException occurred');
                      print('Status Code: ${dioError.response?.statusCode}');
                      print('Response Data: ${dioError.response?.data}');
                      print('Error Message: ${dioError.message}');
                      print('Exception Type: ${dioError.type}');
                      print('═══════════════════════════════════');

                      String errorMessage =
                          "Invalid OTP code, please try again";

                      if (dioError.response?.statusCode == 422) {
                        // Handle validation error (422)
                        final responseData = dioError.response?.data;
                        print(
                          'Response Data Type: ${responseData.runtimeType}',
                        );

                        if (responseData is Map) {
                          // Try to extract error from 'errors' field
                          if (responseData.containsKey('errors') &&
                              responseData['errors'] is Map &&
                              responseData['errors'].containsKey('otp')) {
                            final otpErrors = responseData['errors']['otp'];
                            if (otpErrors is List && otpErrors.isNotEmpty) {
                              errorMessage = otpErrors[0].toString();
                            }
                          } else if (responseData.containsKey('otp')) {
                            // Fallback to direct 'otp' field
                            errorMessage =
                                responseData['otp'][0] ?? errorMessage;
                          } else if (responseData.containsKey('message')) {
                            errorMessage =
                                responseData['message'] ?? errorMessage;
                          }
                          print('Extracted Error: $errorMessage');
                        }
                      } else if (dioError.response?.statusCode == 401) {
                        errorMessage = "Invalid credentials";
                      } else if (dioError.response?.statusCode == 500) {
                        errorMessage = "Server error, please try again later";
                      }

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(errorMessage)));
                    } catch (e) {
                      // Handle other errors
                      print('Unexpected Error: ${e.toString()}');
                      print('Error Type: ${e.runtimeType}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "An unexpected error occurred: ${e.toString()}",
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Verify",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () async{
                  print('alooooooooooooooooooooooooooooooooooooooooooooooo${widget.receiver}');
                  try{
                       final response = await DioHelper.post( 
                       path:  ApiConstant.sendOtp
                       , data: {
                        'identifier': widget.receiver.trim(),
                        
                        
                        
                        }
                      );
                  }
                  catch(e){
                    print('Error resending OTP: ${e.toString()}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Failed to resend OTP: ${e.toString()}"),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Didn't receive code? Resend code",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
