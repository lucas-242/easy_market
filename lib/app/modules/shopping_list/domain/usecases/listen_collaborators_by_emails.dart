import 'package:dartz/dartz.dart';
import 'package:easy_market/app/modules/shopping_list/domain/entities/collaborator.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/repositories/collaborator_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/l10n/generated/l10n.dart';
part 'listen_collaborators_by_emails.g.dart';

abstract class ListenCollaboratorsByEmails {
  Stream<Either<Failure, List<Collaborator>>> call(List<String> emails);
}

@Injectable(singleton: false)
class ListenCollaboratorsByEmailsImpl implements ListenCollaboratorsByEmails {
  CollaboratorRepository repository;

  ListenCollaboratorsByEmailsImpl(this.repository);

  @override
  Stream<Either<Failure, List<Collaborator>>> call(List<String> emails) {
    final validateResult = _validate(emails);
    if (validateResult != null) return Stream.value(validateResult);
    return repository.listenCollaboratorsByEmails(emails);
  }

  Either<Failure, List<Collaborator>>? _validate(List<String> emails) {
    if (emails.isEmpty) {
      return Left(GetCollaboratorsFailure(
          AppLocalizations.current.invalidProperty('emails')));
    }

    return null;
  }
}
