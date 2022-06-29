class LoginCredentials {
  final String email;
  final String password;
  final String phone;
  final String code;
  final String verificationId;

  LoginCredentials._({
    this.email = '',
    this.password = '',
    this.phone = '',
    this.code = '',
    this.verificationId = '',
  });

  factory LoginCredentials.withEmailAndPassword(
      {required String email, required String password}) {
    return LoginCredentials._(
      email: email,
      password: password,
    );
  }

  factory LoginCredentials.withPhone({required String phone}) {
    return LoginCredentials._(phone: phone);
  }

  factory LoginCredentials.withVerificationCode(
      {required String code, required String verificationId}) {
    return LoginCredentials._(
      code: code,
      verificationId: verificationId,
    );
  }

  bool get isValidEmail => _isAnEmail();
  bool get isValidPassword => password.isNotEmpty && password.length >= 6;
  bool get isValidPhoneNumber => _isAPhone();
  bool get isValidCode => code.isNotEmpty;
  bool get isValidVerificationId => verificationId.isNotEmpty;

  bool _isAnEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  bool _isAPhone() {
    return RegExp(r'^\(?[1-9]{2}\)? ?[9] ?[0-9]{4}\-?[0-9]{4}$')
        .hasMatch(phone);
  }
}
