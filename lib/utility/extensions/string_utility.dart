extension StringUtility on String {
  bool get isValidEmail {
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final email = this;
    final regex = RegExp(pattern);
    return regex.hasMatch(email.trim());
  }

  bool get isValidPhone {
    const pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final phone = this;
    final regex = RegExp(pattern);
    return regex.hasMatch(phone.trim());
  }

  String get capitalize {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
