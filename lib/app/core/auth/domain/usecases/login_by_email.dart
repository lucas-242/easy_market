import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/core/auth/domain/entities/login_credentials.dart';

import 'package:market_lists/app/core/auth/domain/entities/user.dart';
import 'package:market_lists/app/core/auth/domain/errors/errors.dart';
import 'package:market_lists/app/core/auth/domain/repositories/auth_repository.dart';
import 'package:market_lists/app/core/errors/errors.dart';

abstract class LoginByEmail {
  Future<Either<Failure, User>> call(LoginCredentials credentials);
}

@Injectable(singleton: false)
class LoginByEmailImpl implements LoginByEmail {
  AuthRepository repository;

  LoginByEmailImpl(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginCredentials credentials) async {
    final validateResult = _validateCredentials(credentials);
    if (validateResult != null) return validateResult;
    return await _loginByEmail(credentials);
  }

  Either<Failure, User>? _validateCredentials(LoginCredentials credentials) {
    if (!credentials.isValidEmail) {
      return Left(LoginByEmailFailure(AuthErrorMessages.emailIsInvalid));
    }

    if (!credentials.isValidPassword) {
      return Left(LoginByEmailFailure(AuthErrorMessages.passwordIsInvalid));
    }

    return null;
  }

  Future<Either<Failure, User>> _loginByEmail(LoginCredentials credentials) {
    return repository.loginByEmail(
      email: credentials.email,
      password: credentials.password,
    );
  }
}
