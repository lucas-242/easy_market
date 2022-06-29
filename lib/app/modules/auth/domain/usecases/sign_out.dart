import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:market_lists/app/core/errors/errors.dart';

abstract class SignOut {
  Future<Either<Failure, Unit>> call();
}

@Injectable(singleton: false)
class SignOutImpl extends SignOut {
  AuthRepository repository;

  SignOutImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call() async {
    return await repository.logout();
  }
}
