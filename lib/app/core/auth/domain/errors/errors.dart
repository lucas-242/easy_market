import 'package:market_lists/app/core/errors/errors.dart';

class GetLoggedUserFailure extends Failure {
  @override
  final String message;

  GetLoggedUserFailure(this.message);
}

class LogoutFailure extends Failure {
  @override
  final String message;

  LogoutFailure(this.message);
}

class LoginByEmailFailure extends Failure {
  @override
  final String message;

  LoginByEmailFailure(this.message);
}

class LoginByPhoneFailure extends Failure {
  @override
  final String message;

  LoginByPhoneFailure(this.message);
}

abstract class AuthErrorMessages {
  static String get emailIsInvalid => 'Email is invalid';
  static String get passwordIsInvalid => 'Password is invalid';
  static String get phoneIsInvalid => 'Phone is invalid';
  static String get codeIsInvalid => 'Code is invalid';
  static String get verificationIdIsInvalid => 'VerificationId is invalid';
}
