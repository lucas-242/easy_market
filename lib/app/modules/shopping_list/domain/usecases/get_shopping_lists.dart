import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/shopping_list.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/repositories/shopping_list_repository.dart';
part 'get_shopping_lists.g.dart';

abstract class GetShoppingLists {
  Future<Either<Failure, List<ShoppingList>>> call();
}

@Injectable(singleton: false)
class GetShoppingListsImpl implements GetShoppingLists {
  ShoppingListRepository repository;

  GetShoppingListsImpl(this.repository);

  @override
  Future<Either<Failure, List<ShoppingList>>> call() async {
    var result = await repository.getShoppingLists();
    return result;
  }
}
