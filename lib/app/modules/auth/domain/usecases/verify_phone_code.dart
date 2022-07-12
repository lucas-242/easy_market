import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/modules/auth/domain/entities/sign_in_credentials.dart';
import 'package:market_lists/app/modules/auth/domain/entities/user_info.dart';
import 'package:market_lists/app/modules/auth/domain/errors/errors.dart';
import 'package:market_lists/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:market_lists/app/core/errors/errors.dart';
part 'verify_phone_code.g.dart';

abstract class VerifyPhoneCode {
  Future<Either<Failure, UserInfo>> call(SignInCredentials credentials);
}

@Injectable(singleton: false)
class VerifyPhoneCodeImpl extends VerifyPhoneCode {
  final AuthRepository repository;

  VerifyPhoneCodeImpl(this.repository);

  @override
  Future<Either<Failure, UserInfo>> call(SignInCredentials credentials) async {
    final validateResult = _validateCredentials(credentials);
    if (validateResult != null) return validateResult;
    return await _loginByPhone(credentials);
  }

  Either<Failure, UserInfo>? _validateCredentials(
      SignInCredentials credentials) {
    if (!credentials.isValidCode) {
      return Left(SignInWithPhoneFailure(AuthErrorMessages.codeIsInvalid));
    }

    if (!credentials.isValidVerificationId) {
      return Left(
          SignInWithPhoneFailure(AuthErrorMessages.verificationIdIsInvalid));
    }

    return null;
  }

  Future<Either<Failure, UserInfo>> _loginByPhone(
      SignInCredentials credentials) {
    return repository.verifyPhoneCode(
      verificationId: credentials.verificationId,
      code: credentials.code,
    );
  }
}
