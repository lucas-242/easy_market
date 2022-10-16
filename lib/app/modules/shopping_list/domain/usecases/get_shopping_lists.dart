import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/errors/errors.dart';
import '../entities/shopping_list.dart';
import '../repositories/shopping_list_repository.dart';

part 'get_shopping_lists.g.dart';

abstract class GetShoppingLists {
  Future<Either<Failure, List<ShoppingList>>> call(String userId);
}

@Injectable(singleton: false)
class GetShoppingListsImpl implements GetShoppingLists {
  ShoppingListRepository repository;

  GetShoppingListsImpl(this.repository);

  @override
  Future<Either<Failure, List<ShoppingList>>> call(String userId) async {
    final result = await repository.getShoppingLists(userId);
    return result;
  }
}
