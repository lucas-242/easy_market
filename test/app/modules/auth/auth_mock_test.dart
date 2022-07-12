import 'package:dartz/dartz.dart';
import 'package:market_lists/app/core/errors/errors.dart';
import 'package:market_lists/app/modules/auth/domain/entities/user.dart';
import 'package:market_lists/app/modules/auth/domain/entities/user_info.dart';
import 'package:market_lists/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:market_lists/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:market_lists/app/modules/auth/infra/models/user_model.dart';
import 'package:mockito/annotations.dart';

final user = User(
  id: '123',
  name: 'Jooj',
  email: 'email@test.com',
  phone: '21123456789',
);

final userModel = UserModel(
  id: '123',
  name: 'Jooj',
  email: 'email@test.com',
  phone: '21123456789',
);

@GenerateMocks([
  AuthRepository,
  AuthDatasource,
  Stream<Either<Failure, UserInfo?>>,
])
void main() {}
