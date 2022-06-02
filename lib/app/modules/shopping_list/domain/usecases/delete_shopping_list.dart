import 'package:dartz/dartz.dart';

import 'package:market_lists/app/modules/shopping_list/domain/entities/shopping_list.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/repositories/shopping_list_repository.dart';

abstract class DeleteShoppingList {
  Future<Either<Failure, Unit>> call(ShoppingList shoppingList);
}

class DeleteShoppingListImpl implements DeleteShoppingList {
  ShoppingListRepository repository;

  DeleteShoppingListImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ShoppingList shoppingList) async {
    var validateResult = _validateShoppingList(shoppingList);
    if (validateResult != null) return validateResult;
    return await _deleteShoppingList(shoppingList);
  }

  Either<Failure, Unit>? _validateShoppingList(ShoppingList shoppingList) {
    if (shoppingList.id.isEmpty) return Left(InvalidShoppingList());
    return null;
  }

  Future<Either<Failure, Unit>> _deleteShoppingList(
      ShoppingList shoppingList) async {
    var result = repository.deleteShoppingList(shoppingList);
    return result;
  }
}
