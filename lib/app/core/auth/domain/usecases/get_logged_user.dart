import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/core/auth/domain/entities/user_info.dart';
import 'package:market_lists/app/core/auth/domain/repositories/auth_repository.dart';
import 'package:market_lists/app/core/errors/errors.dart';

abstract class GetLoggedUser {
  Future<Either<Failure, UserInfo>> call();
}

@Injectable(singleton: false)
class GetLoggedUserImpl implements GetLoggedUser {
  AuthRepository repository;
  GetLoggedUserImpl(this.repository);

  @override
  Future<Either<Failure, UserInfo>> call() async {
    return await repository.getLoggedUser();
  }
}
