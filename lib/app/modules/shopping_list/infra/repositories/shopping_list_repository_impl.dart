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
    } on Failure catch (e) {
      return left(GetShoppingListFailure(e.message));
    } catch (e) {
      return left(GetShoppingListFailure('Error to get shopping lists.'));
    }
  }

  @override
  Either<Failure, Stream<List<ShoppingList>>> listenShoppingLists(
      String userId) {
    try {
      final result = datasource.listenShoppingLists(userId);
      return right(result);
    } on Failure catch (e) {
      return left(GetShoppingListFailure(e.message));
    } catch (e) {
      return left(GetShoppingListFailure('Error to get shopping lists.'));
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
    } on Failure catch (e) {
      return left(CreateShoppingListFailure(e.message));
    } catch (e) {
      return left(CreateShoppingListFailure('Error to create shopping list.'));
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
    } on Failure catch (e) {
      return left(UpdateShoppingListFailure(e.message));
    } catch (e) {
      return left(UpdateShoppingListFailure('Error to update shopping list.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteShoppingList(
      ShoppingList shoppingList) async {
    try {
      await datasource.deleteShoppingList(shoppingList.id);
      return right(unit);
    } on Failure catch (e) {
      return left(DeleteShoppingListFailure(e.message));
    } catch (e) {
      return left(DeleteShoppingListFailure('Error to delete shopping list.'));
    }
  }

  @override
  Future<Either<Failure, List<Item>>> getItemsFromList(
      String shoppingListId) async {
    try {
      final result = await datasource.getItemsFromList(shoppingListId);
      return right(result);
    } on Failure catch (e) {
      return left(GetItemsFailure(e.message));
    } catch (e) {
      return left(GetItemsFailure('Error to get items.'));
    }
  }

  @override
  Either<Failure, Stream<List<Item>>> listenItemsFromList(
      String shoppingListId) {
    try {
      final result = datasource.listenItemsFromList(shoppingListId);
      return right(result);
    } on Failure catch (e) {
      return left(GetItemsFailure(e.message));
    } catch (e) {
      return left(GetItemsFailure('Error to get items.'));
    }
  }

  @override
  Future<Either<Failure, Item>> addItemToList(Item item) async {
    try {
      final itemToAdd = ItemModel.fromItem(item);
      final result = await datasource.addItemToList(itemToAdd);
      return right(result);
    } on Failure catch (e) {
      return left(AddItemFailure(e.message));
    } catch (e) {
      return left(AddItemFailure('Error to add item.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateItemInList(Item item) async {
    try {
      final itemToUpdate = ItemModel.fromItem(item);
      await datasource.updateItemInList(itemToUpdate);
      return right(unit);
    } on Failure catch (e) {
      return left(UpdateItemFailure(e.message));
    } catch (e) {
      return left(UpdateItemFailure('Error to update item.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteItemFromList(Item item) async {
    try {
      final itemToDelete = ItemModel.fromItem(item);
      await datasource.deleteItemFromList(itemToDelete);
      return right(unit);
    } on Failure catch (e) {
      return left(DeleteItemFailure(e.message));
    } catch (e) {
      return left(DeleteItemFailure('Error to delete item.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> reorderItemInList(Item item,
      {Item? prev, Item? next}) async {
    try {
      await datasource.reorderItemInList(
        ItemModel.fromItem(item),
        prev: prev != null ? ItemModel.fromItem(prev) : null,
        next: next != null ? ItemModel.fromItem(next) : null,
      );
      return right(unit);
    } on Failure catch (e) {
      return left(ReorderItemFailure(e.message));
    } catch (e) {
      return left(ReorderItemFailure('Error to reorder item.'));
    }
  }
}
