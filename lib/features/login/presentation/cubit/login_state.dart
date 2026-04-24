import '../../data/logic/models/model.dart';

sealed class AuthStates {}

final class AuthInitialState extends AuthStates {}

final class AuthLoadingState extends AuthStates {}

final class AuthSuccessState extends AuthStates {
  final UserModel user;
  AuthSuccessState(this.user);
}

final class AuthErrorState extends AuthStates {
  final String message;
  AuthErrorState(this.message);
}
