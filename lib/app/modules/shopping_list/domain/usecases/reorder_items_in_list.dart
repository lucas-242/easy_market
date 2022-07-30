import 'package:dartz/dartz.dart';
import 'package:easy_market/app/core/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/entities/item.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/repositories/shopping_list_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'reorder_items_in_list.g.dart';

abstract class ReorderItemInList {
  Future<Either<Failure, Unit>> call(Item item, {Item? prev, Item? next});
}

@Injectable(singleton: false)
class ReorderItemInListImpl implements ReorderItemInList {
  final ShoppingListRepository repository;
  ReorderItemInListImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(Item item,
      {Item? prev, Item? next}) async {
    final validateResult = _validate(prev, next);
    if (validateResult != null) return validateResult;
    return await _reorderItems(item, prev, next);
  }

  Either<Failure, Unit>? _validate(Item? prev, Item? next) {
    if (prev == null && next == null) {
      return Left(ReorderItemFailure(
          ShoppingListErrorMessages.oneItemNeedToBeInformed));
    }
    return null;
  }

  Future<Either<Failure, Unit>> _reorderItems(
      Item item, Item? prev, Item? next) {
    final result = repository.reorderItemInList(item, prev: prev, next: next);
    return result;
  }
}
