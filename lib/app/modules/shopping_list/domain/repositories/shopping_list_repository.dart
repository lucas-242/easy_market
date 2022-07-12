import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/shopping_list.dart';
import 'package:market_lists/app/core/errors/errors.dart';

abstract class ShoppingListRepository {
  Future<Either<Failure, List<ShoppingList>>> getShoppingLists();
  Either<Failure, Stream<List<ShoppingList>>> listenShoppingLists();
  Future<Either<Failure, ShoppingList>> createShoppingList(
      ShoppingList shoppingList);
  Future<Either<Failure, Unit>> updateShoppingList(ShoppingList shoppingList);
  Future<Either<Failure, Unit>> deleteShoppingList(ShoppingList shoppingList);
}
