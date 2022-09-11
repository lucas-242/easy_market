import '../models/collaborator_model.dart';

abstract class CollaboratorDatasource {
  Stream<List<CollaboratorModel>> listenCollaboratorsByEmails(
      List<String> emails);
  Future<List<CollaboratorModel>> getCollaboratorsByEmails(List<String> emails);
}
