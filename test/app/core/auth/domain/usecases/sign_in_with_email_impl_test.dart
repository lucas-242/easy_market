import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/core/auth/domain/entities/sign_in_credentials.dart';
import 'package:easy_market/app/core/auth/domain/errors/errors.dart';
import 'package:easy_market/app/core/auth/domain/usecases/sign_in_with_email.dart';
import 'package:mockito/mockito.dart';

import '../../auth_mock_test.dart';
import '../../auth_mock_test.mocks.dart';

void main() {
  final repository = MockAuthRepository();
  final usecase = SignInWithEmailImpl(repository);

  test('Should Login with email', () async {
    final loggedUser = user;
    final credentials = SignInCredentials.withEmailAndPassword(
        password: '123456', email: 'test@email.com');
    when(repository.signInByEmail(
            email: credentials.email, password: credentials.password))
        .thenAnswer((_) async => right(loggedUser));
    final result = await usecase(credentials);
    expect(result, Right(loggedUser));
  });

  test('Should throw LoginByEmailFailure when email is not valid', () async {
    final credentials = SignInCredentials.withEmailAndPassword(
        password: '123456', email: 'test');
    final result = await usecase(credentials);

    expect(
        result.leftMap((l) =>
            l is SignInWithEmailFailure &&
            l.message == AuthErrorMessages.emailIsInvalid),
        const Left(true));
  });

  test('Should throw LoginByEmailFailure when password is not valid', () async {
    final credentials = SignInCredentials.withEmailAndPassword(
        password: '123', email: 'test@email.com');
    final result = await usecase(credentials);

    expect(
        result.leftMap((l) =>
            l is SignInWithEmailFailure &&
            l.message == AuthErrorMessages.passwordIsInvalid),
        const Left(true));
  });
}
