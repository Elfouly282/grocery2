import 'User.dart';

class SignupResponse {
  final bool? success;
  final String? message;
  final SignupData? data;

  SignupResponse({
    this.success,
    this.message,
    this.data,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? SignupData.fromJson(json['data'])
          : null,
    );
  }
}

class SignupData {
  final User? user;
  final String? token;

  SignupData({
    this.user,
    this.token,
  });

  factory SignupData.fromJson(Map<String, dynamic> json) {
    return SignupData(
      user: json['user'] != null
          ? User.fromJson(json['user'])
          : null,
      token: json['token'],
    );
  }
}