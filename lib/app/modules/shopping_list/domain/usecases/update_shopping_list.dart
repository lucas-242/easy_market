import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../entities/shopping_list.dart';
import '../../../../core/errors/errors.dart';
import '../errors/errors.dart';
import '../repositories/shopping_list_repository.dart';
part 'update_shopping_list.g.dart';

abstract class UpdateShoppingList {
  Future<Either<Failure, Unit>> call(ShoppingList shoppingList);
}

@Injectable(singleton: false)
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
    if (shoppingList.id.isEmpty) {
      return Left(InvalidShoppingList());
    }
    if (shoppingList.owner.isEmpty) {
      return Left(InvalidShoppingList(
          message: ShoppingListErrorMessages.ownerIsInvalid));
    }
    if (!shoppingList.isValidName) {
      return Left(InvalidShoppingList(
          message: ShoppingListErrorMessages.nameIsInvalid));
    }
    return null;
  }

  Future<Either<Failure, Unit>> _updateShoppingList(
      ShoppingList shoppingList) async {
    var result = repository.updateShoppingList(shoppingList);
    return result;
  }
}
