import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/core/errors/errors.dart';
import 'package:market_lists/app/modules/auth/domain/entities/reset_password_credentials.dart';
import 'package:market_lists/app/modules/auth/domain/errors/errors.dart';
import 'package:market_lists/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class ConfirmPasswordReset {
  Future<Either<Failure, Unit>> call(ResetPasswordCredentials credentials);
}

@Injectable(singleton: false)
class ConfirmPasswordResetImpl implements ConfirmPasswordReset {
  AuthRepository repository;

  ConfirmPasswordResetImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(
      ResetPasswordCredentials credentials) async {
    final validateResult = _validateCredentials(credentials);
    if (validateResult != null) return validateResult;
    return await _confirmPasswordReset(credentials);
  }

  Either<Failure, Unit>? _validateCredentials(
      ResetPasswordCredentials credentials) {
    if (!credentials.isValidCode) {
      return Left(ResetPasswordFailure(AuthErrorMessages.codeIsInvalid));
    }

    if (!credentials.isValidPassword) {
      return Left(ResetPasswordFailure(AuthErrorMessages.passwordIsInvalid));
    }

    return null;
  }

  Future<Either<Failure, Unit>> _confirmPasswordReset(
      ResetPasswordCredentials credentials) {
    return repository.confirmPasswordReset(
        code: credentials.code, newPassword: credentials.newPassword);
  }
}
