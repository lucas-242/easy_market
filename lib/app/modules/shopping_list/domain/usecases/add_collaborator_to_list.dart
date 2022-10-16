import 'package:dartz/dartz.dart';
import '../../../../core/auth/domain/utils/credentials_validator_util.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/errors/errors.dart';
import '../errors/errors.dart';
import '../repositories/shopping_list_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'add_collaborator_to_list.g.dart';

abstract class AddCollaboratorToList {
  Future<Either<Failure, Unit>> call(String shoppingListId, String email);
}

@Injectable(singleton: false)
class AddCollaboratorToListImpl implements AddCollaboratorToList {
  final ShoppingListRepository repository;
  AddCollaboratorToListImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(
      String shoppingListId, String email) async {
    final validateResult = _validate(shoppingListId, email);
    if (validateResult != null) return validateResult;
    return await _addCollaborator(shoppingListId, email);
  }

  Either<Failure, Unit>? _validate(String shoppingListId, String email) {
    if (shoppingListId.isEmpty) {
      return Left(AddCollaboratorFailure(
          AppLocalizations.current.invalidProperty('shoppingListId')));
    }

    if (!CredentialsValidatorUtil.isAnEmail(email)) {
      return Left(
          AddCollaboratorFailure(AppLocalizations.current.emailIsInvalid));
    }

    return null;
  }

  Future<Either<Failure, Unit>> _addCollaborator(
      String shoppingListId, String email) async {
    final result =
        await repository.addCollaboratorToList(shoppingListId, email);
    return result;
  }
}
