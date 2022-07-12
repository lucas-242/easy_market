import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/auth/domain/entities/reset_password_credentials.dart';
import 'package:market_lists/app/modules/auth/domain/errors/errors.dart';
import 'package:market_lists/app/modules/auth/domain/usecases/confirm_password_reset.dart';
import 'package:mockito/mockito.dart';

import '../../auth_mock_test.mocks.dart';

void main() {
  final repository = MockAuthRepository();
  final usecase = ConfirmPasswordResetImpl(repository);

  test('Should confirm password reset', () async {
    final credentials = ResetPasswordCredentials.confirmPasswordReset(
        code: '123', newPassword: '123456');
    when(repository.confirmPasswordReset(
            code: anyNamed('code'), newPassword: anyNamed('newPassword')))
        .thenAnswer((_) async => right(unit));
    final result = await usecase(credentials);
    expect(result, const Right(unit));
  });

  test('Should throw ResetPasswordFailure when password is not valid',
      () async {
    final credentials = ResetPasswordCredentials.confirmPasswordReset(
        code: '123', newPassword: '1234');
    when(repository.confirmPasswordReset(
            code: anyNamed('code'), newPassword: anyNamed('newPassword')))
        .thenAnswer((_) async => left(ResetPasswordFailure('Test')));
    final result = await usecase(credentials);

    expect(result.leftMap((l) => l is ResetPasswordFailure), const Left(true));
  });

  test('Should throw ResetPasswordFailure when code is not valid', () async {
    final credentials = ResetPasswordCredentials.confirmPasswordReset(
        code: '', newPassword: '123456');
    when(repository.confirmPasswordReset(
            code: anyNamed('code'), newPassword: anyNamed('newPassword')))
        .thenAnswer((_) async => left(ResetPasswordFailure('Test')));
    final result = await usecase(credentials);

    expect(result.leftMap((l) => l is ResetPasswordFailure), const Left(true));
  });
}
