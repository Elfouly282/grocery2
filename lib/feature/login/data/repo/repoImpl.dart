import 'package:dio/dio.dart';
import 'package:grocery2/feature/login/data/repo/repo.dart';
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
        withAuth: false,
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
        "email": email,
        "password": password,
      },
    );
  }

  UserModel? get currentUser => _currentUser;
}