import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../entities/sign_in_credentials.dart';
import '../entities/user_info.dart';
import '../errors/errors.dart';
import '../repositories/auth_repository.dart';
import '../../../errors/errors.dart';
part 'sign_in_with_phone.g.dart';

abstract class SignInWithPhone {
  Future<Either<Failure, UserInfo>> call(SignInCredentials credentials);
}

@Injectable(singleton: false)
class SignInWithPhoneImpl extends SignInWithPhone {
  final AuthRepository repository;

  SignInWithPhoneImpl(this.repository);

  @override
  Future<Either<Failure, UserInfo>> call(SignInCredentials credentials) async {
    final validateResult = _validateCredentials(credentials);
    if (validateResult != null) return validateResult;
    return await _loginByPhone(credentials);
  }

  Either<Failure, UserInfo>? _validateCredentials(
      SignInCredentials credentials) {
    if (!credentials.isValidPhoneNumber) {
      return Left(SignInWithPhoneFailure(AuthErrorMessages.phoneIsInvalid));
    }

    return null;
  }

  Future<Either<Failure, UserInfo>> _loginByPhone(
      SignInCredentials credentials) {
    return repository.loginByPhone(phone: credentials.phone);
  }
}
