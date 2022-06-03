import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/item.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/repositories/item_repository.dart';

abstract class UpdateItemInList {
  Future<Either<Failure, Unit>> call(Item item);
}

class UpdateItemInListImpl implements UpdateItemInList {
  final ItemRepository repository;
  UpdateItemInListImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(Item item) async {
    var validateResult = _validateItem(item);
    if (validateResult != null) return validateResult;
    return await _updateItem(item);
  }

  Either<Failure, Unit>? _validateItem(Item item) {
    if (!item.isValidName || item.id.isEmpty || item.shoppingListId.isEmpty) {
      return Left(InvalidShoppingList());
    }
    return null;
  }

  Future<Either<Failure, Unit>> _updateItem(Item item) async {
    var result = repository.updateItemInList(item);
    return result;
  }
}
