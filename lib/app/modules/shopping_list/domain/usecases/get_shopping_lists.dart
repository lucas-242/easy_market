import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/shopping_list.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/repositories/shopping_list_repository.dart';

abstract class GetShoppingLists {
  Future<Either<Failure, List<ShoppingList>>> call();
}

class GetShoppingListsImpl implements GetShoppingLists {
  ShoppingListRepository itemRepository;

  GetShoppingListsImpl(this.itemRepository);

  @override
  Future<Either<Failure, List<ShoppingList>>> call() async {
    var result = await itemRepository.getShoppingLists();
    return result;
  }
}
