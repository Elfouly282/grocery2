
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/core/constants/preference_manager.dart';
import '../../data/repo/repo.dart';
import 'login_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo;
  final PreferenceManager preferenceManager;

  AuthCubit(this.authRepo, {required this.preferenceManager}) : super(AuthInitialState());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingState());

    try {
      final user = await authRepo.login(
        email: email,
        password: password,
      );

      if (user != null) {
        // Save the login status to SharedPreferences
        await preferenceManager.setBool('isLoggedIn', true);
        emit(AuthSuccessState(user));
      } else {
        emit(AuthErrorState("UnExpected Error Please, try again"));
      }
    } catch (e) {
      
      emit(AuthErrorState(e.toString()));
    }
  }

  /// Logout method to clear user session
  Future<void> logout() async {
    try {
      // Clear the login status
      await preferenceManager.setBool('isLoggedIn', false);
      // Clear the authentication token
      await preferenceManager.remove('token');
      emit(AuthInitialState());
    } catch (e) {
      emit(AuthErrorState("Logout failed: ${e.toString()}"));
    }
  }
}