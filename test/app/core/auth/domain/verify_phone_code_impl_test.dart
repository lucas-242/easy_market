import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/core/auth/domain/entities/login_credentials.dart';
import 'package:market_lists/app/core/auth/domain/errors/errors.dart';
import 'package:market_lists/app/core/auth/domain/usecases/verify_phone_code.dart';
import 'package:mockito/mockito.dart';

import '../auth_mock_test.dart';
import '../auth_mock_test.mocks.dart';

void main() {
  final repository = MockAuthRepositoryTest();
  final usecase = VerifyPhoneCodeImpl(repository);

  test('Should Verify phone code', () async {
    final loggedUser = user;
    final credentials = LoginCredentials.withVerificationCode(
        verificationId: '123456', code: 'abc123');
    when(repository.verifyPhoneCode(
            code: credentials.code, verificationId: credentials.verificationId))
        .thenAnswer((_) async => right(loggedUser));
    final result = await usecase(credentials);
    expect(result, Right(loggedUser));
  });

  test('Should throw LoginByPhoneFailure when code is not valid', () async {
    final credentials = LoginCredentials.withVerificationCode(
        verificationId: '123456', code: '');
    final result = await usecase(credentials);

    expect(
        result.leftMap((l) =>
            l is LoginByPhoneFailure &&
            l.message == AuthErrorMessages.codeIsInvalid),
        const Left(true));
  });

  test('Should throw LoginByPhoneFailure when verificationId is not valid',
      () async {
    final credentials = LoginCredentials.withVerificationCode(
        verificationId: '', code: 'abc123');
    final result = await usecase(credentials);

    expect(
        result.leftMap((l) =>
            l is LoginByPhoneFailure &&
            l.message == AuthErrorMessages.verificationIdIsInvalid),
        const Left(true));
  });
}
