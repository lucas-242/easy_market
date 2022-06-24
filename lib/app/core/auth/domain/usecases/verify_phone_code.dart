import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/core/auth/domain/entities/login_credentials.dart';
import 'package:market_lists/app/core/auth/domain/entities/user_info.dart';
import 'package:market_lists/app/core/auth/domain/errors/errors.dart';
import 'package:market_lists/app/core/auth/domain/repositories/auth_repository.dart';
import 'package:market_lists/app/core/errors/errors.dart';

abstract class VerifyPhoneCode {
  Future<Either<Failure, UserInfo>> call(LoginCredentials credentials);
}

@Injectable(singleton: false)
class VerifyPhoneCodeImpl extends VerifyPhoneCode {
  final AuthRepository repository;

  VerifyPhoneCodeImpl(this.repository);

  @override
  Future<Either<Failure, UserInfo>> call(LoginCredentials credentials) async {
    final validateResult = _validateCredentials(credentials);
    if (validateResult != null) return validateResult;
    return await _loginByPhone(credentials);
  }

  Either<Failure, UserInfo>? _validateCredentials(
      LoginCredentials credentials) {
    if (!credentials.isValidCode) {
      return Left(LoginByPhoneFailure(AuthErrorMessages.codeIsInvalid));
    }

    if (!credentials.isValidVerificationId) {
      return Left(
          LoginByPhoneFailure(AuthErrorMessages.verificationIdIsInvalid));
    }

    return null;
  }

  Future<Either<Failure, UserInfo>> _loginByPhone(
      LoginCredentials credentials) {
    return repository.verifyPhoneCode(
      verificationId: credentials.verificationId,
      code: credentials.code,
    );
  }
}
