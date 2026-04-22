import 'package:flutter/material.dart';
import 'package:grocery2/features/splach/presentation/UI/Splach.dart';
 
 
 
void main() async{
  
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
      home: const SplashView(),
    );
  }
} 
 
 
