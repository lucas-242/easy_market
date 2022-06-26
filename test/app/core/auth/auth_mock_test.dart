import 'package:market_lists/app/core/auth/domain/entities/user.dart';
import 'package:market_lists/app/core/auth/domain/repositories/auth_repository.dart';
import 'package:market_lists/app/core/auth/infra/datasources/auth_datasource.dart';
import 'package:market_lists/app/core/auth/infra/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class AuthRepositoryTest extends Mock implements AuthRepository {}

class AuthDatasourceTest extends Mock implements AuthDatasource {}

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

@GenerateMocks([AuthRepositoryTest, AuthDatasourceTest])
void main() {}
