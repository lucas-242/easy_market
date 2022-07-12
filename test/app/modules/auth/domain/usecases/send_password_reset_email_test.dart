import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/auth/domain/entities/reset_password_credentials.dart';
import 'package:market_lists/app/modules/auth/domain/errors/errors.dart';
import 'package:market_lists/app/modules/auth/domain/usecases/send_password_reset_email.dart';
import 'package:mockito/mockito.dart';

import '../../auth_mock_test.mocks.dart';

void main() {
  final repository = MockAuthRepository();
  final usecase = SendPasswordResetEmailImpl(repository);

  test('Should send password reset email', () async {
    final credentials = ResetPasswordCredentials.sendPasswordResetEmail(
        email: 'test@gmail.com');
    when(repository.sendPasswordResetEmail(email: credentials.email))
        .thenAnswer((_) async => right(unit));
    final result = await usecase(credentials);
    expect(result, const Right(unit));
  });

  test('Should throw ResetPasswordFailure when email is bad formatted',
      () async {
    final credentials =
        ResetPasswordCredentials.sendPasswordResetEmail(email: 'test@gmail');
    when(repository.sendPasswordResetEmail(email: credentials.email))
        .thenAnswer((_) async => left(ResetPasswordFailure('Test')));
    final result = await usecase(credentials);

    expect(result.leftMap((l) => l is ResetPasswordFailure), const Left(true));
  });
}
