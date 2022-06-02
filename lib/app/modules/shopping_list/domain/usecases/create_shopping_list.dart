import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/shopping_list.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/repositories/shopping_list_repository.dart';

abstract class CreateShoppingList {
  Future<Either<Failure, ShoppingList>> call(ShoppingList shoppingList);
}

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
    if (!shoppingList.isValidName) {
      return Left(InvalidShoppingList());
    }
    return null;
  }

  Future<Either<Failure, ShoppingList>> _createShoppingList(
      ShoppingList shoppingList) async {
    var result = await repository.createShoppingList(shoppingList);
    return result;
  }
}
