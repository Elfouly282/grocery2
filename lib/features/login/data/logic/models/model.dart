class UserModel {
  final int id;
  final String username;
  final String email;
  final String phone;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      username: json['username']?.toString() ?? "",
      email: json['email']?.toString() ?? "",
      phone: json['phone']?.toString() ?? "",
    );
  }
}
