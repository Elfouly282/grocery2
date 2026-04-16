class SignupRequest {
  final String username;
  final String email;
  final String phone;
  final String password;
  final bool agreeTerms;

  SignupRequest({
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.agreeTerms,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "phone": phone,
      "password": password,
      "password_confirmation": password,
      "agree_terms": agreeTerms,
    };
  }
}