import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/core/errors/errors.dart';
import 'package:easy_market/app/modules/auth/domain/entities/reset_password_credentials.dart';
import 'package:easy_market/app/modules/auth/domain/errors/errors.dart';
import 'package:easy_market/app/modules/auth/domain/repositories/auth_repository.dart';

part 'send_password_reset_email.g.dart';

abstract class SendPasswordResetEmail {
  Future<Either<Failure, Unit>> call(ResetPasswordCredentials credentials);
}

@Injectable(singleton: false)
class SendPasswordResetEmailImpl implements SendPasswordResetEmail {
  AuthRepository repository;

  SendPasswordResetEmailImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(
      ResetPasswordCredentials credentials) async {
    final validateResult = _validateCredentials(credentials);
    if (validateResult != null) return validateResult;
    return await _sendPasswordResetEmail(credentials);
  }

  Either<Failure, Unit>? _validateCredentials(
      ResetPasswordCredentials credentials) {
    if (!credentials.isValidEmail) {
      return Left(ResetPasswordFailure(AuthErrorMessages.emailIsInvalid));
    }

    return null;
  }

  Future<Either<Failure, Unit>> _sendPasswordResetEmail(
      ResetPasswordCredentials credentials) async {
    return await repository.sendPasswordResetEmail(email: credentials.email);
  }
}
