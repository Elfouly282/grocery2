class ProfileModel {
  final int id;
  final String? name;
  final String username;
  final String? firstName;
  final String? lastName;
  final String email;
  final String phone;
  final String? countryCode;
  final bool emailVerified;
  final bool phoneVerified;
  final String? imageUrl;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.countryCode,
    required this.emailVerified,
    required this.phoneVerified,
    this.imageUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    String? readNullableString(String key) {
      final value = json[key];
      if (value == null) return null;

      final normalized = value.toString().trim();
      return normalized.isEmpty ? null : normalized;
    }

    return ProfileModel(
      id: int.tryParse((json['id'] ?? 0).toString()) ?? 0,
      name: readNullableString('name'),
      username: readNullableString('username') ?? '',
      firstName: readNullableString('firstname'),
      lastName: readNullableString('lastname'),
      email: readNullableString('email') ?? '',
      phone: readNullableString('phone') ?? '',
      countryCode: readNullableString('country_code'),
      emailVerified: json['email_verified'] == true,
      phoneVerified: json['phone_verified'] == true,
      imageUrl: readNullableString('profile_picture'),
    );
  }

  String get displayName {
    if (name case final currentName? when currentName.isNotEmpty) {
      return currentName;
    }

    final fullName = [firstName, lastName]
        .whereType<String>()
        .where((part) => part.trim().isNotEmpty)
        .map((part) => part.trim())
        .join(' ');

    if (fullName.isNotEmpty) {
      return fullName;
    }

    if (username.isNotEmpty) {
      return username;
    }

    return 'Guest User';
  }

  ProfileModel copyWith({
    int? id,
    String? name,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? countryCode,
    bool? emailVerified,
    bool? phoneVerified,
    String? imageUrl,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      countryCode: countryCode ?? this.countryCode,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
