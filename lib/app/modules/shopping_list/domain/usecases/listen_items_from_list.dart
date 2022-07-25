import 'package:dartz/dartz.dart';
import 'package:easy_market/app/modules/shopping_list/domain/repositories/shopping_list_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/modules/shopping_list/domain/entities/item.dart';
import 'package:easy_market/app/core/errors/errors.dart';
part 'listen_items_from_list.g.dart';

abstract class ListenItemsFromList {
  Either<Failure, Stream<List<Item>>> call(String shoppingListId);
}

@Injectable(singleton: false)
class ListenItemsFromListImpl implements ListenItemsFromList {
  ShoppingListRepository repository;

  ListenItemsFromListImpl(this.repository);

  @override
  Either<Failure, Stream<List<Item>>> call(String shoppingListId) {
    var result = repository.listenItemsFromList(shoppingListId);
    return result;
  }
}
