import 'package:dartz/dartz.dart';
import '../repositories/shopping_list_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../entities/item.dart';
import '../../../../core/errors/errors.dart';
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
