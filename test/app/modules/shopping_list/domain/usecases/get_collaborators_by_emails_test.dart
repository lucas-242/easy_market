// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/get_collaborators_by_emails.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/collaborator_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helper.dart';
import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockCollaboratorRepository();
  final usecase = GetCollaboratorsByEmailsImpl(repository);

  final emails = collaborators.map((e) => e.email).toList();
  TestHelper.loadAppLocalizations();

  test('Should return a List of Collaborators', () async {
    when(repository.getCollaboratorsByEmails(any))
        .thenAnswer((_) async => right(collaborators));

    final result = await usecase(emails);
    result.fold((l) => print(l), (r) {
      expect(r, isA<List<CollaboratorModel>>());
      expect(r, isNotEmpty);
    });
  });

  test('Should return empty', () async {
    when(repository.getCollaboratorsByEmails(any))
        .thenAnswer((_) async => right(<CollaboratorModel>[]));

    final result = await usecase(emails);

    expect(result, isNotNull);
    result.fold((l) => print(l), (r) {
      expect(r, isA<List<CollaboratorModel>>());
      expect(r, isEmpty);
    });
  });
}
