import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/core/auth/domain/entities/login_credentials.dart';
import 'package:market_lists/app/core/auth/domain/entities/user_info.dart';

import 'package:market_lists/app/core/auth/domain/errors/errors.dart';
import 'package:market_lists/app/core/auth/domain/repositories/auth_repository.dart';
import 'package:market_lists/app/core/errors/errors.dart';

abstract class LoginByEmail {
  Future<Either<Failure, UserInfo>> call(LoginCredentials credentials);
}

@Injectable(singleton: false)
class LoginByEmailImpl implements LoginByEmail {
  AuthRepository repository;

  LoginByEmailImpl(this.repository);

  @override
  Future<Either<Failure, UserInfo>> call(LoginCredentials credentials) async {
    final validateResult = _validateCredentials(credentials);
    if (validateResult != null) return validateResult;
    return await _loginByEmail(credentials);
  }

  Either<Failure, UserInfo>? _validateCredentials(
      LoginCredentials credentials) {
    if (!credentials.isValidEmail) {
      return Left(LoginByEmailFailure(AuthErrorMessages.emailIsInvalid));
    }

    if (!credentials.isValidPassword) {
      return Left(LoginByEmailFailure(AuthErrorMessages.passwordIsInvalid));
    }

    return null;
  }

  Future<Either<Failure, UserInfo>> _loginByEmail(
      LoginCredentials credentials) {
    return repository.loginByEmail(
      email: credentials.email,
      password: credentials.password,
    );
  }
}
