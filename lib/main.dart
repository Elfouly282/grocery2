import 'package:flutter/material.dart';
import 'package:grocery2/core/constants/dio_helper.dart';
import 'package:grocery2/features/Forg_pass/presentation/UI/forg_pass.dart'; 
void main() {
  DioHelper.init(
    baseUrl: 'https://grocery.newcinderella.online/api',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App',
      debugShowCheckedModeBanner: false,
      home: const Splach(),
    );
    
  }
}

class Splach extends StatelessWidget {
  const Splach({super.key});

  @override
  Widget build(BuildContext context) {
    return ForgPass();
  }
}
