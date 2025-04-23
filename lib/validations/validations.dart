class Validate {
  bool validateEmail(String email) {
    print(email);
    if (email.isEmpty) {
      return false;
    }
    // Regular expression pattern for email validation
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );

    return emailRegex.hasMatch(email);
  }

  bool validateMobile(String mobile) {
    // Check if the mobile number contains only digits
    if (!RegExp(r'^[0-9]+$').hasMatch(mobile)) {
      return false;
    }

    // Check if the mobile number has exactly 10 digits
    if (mobile.length > 15 && mobile.length < 10) {
      return false;
    }
    if (mobile.length != 10) {
      return false;
    }

    return true;
  }
}
