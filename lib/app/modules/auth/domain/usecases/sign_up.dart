import 'package:dartz/dartz.dart';
import 'package:market_lists/app/core/errors/errors.dart';
import 'package:market_lists/app/modules/auth/domain/entities/sign_up_credentials.dart';
import 'package:market_lists/app/modules/auth/domain/errors/errors.dart';
import 'package:market_lists/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class SignUp {
  Future<Either<Failure, Unit>> call(SignUpCredentials credentials);
}

class SignUpImpl implements SignUp {
  AuthRepository repository;

  SignUpImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SignUpCredentials credentials) async {
    final validateResult = _validateCredentials(credentials);
    if (validateResult != null) return validateResult;
    return await _signUp(credentials);
  }

  Either<Failure, Unit>? _validateCredentials(SignUpCredentials credentials) {
    if (!credentials.isValidEmail) {
      return Left(SignUpFailure(AuthErrorMessages.emailIsInvalid));
    }

    if (!credentials.isValidPassword) {
      return Left(SignUpFailure(AuthErrorMessages.passwordIsInvalid));
    }

    return null;
  }

  Future<Either<Failure, Unit>> _signUp(SignUpCredentials credentials) async {
    return await repository.signUp(
      email: credentials.email,
      name: credentials.name,
      password: credentials.password,
    );
  }
}
