class User {
  final int? id;
  final String? username;
  final String? email;
  final String? phone;
  final String? createdAt;

  User({this.id, this.username, this.email, this.phone, this.createdAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['di'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      createdAt: json['created_at'],
    );
  }
}
