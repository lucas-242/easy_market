import 'package:dartz/dartz.dart';
import 'package:easy_market/app/modules/shopping_list/domain/entities/item.dart';
import 'package:easy_market/app/modules/shopping_list/domain/entities/shopping_list.dart';
import 'package:easy_market/app/core/errors/errors.dart';

abstract class ShoppingListRepository {
  Future<Either<Failure, List<ShoppingList>>> getShoppingLists(String userId);
  Either<Failure, Stream<List<ShoppingList>>> listenShoppingLists(
      String userId);
  Future<Either<Failure, ShoppingList>> createShoppingList(
      ShoppingList shoppingList);
  Future<Either<Failure, Unit>> updateShoppingList(ShoppingList shoppingList);
  Future<Either<Failure, Unit>> deleteShoppingList(ShoppingList shoppingList);
  Future<Either<Failure, List<Item>>> getItemsFromList(String shoppingListId);
  Either<Failure, Stream<List<Item>>> listenItemsFromList(
      String shoppingListId);
  Future<Either<Failure, Item>> addItemToList(Item item);
  Future<Either<Failure, Unit>> updateItemInList(Item item);
  Future<Either<Failure, Unit>> deleteItemFromList(Item item);
}
