// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:easy_market/app/core/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/listen_collaborators_by_emails.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/collaborator_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../global_mock.mocks.dart';
import '../../../../test_helper.dart';
import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockCollaboratorRepository();
  final usecase = ListenCollaboratorsByEmailsImpl(repository);
  final mockStream = MockStream<Either<Failure, List<CollaboratorModel>>>();

  final emails = collaborators.map((e) => e.email).toList();
  TestHelper.loadAppLocalizations();

  when(repository.listenCollaboratorsByEmails(emails))
      .thenAnswer((_) => mockStream);

  test('Should return a List of Collaborators', () async {
    when(mockStream.listen(any)).thenAnswer((invocation) {
      return Stream.value(
              Right<Failure, List<CollaboratorModel>>(collaborators))
          .listen(invocation.positionalArguments.first);
    });

    final result = usecase(emails);
    result.listen((event) {
      event.fold((l) => print(l), (r) {
        expect(r, isA<List<CollaboratorModel>>());
        expect(r, isNotEmpty);
      });
    });
  });

  test('Should return empty', () {
    when(mockStream.listen(any)).thenAnswer((invocation) {
      return Stream.value(const Right<Failure, List<CollaboratorModel>>([]))
          .listen(invocation.positionalArguments.first);
    });

    final result = usecase(emails);

    expect(result, isNotNull);
    result.listen((event) {
      event.fold((l) => print(l), (r) {
        expect(r, isA<List<CollaboratorModel>>());
        expect(r, isEmpty);
      });
    });
  });
}
