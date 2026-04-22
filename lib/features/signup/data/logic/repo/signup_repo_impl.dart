import '../../../../../core/constants/api_constant.dart';
import '../../../../../core/constants/dio_helper.dart';
import '../../models/SignupRequest.dart';
import '../../models/SignupResponse.dart';
import 'package:dio/dio.dart';

class SignupRepoImpl {
  Future<SignupResponse> signup({
    required SignupRequest request,
  }) async {
    try {
      final response = await DioHelper.post(
        path: ApiConstant.signup,
        data: request.toJson(),
      );

      return SignupResponse.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    }
  }
}