import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/core/auth/domain/errors/errors.dart';
import 'package:easy_market/app/core/auth/domain/usecases/get_current_user.dart';
import 'package:mockito/mockito.dart';

import '../../auth_mock_test.dart';
import '../../auth_mock_test.mocks.dart';

void main() {
  final repository = MockAuthRepository();
  final usecase = GetCurrentUserImpl(repository);

  test('Should get Logged User', () async {
    final loggedUser = user;
    when(repository.getCurrentUser())
        .thenAnswer((_) async => right(loggedUser));
    final result = await usecase();
    expect(result, Right(loggedUser));
  });

  test('Should throw GetLoggedUserFailure', () async {
    when(repository.getCurrentUser())
        .thenAnswer((_) async => left(GetCurrentUserFailure('Test')));
    final result = await usecase();

    expect(result.leftMap((l) => l is GetCurrentUserFailure), const Left(true));
  });
}
