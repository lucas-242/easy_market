import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/core/errors/errors.dart';
import 'package:easy_market/app/core/auth/domain/entities/sign_up_credentials.dart';
import 'package:easy_market/app/core/auth/domain/errors/errors.dart';
import 'package:easy_market/app/core/auth/domain/usecases/sign_up_with_email.dart';
import 'package:mockito/mockito.dart';

import '../../auth_mock_test.mocks.dart';

void main() {
  final repository = MockAuthRepository();
  final usecase = SignUpWithEmailImpl(repository);
  final credentials = SignUpCredentials(
      email: 'test@email.com', password: '123abc', name: 'Test man');

  void prepareSignUp(Either<Failure, Unit> answer) {
    when(repository.signUp(
      name: anyNamed('name'),
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => answer);
  }

  test('Should Sign up user', () async {
    prepareSignUp(const Right(unit));
    final result = await usecase(credentials);
    expect(result, const Right(unit));
  });

  test('Should throw SignUpFailure when email is not valid', () async {
    final credentials = SignUpCredentials(
        email: 'test.com', password: '123abc', name: 'Test man');
    final result = await usecase(credentials);

    expect(
        result.leftMap((l) =>
            l is SignUpFailure &&
            l.message == AuthErrorMessages.emailIsInvalid),
        const Left(true));
  });

  test('Should throw SignUpFailure', () async {
    prepareSignUp(left(SignUpFailure('Test')));
    final result = await usecase(credentials);

    expect(result.leftMap((l) => l is SignUpFailure), const Left(true));
  });
}
