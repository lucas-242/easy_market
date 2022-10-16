import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/auth/domain/utils/credentials_validator_util.dart';
import '../../../../core/errors/errors.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../errors/errors.dart';
import '../repositories/shopping_list_repository.dart';

part 'remove_collaborator_from_list.g.dart';

abstract class RemoveCollaboratorFromList {
  Future<Either<Failure, Unit>> call(String shoppingListId, String email);
}

@Injectable(singleton: false)
class RemoveCollaboratorFromListImpl implements RemoveCollaboratorFromList {
  final ShoppingListRepository repository;
  RemoveCollaboratorFromListImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(
      String shoppingListId, String email) async {
    final validateResult = _validate(shoppingListId, email);
    if (validateResult != null) return validateResult;
    return await _removeCollaborator(shoppingListId, email);
  }

  Either<Failure, Unit>? _validate(String shoppingListId, String email) {
    if (shoppingListId.isEmpty) {
      return Left(RemoveCollaboratorFailure(
          AppLocalizations.current.invalidProperty('shoppingListId')));
    }

    if (!CredentialsValidatorUtil.isAnEmail(email)) {
      return Left(
          RemoveCollaboratorFailure(AppLocalizations.current.emailIsInvalid));
    }

    return null;
  }

  Future<Either<Failure, Unit>> _removeCollaborator(
      String shoppingListId, String email) async {
    final result =
        await repository.removeCollaboratorFromList(shoppingListId, email);
    return result;
  }
}
