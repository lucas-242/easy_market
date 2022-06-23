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
