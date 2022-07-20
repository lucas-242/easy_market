// ignore_for_file: avoid_print

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:easy_market/app/core/routes/deep_links/domain/entities/deep_link_data.dart';
import 'package:easy_market/app/core/routes/deep_links/domain/errors/errors.dart';
import 'package:easy_market/app/core/routes/deep_links/domain/usecases/listen_initial_link.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/core/errors/errors.dart';
import 'package:mockito/mockito.dart';

import '../deep_links_mock_test.dart';
import '../deep_links_mock_test.mocks.dart';

void main() {
  final repository = MockDeepLinksHandleRepository();
  final usecase = ListenInitialLinkImpl(repository);
  final stream = MockStream<Either<Failure, DeepLinkData>>();

  test('Should listen to initial link', () {
    when(repository.listenInitialLink()).thenAnswer((_) => stream);

    when(stream.listen(any)).thenAnswer((invocation) {
      return Stream.value(Right<Failure, DeepLinkData>(deepLinkData))
          .listen(invocation.positionalArguments.first);
    });

    final result = usecase();
    result.listen((event) {
      event.fold((l) => print(l), (r) {
        expect(r, deepLinkData);
      });
    });
  });

  test('Should throw DeepLinkHandleFailure', () {
    when(repository.listenInitialLink()).thenAnswer((_) => stream);
    when(stream.listen(any)).thenAnswer((invocation) {
      return Stream.value(
              Left<Failure, DeepLinkData>(DeepLinkHandleFailure('test')))
          .listen(invocation.positionalArguments.first);
    });

    final result = usecase();

    expect(result, isNotNull);
    result.listen((event) {
      expect(
          event.leftMap((l) => l is DeepLinkHandleFailure), const Left(true));
    });
  });
}
