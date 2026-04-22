

import '../logic/models/model.dart';

abstract class AuthRepo {
  Future<UserModel?> login({
    required String email,
    required String password,
  });
}