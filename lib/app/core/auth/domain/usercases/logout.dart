import 'package:dartz/dartz.dart';
import 'package:market_lists/app/core/auth/domain/repositories/auth_repository.dart';
import 'package:market_lists/app/core/errors/errors.dart';

abstract class Logout {
  Future<Either<Failure, Unit>> call();
}

class LogoutImpl extends Logout {
  AuthRepository repository;

  LogoutImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call() async {
    return await repository.logout();
  }
}
