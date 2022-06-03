import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/item.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/repositories/item_repository.dart';

abstract class GetItemsFromList {
  Future<Either<Failure, List<Item>>> call(String shoppingListId);
}

class GetItemsFromListImpl implements GetItemsFromList {
  ItemRepository repository;

  GetItemsFromListImpl(this.repository);

  @override
  Future<Either<Failure, List<Item>>> call(String shoppingListId) async {
    var result = await repository.getItemsFromList(shoppingListId);
    return result;
  }
}
