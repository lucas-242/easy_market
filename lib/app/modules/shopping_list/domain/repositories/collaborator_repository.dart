import 'package:dartz/dartz.dart';
import 'package:easy_market/app/modules/shopping_list/domain/entities/collaborator.dart';

import '../../../../core/errors/errors.dart';

abstract class CollaboratorRepository {
  Stream<Either<Failure, List<Collaborator>>> listenCollaboratorsByEmails(
      List<String> emails);
}
