import 'package:easy_market/app/modules/shopping_list/domain/entities/collaborator.dart';
import 'package:easy_market/app/modules/shopping_list/external/datasources/firebase/firebase_collaborator_datasource.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/collaborator_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock_shopping_list_test.dart';

void main() {
  final database = FakeFirebaseFirestore();
  final datasource = FirebaseCollaboratorDatasource(database);

  Future<Collaborator> _createMockCollaborator(
      {CollaboratorModel? mock}) async {
    final toCreate = mock ?? collaborator;
    final listReference = await database.collection(datasource.usersTable).add({
      'name': toCreate.name,
      'email': toCreate.email,
    });
    final result = toCreate.copyWith(id: listReference.id);
    return result;
  }

  setUpAll(() async {
    for (var collaborator in collaborators) {
      await _createMockCollaborator(mock: collaborator);
    }
  });

  test('Should listen registered and not registered collaborators', () async {
    final result = datasource.listenCollaboratorsByEmails(
        [collaborator.email, 'not_registered@email.com']);
    result.listen((collaborators) {
      expect(collaborators, isNotEmpty);
      expect(collaborators.where((collaborator) => !collaborator.isAlreadyUser),
          hasLength(1));
      expect(collaborators.where((collaborator) => collaborator.isAlreadyUser),
          hasLength(1));
    });
  });
}
