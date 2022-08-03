import 'package:dartz/dartz.dart';
import '../repositories/shopping_list_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../entities/item.dart';
import '../../../../core/errors/errors.dart';
import '../errors/errors.dart';
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
