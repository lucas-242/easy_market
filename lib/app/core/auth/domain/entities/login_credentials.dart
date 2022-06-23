class LoginCredentials {
  final String? email;
  final String password;
  final String? phoneNumber;

  LoginCredentials({
    this.email,
    required this.password,
    this.phoneNumber,
  });

  bool get isValidEmail =>
      email != null && email!.isNotEmpty && _isAnEmail(email!);
  bool get isValidPassword => password.isNotEmpty && password.length >= 6;
  bool get isValidPhoneNumber => phoneNumber != null && phoneNumber!.isNotEmpty;

  bool _isAnEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
