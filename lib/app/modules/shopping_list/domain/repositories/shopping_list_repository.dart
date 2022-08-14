import 'package:dartz/dartz.dart';
import '../entities/item.dart';
import '../entities/shopping_list.dart';
import '../../../../core/errors/errors.dart';

abstract class ShoppingListRepository {
  Future<Either<Failure, Unit>> addCollaboratorToList(
      String shoppingListId, String email);
  Future<Either<Failure, Unit>> removeCollaboratorFromList(
      String shoppingListId, String email);
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
  Future<Either<Failure, Unit>> reorderItemInList(Item item,
      {Item? prev, Item? next});
  Future<Either<Failure, Unit>> checkItemInList(
      String shoppingListId, String itemId, bool isChecked);
}
