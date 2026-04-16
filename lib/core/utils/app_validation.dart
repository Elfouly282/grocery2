class AppValidators {


  static String? required(String? value,
      {String message = 'This field is required'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter valid email';
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone is required';
    }

    final phoneRegex = RegExp(
      r'^(\+20|0)?1[0-5][0-9]{8}$',
    );

    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Enter valid phone number';
    }

    return null;
  }



  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 12) {
      return 'At least 12 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Add uppercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Add a number';
    }

    return null;
  }


  static String? confirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Confirm your password';
    }
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }


  static String? minLength(String? value, int min) {
    if (value == null || value.length < min) {
      return 'Must be at least $min characters';
    }
    return null;
  }


}