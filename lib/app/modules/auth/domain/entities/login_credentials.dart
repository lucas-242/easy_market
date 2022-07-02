import 'package:market_lists/app/shared/utils/credentials_validator_util.dart';

class LoginCredentials with CredentialsValidator {
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

  bool get isValidEmail => isAnEmail(email);
  bool get isValidPassword => isAPassword(password);
  bool get isValidPhoneNumber => isAPhone(phone);
  bool get isValidCode => code.isNotEmpty;
  bool get isValidVerificationId => verificationId.isNotEmpty;
}
