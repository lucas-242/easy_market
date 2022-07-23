import 'package:easy_market/app/modules/shopping_list/domain/entities/item.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/item_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/core/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/entities/shopping_list.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/repositories/shopping_list_repository.dart';
import 'package:easy_market/app/modules/shopping_list/infra/datasources/shopping_list_datasource.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/shopping_list_model.dart';
part 'shopping_list_repository_impl.g.dart';

@Injectable(singleton: false)
class ShoppingListRepositoryImpl implements ShoppingListRepository {
  final ShoppingListDatasource datasource;

  ShoppingListRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<ShoppingList>>> getShoppingLists(
      String userId) async {
    try {
      final result = await datasource.getShoppingLists(userId);
      return right(result);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }

  @override
  Either<Failure, Stream<List<ShoppingList>>> listenShoppingLists(
      String userId) {
    try {
      final result = datasource.listenShoppingLists(userId);
      return right(result);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }

  @override
  Future<Either<Failure, ShoppingList>> createShoppingList(
      ShoppingList shoppingList) async {
    try {
      final shoppingListToCreate =
          ShoppingListModel.fromShoppingList(shoppingList);
      final result = await datasource.createShoppingList(shoppingListToCreate);
      return right(result);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteShoppingList(
      ShoppingList shoppingList) async {
    try {
      await datasource.deleteShoppingList(shoppingList.id);
      return right(unit);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateShoppingList(
      ShoppingList shoppingList) async {
    try {
      final shoppingListToUpdate =
          ShoppingListModel.fromShoppingList(shoppingList);
      await datasource.updateShoppingList(shoppingListToUpdate);
      return right(unit);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }

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
