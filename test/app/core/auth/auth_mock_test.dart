import 'package:market_lists/app/core/auth/domain/entities/user.dart';
import 'package:market_lists/app/core/auth/domain/repositories/auth_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class AuthRepositoryTest extends Mock implements AuthRepository {}

final user = User(
  id: '123',
  name: 'Jooj',
  email: 'email@test.com',
  phoneNumber: '21123456789',
);

@GenerateMocks([AuthRepositoryTest])
void main() {}
