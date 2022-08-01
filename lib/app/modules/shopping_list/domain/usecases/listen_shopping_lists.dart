import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../entities/shopping_list.dart';
import '../../../../core/errors/errors.dart';
import '../repositories/shopping_list_repository.dart';
part 'listen_shopping_lists.g.dart';

abstract class ListenShoppingLists {
  Either<Failure, Stream<List<ShoppingList>>> call(String userId);
}

@Injectable(singleton: false)
class ListenShoppingListsImpl implements ListenShoppingLists {
  ShoppingListRepository repository;

  ListenShoppingListsImpl(this.repository);

  @override
  Either<Failure, Stream<List<ShoppingList>>> call(String userId) {
    var result = repository.listenShoppingLists(userId);
    return result;
  }
}
