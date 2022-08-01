import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../entities/sign_in_credentials.dart';
import '../entities/user_info.dart';

import '../errors/errors.dart';
import '../repositories/auth_repository.dart';
import '../../../errors/errors.dart';
part 'sign_in_with_email.g.dart';

abstract class SignInWithEmail {
  Future<Either<Failure, UserInfo>> call(SignInCredentials credentials);
}

@Injectable(singleton: false)
class SignInWithEmailImpl implements SignInWithEmail {
  AuthRepository repository;

  SignInWithEmailImpl(this.repository);

  @override
  Future<Either<Failure, UserInfo>> call(SignInCredentials credentials) async {
    final validateResult = _validateCredentials(credentials);
    if (validateResult != null) return validateResult;
    return await _signInByEmail(credentials);
  }

  Either<Failure, UserInfo>? _validateCredentials(
      SignInCredentials credentials) {
    if (!credentials.isValidEmail) {
      return Left(SignInWithEmailFailure(AuthErrorMessages.emailIsInvalid));
    }

    if (!credentials.isValidPassword) {
      return Left(SignInWithEmailFailure(AuthErrorMessages.passwordIsInvalid));
    }

    return null;
  }

  Future<Either<Failure, UserInfo>> _signInByEmail(
      SignInCredentials credentials) {
    return repository.signInByEmail(
      email: credentials.email,
      password: credentials.password,
    );
  }
}
