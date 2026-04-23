
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/repo.dart';
import 'login_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitialState());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingState());

    try {
      final user = await authRepo.login(
        email: email,
        password: password,
      );

      if (user != null) {
        emit(AuthSuccessState(user));
      } else {
        emit(AuthErrorState("UnExpected Error Please, try again"));
      }
    } catch (e) {
      
      emit(AuthErrorState(e.toString()));
    }
  }
}