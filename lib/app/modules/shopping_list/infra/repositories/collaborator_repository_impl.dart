import '../../domain/entities/collaborator.dart';

import '../../../../core/errors/errors.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/l10n/generated/l10n.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/collaborator_repository.dart';
import '../datasources/collaborator_datasource.dart';
part 'collaborator_repository_impl.g.dart';

@Injectable(singleton: false)
class CollaboratorRepositoryImpl implements CollaboratorRepository {
  final CollaboratorDatasource datasource;

  CollaboratorRepositoryImpl(this.datasource);

  @override
  Stream<Either<Failure, List<Collaborator>>> listenCollaboratorsByEmails(
      List<String> emails) {
    try {
      return datasource
          .listenCollaboratorsByEmails(emails)
          .map((event) => right(event));
    } on Failure catch (e) {
      return Stream.value(left(GetCollaboratorsFailure(e.message)));
    } catch (e) {
      return Stream.value(left(GetCollaboratorsFailure(
          AppLocalizations.current.errorToRemoveCollaborator)));
    }
  }
}
