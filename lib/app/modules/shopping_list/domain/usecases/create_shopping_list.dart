import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../entities/shopping_list.dart';
import '../../../../core/errors/errors.dart';
import '../errors/errors.dart';
import '../repositories/shopping_list_repository.dart';
part 'create_shopping_list.g.dart';

abstract class CreateShoppingList {
  Future<Either<Failure, ShoppingList>> call(ShoppingList shoppingList);
}

@Injectable(singleton: false)
class CreateShoppingListImpl implements CreateShoppingList {
  final ShoppingListRepository repository;
  CreateShoppingListImpl(this.repository);

  @override
  Future<Either<Failure, ShoppingList>> call(ShoppingList shoppingList) async {
    var validateResult = _validateShoppingList(shoppingList);
    if (validateResult != null) return validateResult;
    return await _createShoppingList(shoppingList);
  }

  Either<Failure, ShoppingList>? _validateShoppingList(
      ShoppingList shoppingList) {
    if (shoppingList.owner.isEmpty) {
      return Left(
          InvalidShoppingList(message: AppLocalizations.current.invalidOwner));
    }
    if (!shoppingList.isValidName) {
      return Left(
          InvalidShoppingList(message: AppLocalizations.current.invalidName));
    }
    return null;
  }

  Future<Either<Failure, ShoppingList>> _createShoppingList(
      ShoppingList shoppingList) async {
    var result = await repository.createShoppingList(shoppingList);
    return result;
  }
}
