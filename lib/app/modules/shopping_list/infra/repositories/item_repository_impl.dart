import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/core/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/item.dart';
import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/repositories/item_repository.dart';
import 'package:market_lists/app/modules/shopping_list/infra/datasources/shopping_list_datasource.dart';
import 'package:market_lists/app/modules/shopping_list/infra/models/item_model.dart';
part 'item_repository_impl.g.dart';

@Injectable(singleton: false)
class ItemRepositoryImpl implements ItemRepository {
  final ShoppingListDatasource datasource;

  ItemRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<Item>>> getItemsFromList(
      String shoppingListId) async {
    try {
      var result = await datasource.getItemsFromList(shoppingListId);
      return right(result);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }

  @override
  Either<Failure, Stream<List<Item>>> listenItemsFromList(
      String shoppingListId) {
    try {
      var result = datasource.listenItemsFromList(shoppingListId);
      return right(result);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }

  @override
  Future<Either<Failure, Item>> addItemToList(Item item) async {
    try {
      var itemToAdd = ItemModel.fromItem(item);
      var result = await datasource.addItemToList(itemToAdd);
      return right(result);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateItemInList(Item item) async {
    try {
      var itemToUpdate = ItemModel.fromItem(item);
      await datasource.updateItemInList(itemToUpdate);
      return right(unit);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteItemFromList(Item item) async {
    try {
      await datasource.deleteItemFromList(item.id);
      return right(unit);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }
}
