import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/shopping_list.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/repositories/shopping_list_repository.dart';

abstract class UpdateShoppingList {
  Future<Either<Failure, Unit>> call(ShoppingList shoppingList);
}

class UpdateShoppingListImpl implements UpdateShoppingList {
  final ShoppingListRepository repository;
  UpdateShoppingListImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ShoppingList shoppingList) async {
    var validateResult = _validateShoppingList(shoppingList);
    if (validateResult != null) return validateResult;
    return await _updateShoppingList(shoppingList);
  }

  Either<Failure, Unit>? _validateShoppingList(ShoppingList shoppingList) {
    if (!shoppingList.isValidName || shoppingList.id.isEmpty) {
      return Left(InvalidShoppingList());
    }
    return null;
  }

  Future<Either<Failure, Unit>> _updateShoppingList(
      ShoppingList shoppingList) async {
    var result = repository.updateShoppingList(shoppingList);
    return result;
  }
}
