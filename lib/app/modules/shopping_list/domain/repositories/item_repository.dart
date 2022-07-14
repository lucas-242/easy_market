import 'package:dartz/dartz.dart';
import 'package:easy_market/app/modules/shopping_list/domain/entities/item.dart';
import 'package:easy_market/app/core/errors/errors.dart';

abstract class ItemRepository {
  Future<Either<Failure, List<Item>>> getItemsFromList(String shoppingListId);
  Either<Failure, Stream<List<Item>>> listenItemsFromList(
      String shoppingListId);
  Future<Either<Failure, Item>> addItemToList(Item item);
  Future<Either<Failure, Unit>> updateItemInList(Item item);
  Future<Either<Failure, Unit>> deleteItemFromList(Item item);
}
