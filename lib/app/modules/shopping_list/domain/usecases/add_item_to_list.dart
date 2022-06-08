import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/item.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/repositories/item_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'add_item_to_list.g.dart';

abstract class AddItemToList {
  Future<Either<Failure, Item>> call(Item item);
}

@Injectable(singleton: false)
class AddItemToListImpl implements AddItemToList {
  final ItemRepository repository;
  AddItemToListImpl(this.repository);

  @override
  Future<Either<Failure, Item>> call(Item item) async {
    var validateResult = _validateItem(item);
    if (validateResult != null) return validateResult;
    return await _addShoppingList(item);
  }

  Either<Failure, Item>? _validateItem(Item item) {
    if (item.shoppingListId.isEmpty ||
        !item.isValidName ||
        !item.isValidQuantity) {
      return Left(InvalidShoppingList());
    }
    return null;
  }

  Future<Either<Failure, Item>> _addShoppingList(Item item) async {
    var result = await repository.addItemToList(item);
    return result;
  }
}
