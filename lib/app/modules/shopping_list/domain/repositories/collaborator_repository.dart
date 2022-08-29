import 'package:dartz/dartz.dart';
import '../entities/collaborator.dart';

import '../../../../core/errors/errors.dart';

abstract class CollaboratorRepository {
  Stream<Either<Failure, List<Collaborator>>> listenCollaboratorsByEmails(
      List<String> emails);
}
