import 'package:flutter/material.dart';

import 'grocery_app.dart';
import 'core/constants/dio_helper.dart';
import 'core/constants/api_constant.dart';

void main() {
  // Initialize Dio before any network requests
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  runApp(GroceryApp());
}
