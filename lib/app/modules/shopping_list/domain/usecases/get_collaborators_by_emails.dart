import 'package:dartz/dartz.dart';
import '../entities/collaborator.dart';
import '../repositories/collaborator_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/errors/errors.dart';
part 'get_collaborators_by_emails.g.dart';

abstract class GetCollaboratorsByEmails {
  Future<Either<Failure, List<Collaborator>>> call(List<String> emails);
}

@Injectable(singleton: false)
class GetCollaboratorsByEmailsImpl implements GetCollaboratorsByEmails {
  CollaboratorRepository repository;

  GetCollaboratorsByEmailsImpl(this.repository);

  @override
  Future<Either<Failure, List<Collaborator>>> call(List<String> emails) async {
    final validateResult = _validate(emails);
    if (validateResult != null) return validateResult;
    return repository.getCollaboratorsByEmails(emails);
  }

  Either<Failure, List<Collaborator>>? _validate(List<String> emails) {
    if (emails.isEmpty) {
      return const Right([]);
    }

    return null;
  }
}
