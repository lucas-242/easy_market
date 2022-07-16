import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/core/errors/errors.dart';
import 'package:easy_market/app/core/auth/domain/entities/reset_password_credentials.dart';
import 'package:easy_market/app/core/auth/domain/errors/errors.dart';
import 'package:easy_market/app/core/auth/domain/repositories/auth_repository.dart';

part 'confirm_password_reset.g.dart';

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
      ResetPasswordCredentials credentials) async {
    return await repository.confirmPasswordReset(
        code: credentials.code, newPassword: credentials.newPassword);
  }
}
