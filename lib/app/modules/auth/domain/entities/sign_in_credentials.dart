import 'package:market_lists/app/modules/auth/domain/entities/credentials_validator.dart';

class SignInCredentials {
  final String email;
  final String password;
  final String phone;
  final String code;
  final String verificationId;

  SignInCredentials._({
    this.email = '',
    this.password = '',
    this.phone = '',
    this.code = '',
    this.verificationId = '',
  });

  factory SignInCredentials.withEmailAndPassword(
      {required String email, required String password}) {
    return SignInCredentials._(
      email: email,
      password: password,
    );
  }

  factory SignInCredentials.withPhone({required String phone}) {
    return SignInCredentials._(phone: phone);
  }

  factory SignInCredentials.withVerificationCode(
      {required String code, required String verificationId}) {
    return SignInCredentials._(
      code: code,
      verificationId: verificationId,
    );
  }

  bool get isValidEmail => CredentialsValidator.isAnEmail(email);
  bool get isValidPassword => CredentialsValidator.isAPassword(password);
  bool get isValidPhoneNumber => CredentialsValidator.isAPhone(phone);
  bool get isValidCode => code.isNotEmpty;
  bool get isValidVerificationId => verificationId.isNotEmpty;
}
