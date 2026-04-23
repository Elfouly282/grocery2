
import '../logic/models/model.dart';

abstract class AuthRepo {
  Future<UserModel?> login({
    required String email,
    required String password,
  });
  
  bool isLoggedIn();
  
  UserModel? getStoredUser();
  
  Future<void> logout();
}