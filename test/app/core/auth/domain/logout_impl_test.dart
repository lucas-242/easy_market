import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/core/auth/domain/errors/errors.dart';
import 'package:market_lists/app/core/auth/domain/usecases/logout.dart';
import 'package:mockito/mockito.dart';

import '../auth_mock_test.mocks.dart';

void main() {
  final repository = MockAuthRepositoryTest();
  final usecase = LogoutImpl(repository);

  test('Should Loggout user', () async {
    when(repository.logout()).thenAnswer((_) async => const Right(unit));
    final result = await usecase();
    expect(result, const Right(unit));
  });

  test('Should throw LogoutFailure', () async {
    when(repository.logout())
        .thenAnswer((_) async => left(LogoutFailure('Test')));
    final result = await usecase();

    expect(result.leftMap((l) => l is LogoutFailure), const Left(true));
  });
}
