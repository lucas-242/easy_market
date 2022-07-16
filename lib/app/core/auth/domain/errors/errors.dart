import 'package:easy_market/app/core/errors/errors.dart';

class GetCurrentUserFailure extends Failure {
  @override
  final String message;

  GetCurrentUserFailure(this.message);
}

class SignOutFailure extends Failure {
  @override
  final String message;

  SignOutFailure(this.message);
}

class SignInWithEmailFailure extends Failure {
  @override
  final String message;

  SignInWithEmailFailure(this.message);
}

class SignInWithPhoneFailure extends Failure {
  @override
  final String message;

  SignInWithPhoneFailure(this.message);
}

class SignUpFailure extends Failure {
  @override
  final String message;

  SignUpFailure(this.message);
}

class ResetPasswordFailure extends Failure {
  @override
  final String message;

  ResetPasswordFailure(this.message);
}

abstract class AuthErrorMessages {
  static String get emailIsInvalid => 'Email is invalid';
  static String get passwordIsInvalid => 'Password is invalid';
  static String get phoneIsInvalid => 'Phone is invalid';
  static String get codeIsInvalid => 'Code is invalid';
  static String get verificationIdIsInvalid => 'VerificationId is invalid';
}
