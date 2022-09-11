import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/l10n/generated/l10n.dart';
import '../../../domain/errors/errors.dart';
import '../../../infra/datasources/collaborator_datasource.dart';
import '../../../infra/models/collaborator_model.dart';

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
  Future<List<CollaboratorModel>> getCollaboratorsByEmails(
      List<String> emails) async {
    try {
      final snapshot = await _firestore
          .collection(usersTable)
          .where('email', whereIn: emails)
          .get();

      final result = _mapToCollaboratorModelList(snapshot, emails);
      return result;
    } catch (error) {
      throw GetCollaboratorsFailure(
          AppLocalizations.current.errorToGetCollaborators);
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

      final result = _querySnapshotToCollaboratorModel(snapshot, emails);
      return result;
    } catch (error) {
      throw GetCollaboratorsFailure(
          AppLocalizations.current.errorToGetCollaborators);
    }
  }

  Stream<List<CollaboratorModel>> _querySnapshotToCollaboratorModel(
      Stream<QuerySnapshot<Object?>> snapshot, List<String> emails) {
    final result = snapshot
        .handleError((error) => GetCollaboratorsFailure(
            AppLocalizations.current.errorToGetCollaborators))
        .map((query) => _mapToCollaboratorModelList(query, emails));
    return result;
  }

  List<CollaboratorModel> _mapToCollaboratorModelList(
      QuerySnapshot<Object?> querySnapshot, List<String> emails) {
    final result = querySnapshot.docs
        .map((DocumentSnapshot document) =>
            _documentSnapshotToCollaboratorModel(document))
        .toList();

    final notSavedCollaborators =
        _generateNotSavedCollaborators(emails, result);
    result.addAll(notSavedCollaborators);

    return result;
  }

  CollaboratorModel _documentSnapshotToCollaboratorModel(
      DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final result = CollaboratorModel.fromMap(data);
    return result.copyWith(id: snapshot.id);
  }

  ///* Firebase implementation doesn't save collaborators that were invited, only collaborators that registered by themselves
  List<CollaboratorModel> _generateNotSavedCollaborators(
      List<String> emails, List<CollaboratorModel> savedCollaborators) {
    final result = <CollaboratorModel>[];
    final collaboratorEmails = savedCollaborators.map((e) => e.email);
    final notSavedEmails =
        emails.where((email) => !collaboratorEmails.contains(email));

    for (var email in notSavedEmails) {
      result.add(CollaboratorModel(
        name: email.split('@')[0],
        email: email,
        isAlreadyUser: false,
      ));
    }

    return result;
  }
}
