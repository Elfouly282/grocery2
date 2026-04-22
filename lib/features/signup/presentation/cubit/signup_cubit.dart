import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/constants/preference_manager.dart';
import '../../../../core/constants/storage_keys.dart';
import '../../data/logic/repo/signup_repo_impl.dart';
import '../../data/models/SignupRequest.dart';
import '../../data/models/SignupResponse.dart';
import 'package:dio/dio.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepoImpl signupRepoImpl;

  SignupCubit(this.signupRepoImpl) : super(SignupInitial());


  bool isAccepted = false;


  String formatPhone(String phone) {
    if (phone.startsWith('0'))
    {
      return '+2$phone';
    }
    return phone;
  }

  void toggleAccepted(bool value) {
    isAccepted = value;
    emit(SignupInitial()); // أو state مخصوص
  }
  Future<void> signup({required SignupRequest request}) async {
    emit(SignupLoading());

    try {
      final result = await signupRepoImpl.signup(request: request);

      final token = result.data?.token;

      if (token != null) {
        await PreferenceManager().setString(StorageKeys.authToken, token);
      }
      emit(SignupSuccess(result));
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data != null && data['errors'] != null) {
        final errors = data['errors'] as Map<String, dynamic>;
        final firstError = errors.values.first[0];
        emit(SignupError(firstError));
      } else {
        emit(SignupError(data?['message'] ?? 'Server error'));
      }
    }
  }
}
