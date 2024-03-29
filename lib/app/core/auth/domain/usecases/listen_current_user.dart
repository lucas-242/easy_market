import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../errors/errors.dart';
import '../entities/user_info.dart';
import '../repositories/auth_repository.dart';

part 'listen_current_user.g.dart';

abstract class ListenCurrentUser {
  Stream<Either<Failure, UserInfo?>> call();
}

@Injectable(singleton: false)
class ListenCurrentUserImpl implements ListenCurrentUser {
  AuthRepository repository;
  ListenCurrentUserImpl(this.repository);

  @override
  Stream<Either<Failure, UserInfo?>> call() {
    return repository.listenCurrentUser();
  }
}
