import 'package:dartz/dartz.dart';
import 'package:easy_market/app/modules/shopping_list/domain/repositories/shopping_list_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/modules/shopping_list/domain/entities/item.dart';
import 'package:easy_market/app/core/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
part 'delete_item_from_list.g.dart';

abstract class DeleteItemFromList {
  Future<Either<Failure, Unit>> call(Item item);
}

@Injectable(singleton: false)
class DeleteItemFromListImpl implements DeleteItemFromList {
  final ShoppingListRepository repository;
  DeleteItemFromListImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(Item item) async {
    var validateResult = _validateItem(item);
    if (validateResult != null) return validateResult;
    return await _deleteItem(item);
  }

  Either<Failure, Unit>? _validateItem(Item item) {
    if (item.id.isEmpty) {
      return Left(InvalidShoppingList());
    }
    return null;
  }

  Future<Either<Failure, Unit>> _deleteItem(Item item) async {
    var result = repository.deleteItemFromList(item);
    return result;
  }
}
