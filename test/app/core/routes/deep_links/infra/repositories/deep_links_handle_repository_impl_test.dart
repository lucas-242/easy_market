// ignore_for_file: avoid_print
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:easy_market/app/core/routes/deep_links/domain/entities/deep_link_data.dart';
import 'package:easy_market/app/core/routes/deep_links/domain/errors/errors.dart';
import 'package:easy_market/app/core/routes/deep_links/infra/repositories/deep_links_handle_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../deep_links_mock_test.dart';
import '../../deep_links_mock_test.mocks.dart';

void main() {
  final datasource = MockDeepLinksHandleDatasource();
  final repository = DeepLinksHandleRepositoryImpl(datasource);
  final stream = MockStream<DeepLinkData>();

  group('Initial Link', () {
    test('Should listen to initial link', () {
      when(datasource.listenInitialLink()).thenAnswer((_) => stream);

      when(stream.listen(any)).thenAnswer((invocation) {
        return Stream.value(deepLinkData)
            .listen(invocation.positionalArguments.first);
      });

      final result = repository.listenInitialLink();
      result.listen((event) {
        event.fold((l) => print(l), (r) {
          expect(r, deepLinkData);
        });
      });
    });

    test('Should throw DeepLinkHandleFailure', () {
      when(repository.listenInitialLink())
          .thenThrow((_) => DeepLinkHandleFailure('test'));

      final result = repository.listenInitialLink();

      expect(result, isNotNull);
      result.listen((event) {
        expect(
            event.leftMap((l) => l is DeepLinkHandleFailure), const Left(true));
      });
    });
  });

  group('Background Links', () {
    test('Should listen to background links', () {
      when(datasource.listenBackgroudLinks()).thenAnswer((_) => stream);

      when(stream.listen(any)).thenAnswer((invocation) {
        return Stream.value(deepLinkData)
            .listen(invocation.positionalArguments.first);
      });

      final result = repository.listenBackgroudLinks();

      result.listen((event) {
        event.fold((l) => print(l), (r) {
          expect(r, deepLinkData);
        });
      });
    });

    test('Should throw DeepLinkHandleFailure', () {
      when(repository.listenBackgroudLinks())
          .thenThrow((_) => DeepLinkHandleFailure('test'));

      final result = repository.listenBackgroudLinks();

      expect(result, isNotNull);
      result.listen((event) {
        expect(
            event.leftMap((l) => l is DeepLinkHandleFailure), const Left(true));
      });
    });
  });
}
