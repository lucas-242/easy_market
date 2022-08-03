import 'package:dartz/dartz.dart';
import '../repositories/shopping_list_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../entities/item.dart';
import '../../../../core/errors/errors.dart';
import '../errors/errors.dart';
part 'update_item_in_list.g.dart';

abstract class UpdateItemInList {
  Future<Either<Failure, Unit>> call(Item item);
}

@Injectable(singleton: false)
class UpdateItemInListImpl implements UpdateItemInList {
  final ShoppingListRepository repository;
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
