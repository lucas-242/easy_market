import 'package:easy_market/app/core/auth/domain/entities/user.dart';
import 'package:easy_market/app/core/auth/domain/repositories/auth_repository.dart';
import 'package:easy_market/app/core/auth/infra/datasources/auth_datasource.dart';
import 'package:easy_market/app/core/auth/infra/models/user_model.dart';
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
])
void main() {}
