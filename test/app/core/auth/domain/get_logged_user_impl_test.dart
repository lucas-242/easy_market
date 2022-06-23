import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/core/auth/domain/errors/errors.dart';
import 'package:market_lists/app/core/auth/domain/usecases/get_logged_user.dart';
import 'package:mockito/mockito.dart';

import '../auth_mock_test.dart';
import '../auth_mock_test.mocks.dart';

void main() {
  final repository = MockAuthRepositoryTest();
  final usecase = GetLoggedUserImpl(repository);

  test('Should get Logged User', () async {
    final loggedUser = user;
    when(repository.getLoggedUser()).thenAnswer((_) async => right(loggedUser));
    final result = await usecase();
    expect(result, Right(loggedUser));
  });

  test('Should throw GetLoggedUserFailure', () async {
    when(repository.getLoggedUser())
        .thenAnswer((_) async => left(GetLoggedUserFailure('Test')));
    final result = await usecase();

    expect(result.leftMap((l) => l is GetLoggedUserFailure), const Left(true));
  });
}
