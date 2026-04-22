import 'package:flutter/material.dart';

import 'grocery_app.dart';
import 'core/constants/dio_helper.dart';
import 'core/constants/api_constant.dart';
import 'core/di/service_locator.dart';

void main() async {
  // Initialize Dio before any network requests
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  
  // Initialize service locator
  await setupServiceLocator();
  
  runApp(const GroceryApp());
}
