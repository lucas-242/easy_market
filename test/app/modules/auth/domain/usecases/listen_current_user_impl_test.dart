// ignore_for_file: avoid_print

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/core/errors/errors.dart';
import 'package:easy_market/app/modules/auth/domain/entities/user_info.dart';
import 'package:easy_market/app/modules/auth/domain/errors/errors.dart';
import 'package:easy_market/app/modules/auth/domain/usecases/listen_current_user.dart';
import 'package:mockito/mockito.dart';

import '../../auth_mock_test.dart';
import '../../auth_mock_test.mocks.dart';

void main() {
  final repository = MockAuthRepository();
  final usecase = ListenCurrentUserImpl(repository);
  final userStream = MockStream<Either<Failure, UserInfo?>>();

  test('Should listen to Logged User', () {
    final user = userModel;
    when(repository.listenCurrentUser()).thenAnswer((_) => userStream);

    when(userStream.listen(any)).thenAnswer((invocation) {
      return Stream.value(Right<Failure, UserInfo?>(user))
          .listen(invocation.positionalArguments.first);
    });

    final result = usecase();
    result.listen((event) {
      event.fold((l) => print(l), (r) {
        expect(r, user);
      });
    });
  });

  test('Should throw GetLoggedUserFailure', () {
    when(repository.listenCurrentUser()).thenAnswer((_) => userStream);
    when(userStream.listen(any)).thenAnswer((invocation) {
      return Stream.value(
              Left<Failure, UserInfo?>(GetCurrentUserFailure('test')))
          .listen(invocation.positionalArguments.first);
    });

    final result = usecase();

    expect(result, isNotNull);
    result.listen((event) {
      expect(
          event.leftMap((l) => l is GetCurrentUserFailure), const Left(true));
    });
  });
}
