// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/collaborator_model.dart';
import 'package:easy_market/app/modules/shopping_list/infra/repositories/collaborator_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../global_mock.mocks.dart';
import '../../../../test_helper.dart';
import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final datasource = MockCollaboratorDatasource();
  final repository = CollaboratorRepositoryImpl(datasource);
  final mockStream = MockStream<List<CollaboratorModel>>();

  TestHelper.loadAppLocalizations();

  final emails = [collaborator.email];
  when(datasource.listenCollaboratorsByEmails(any))
      .thenAnswer((_) => mockStream);

  group('Listen', () {
    test('Should listen collaborators by email', () {
      when(datasource.listenCollaboratorsByEmails(any))
          .thenAnswer((_) => mockStream);
      when(mockStream.listen(any)).thenAnswer((invocation) {
        return Stream.value([collaborator])
            .listen(invocation.positionalArguments.first);
      });
      final result = repository.listenCollaboratorsByEmails(emails);

      result.listen((event) {
        event.fold((l) => print(l), (r) {
          expectLater(r, isNotEmpty);
          expect(r.every((e) => emails.contains(e.email)), true);
        });
      });
    });

    test('Should throw GetCollaboratorsFailure', () {
      when(mockStream.listen(any)).thenAnswer((invocation) {
        return Stream<List<CollaboratorModel>>.error(
                GetCollaboratorsFailure('test'))
            .listen(invocation.positionalArguments.first);
      });

      final result = repository.listenCollaboratorsByEmails(emails);

      expect(result, isNotNull);
      result.listen((event) {
        expect(event.leftMap((l) => l is GetCollaboratorsFailure),
            const Left(true));
      });
    });
  });

  group('Get', () {
    test('Should get collaborators by email', () async {
      when(datasource.getCollaboratorsByEmails(any))
          .thenAnswer((_) async => [collaborator]);
      final result = await repository.getCollaboratorsByEmails(emails);
      result.fold((l) => print(l), (r) {
        expect(r, isNotEmpty);
        expect(r.every((e) => emails.contains(e.email)), true);
      });
    });

    test('Should throw GetCollaboratorsFailure', () async {
      when(datasource.getCollaboratorsByEmails(any))
          .thenThrow((_) async => Exception());

      final result = await repository.getCollaboratorsByEmails(emails);

      expect(result, isNotNull);
      expect(result.leftMap((l) => l is GetCollaboratorsFailure),
          const Left(true));
    });
  });
}
