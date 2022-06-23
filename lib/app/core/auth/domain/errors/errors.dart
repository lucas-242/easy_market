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

abstract class AuthErrorMessages {
  static String get emailIsInvalid => 'Email is invalid';
  static String get passwordIsInvalid => 'Password is invalid';
}
