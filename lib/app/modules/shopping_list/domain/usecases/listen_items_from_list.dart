import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/item.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/repositories/item_repository.dart';

abstract class ListenItemsFromList {
  Either<Failure, Stream<List<Item>>> call(String shoppingListId);
}

class ListenItemsFromListImpl implements ListenItemsFromList {
  ItemRepository repository;

  ListenItemsFromListImpl(this.repository);

  @override
  Either<Failure, Stream<List<Item>>> call(String shoppingListId) {
    var result = repository.listenItemsFromList(shoppingListId);
    return result;
  }
}
