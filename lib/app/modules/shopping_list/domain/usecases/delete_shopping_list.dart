import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../entities/shopping_list.dart';
import '../../../../core/errors/errors.dart';
import '../errors/errors.dart';
import '../repositories/shopping_list_repository.dart';
part 'delete_shopping_list.g.dart';

abstract class DeleteShoppingList {
  Future<Either<Failure, Unit>> call(ShoppingList shoppingList);
}

@Injectable(singleton: false)
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
