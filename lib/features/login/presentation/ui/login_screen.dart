import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                      const Gap(32),

                      Text(
                        "Login with email",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600, // Semi-Bold
                          color: Colors.black,
                        ),
                      ),

                      const Gap(8),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

