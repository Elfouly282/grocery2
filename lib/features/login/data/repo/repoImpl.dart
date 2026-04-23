import 'dart:convert';
import 'package:grocery2/features/login/data/repo/repo.dart';
import '../../../../core/constants/dio_helper.dart';
import '../../../../core/constants/preference_manager.dart';
import '../../../../core/constants/api_constant.dart';
import '../logic/models/model.dart';

class AuthRepoImpl implements AuthRepo {
  final PreferenceManager preferenceManager;

  AuthRepoImpl({required this.preferenceManager});

  UserModel? _currentUser;

  Future<UserModel?> _auth(String endPoint, Map<String, dynamic> body) async {
    try {
       final response = await DioHelper.post(
        path: endPoint,
        data: body,
         
      );
     


      if (response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        bool success = responseData['success'] ?? false;
        String message = responseData['message'] ?? "Error occurred";

        if (!success) {
          throw message;
        }

        final data = responseData['data'];
        final userData = UserModel.fromJson(data['user']);
        final String? token = data['token'];

        if (token != null) {
          await preferenceManager.setString('token', token);
          // Save user data as JSON for persistence
          await preferenceManager.setString('user_data', jsonEncode({
            'id': userData.id,
            'username': userData.username,
            'email': userData.email,
            'phone': userData.phone,
          }));
          await preferenceManager.setBool('is_logged_in', true);
        }

        _currentUser = userData;
        return userData;
      } else {

        throw "Unexpected response format";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
     return _auth(
      ApiConstant.login,
      {
        "login": email,
        "password": password,
      },
    );
   }

  // Check if user is already logged in
  bool isLoggedIn() {
    final isLogged = preferenceManager.getBool('is_logged_in') ?? false;
    return isLogged && preferenceManager.getString('token') != null;
  }

  // Get stored user data
  UserModel? getStoredUser() {
    try {
      final userJsonString = preferenceManager.getString('user_data');
      if (userJsonString != null) {
        final userJson = jsonDecode(userJsonString);
        _currentUser = UserModel.fromJson(userJson);
        return _currentUser;
      }
    } catch (e) {
      print('Error restoring user: $e');
    }
    return null;
  }

  // Logout function
  Future<void> logout() async {
    await preferenceManager.remove('token');
    await preferenceManager.remove('user_data');
    await preferenceManager.setBool('is_logged_in', false);
    _currentUser = null;
  }

  UserModel? get currentUser => _currentUser;
}