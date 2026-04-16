class AppValidators {


  static String? required(String? value,
      {String message = 'This field is required'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }


  static String? emailOrPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Field is required';
    }
    final input = value.trim();
    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    final phoneRegex = RegExp(
      r'^(\+20|0)?1[0-5][0-9]{8}$',
    );
    if (emailRegex.hasMatch(input)) return null;
    if (phoneRegex.hasMatch(input)) return null;

    return 'Enter valid email or phone';
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