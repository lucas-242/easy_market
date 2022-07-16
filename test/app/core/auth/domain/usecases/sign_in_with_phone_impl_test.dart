import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/core/auth/domain/entities/sign_in_credentials.dart';
import 'package:easy_market/app/core/auth/domain/errors/errors.dart';
import 'package:easy_market/app/core/auth/domain/usecases/sign_in_with_phone.dart';
import 'package:mockito/mockito.dart';

import '../../auth_mock_test.dart';
import '../../auth_mock_test.mocks.dart';

void main() {
  final repository = MockAuthRepository();
  final usecase = SignInWithPhoneImpl(repository);

  test('Should Login with phone', () async {
    final loggedUser = user;
    final credentials = SignInCredentials.withPhone(phone: '21912345678');
    when(repository.loginByPhone(phone: credentials.phone))
        .thenAnswer((_) async => right(loggedUser));
    final result = await usecase(credentials);
    expect(result, Right(loggedUser));
  });

  test('Should throw LoginByPhoneFailure when phone is not valid', () async {
    final credentials = SignInCredentials.withPhone(phone: '912345678');
    final result = await usecase(credentials);

    expect(
        result.leftMap((l) =>
            l is SignInWithPhoneFailure &&
            l.message == AuthErrorMessages.phoneIsInvalid),
        const Left(true));
  });
}
