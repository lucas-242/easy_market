import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/core/auth/domain/entities/login_credentials.dart';
import 'package:market_lists/app/core/auth/domain/entities/user.dart';
import 'package:market_lists/app/core/auth/domain/errors/errors.dart';
import 'package:market_lists/app/core/auth/domain/repositories/auth_repository.dart';
import 'package:market_lists/app/core/errors/errors.dart';

abstract class LoginByPhone {
  Future<Either<Failure, User>> call(LoginCredentials credentials);
}

@Injectable(singleton: false)
class LoginByPhoneImpl extends LoginByPhone {
  final AuthRepository repository;

  LoginByPhoneImpl(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginCredentials credentials) async {
    final validateResult = _validateCredentials(credentials);
    if (validateResult != null) return validateResult;
    return await _loginByPhone(credentials);
  }

  Either<Failure, User>? _validateCredentials(LoginCredentials credentials) {
    if (!credentials.isValidPhoneNumber) {
      return Left(LoginByPhoneFailure(AuthErrorMessages.phoneIsInvalid));
    }

    return null;
  }

  Future<Either<Failure, User>> _loginByPhone(LoginCredentials credentials) {
    return repository.loginByPhone(phone: credentials.phone);
  }
}
