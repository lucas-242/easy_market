import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/collaborator_model.dart';

import '../../../../../core/l10n/generated/l10n.dart';
import '../../../domain/errors/errors.dart';
import '../../../infra/datasources/collaborator_datasource.dart';

class FirebaseCollaboratorDatasource implements CollaboratorDatasource {
  final String usersTable = 'users';
  final FirebaseFirestore _firestore;
  final bool _useFirebaseEmulator;

  FirebaseCollaboratorDatasource(this._firestore,
      {bool useFirebaseEmulator = false})
      : _useFirebaseEmulator = useFirebaseEmulator {
    if (_useFirebaseEmulator) {
      _firestore.useFirestoreEmulator('localhost', 8080);
    }
  }

  @override
  Stream<List<CollaboratorModel>> listenCollaboratorsByEmails(
      List<String> emails) {
    try {
      final snapshot = _firestore
          .collection(usersTable)
          .where('email', whereIn: emails)
          .snapshots();

      final result = _querySnapshotToCollaboratorModel(snapshot);
      return result;
    } catch (error) {
      throw GetCollaboratorsFailure(
          AppLocalizations.current.errorToGetCollaborators);
    }
  }

  Stream<List<CollaboratorModel>> _querySnapshotToCollaboratorModel(
      Stream<QuerySnapshot<Object?>> snapshot) {
    final result = snapshot
        .handleError((error) => GetCollaboratorsFailure(
            AppLocalizations.current.errorToGetCollaborators))
        .map((query) => query.docs
            .map((DocumentSnapshot document) =>
                _documentSnapshotToCollaboratorModel(document))
            .toList());
    return result;
  }

  CollaboratorModel _documentSnapshotToCollaboratorModel(
      DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final result = CollaboratorModel.fromMap(data);
    return result.copyWith(id: snapshot.id);
  }
}
