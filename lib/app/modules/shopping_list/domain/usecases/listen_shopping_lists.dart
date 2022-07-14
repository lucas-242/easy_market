import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/modules/shopping_list/domain/entities/shopping_list.dart';
import 'package:easy_market/app/core/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/repositories/shopping_list_repository.dart';
part 'listen_shopping_lists.g.dart';

abstract class ListenShoppingLists {
  Either<Failure, Stream<List<ShoppingList>>> call();
}

@Injectable(singleton: false)
class ListenShoppingListsImpl implements ListenShoppingLists {
  ShoppingListRepository repository;

  ListenShoppingListsImpl(this.repository);

  @override
  Either<Failure, Stream<List<ShoppingList>>> call() {
    var result = repository.listenShoppingLists();
    return result;
  }
}
