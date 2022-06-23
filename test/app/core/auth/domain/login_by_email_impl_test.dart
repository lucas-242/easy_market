import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/core/auth/domain/entities/login_credentials.dart';
import 'package:market_lists/app/core/auth/domain/errors/errors.dart';
import 'package:market_lists/app/core/auth/domain/usecases/login_by_email.dart';
import 'package:mockito/mockito.dart';

import '../auth_mock_test.dart';
import '../auth_mock_test.mocks.dart';

void main() {
  final repository = MockAuthRepositoryTest();
  final usecase = LoginByEmailImpl(repository);

  test('Should Login with email', () async {
    final loggedUser = user;
    when(repository.loginByEmail(any))
        .thenAnswer((_) async => right(loggedUser));
    final credentials =
        LoginCredentials(password: '123456', email: 'test@email.com');
    final result = await usecase(credentials);
    expect(result, Right(loggedUser));
  });

  test('Should throw LoginByEmailFailure when email is wrong', () async {
    final credentials = LoginCredentials(password: '123456', email: 'test');
    final result = await usecase(credentials);

    expect(
        result.leftMap((l) =>
            l is LoginByEmailFailure &&
            l.message == AuthErrorMessages.emailIsInvalid),
        const Left(true));
  });

  test('Should throw LoginByEmailFailure when password is wrong', () async {
    final credentials =
        LoginCredentials(password: '123', email: 'test@email.com');
    final result = await usecase(credentials);

    expect(
        result.leftMap((l) =>
            l is LoginByEmailFailure &&
            l.message == AuthErrorMessages.passwordIsInvalid),
        const Left(true));
  });
}
