import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/auth/domain/errors/errors.dart';
import 'package:easy_market/app/modules/auth/domain/usecases/sign_out.dart';
import 'package:mockito/mockito.dart';

import '../../auth_mock_test.mocks.dart';

void main() {
  final repository = MockAuthRepository();
  final usecase = SignOutImpl(repository);

  test('Should Loggout user', () async {
    when(repository.signOut()).thenAnswer((_) async => const Right(unit));
    final result = await usecase();
    expect(result, const Right(unit));
  });

  test('Should throw LogoutFailure', () async {
    when(repository.signOut())
        .thenAnswer((_) async => left(SignOutFailure('Test')));
    final result = await usecase();

    expect(result.leftMap((l) => l is SignOutFailure), const Left(true));
  });
}
