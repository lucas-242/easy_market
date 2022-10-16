import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../domain/entities/item.dart';
import '../../domain/entities/shopping_list.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/shopping_list_repository.dart';
import '../datasources/shopping_list_datasource.dart';
import '../models/item_model.dart';
import '../models/shopping_list_model.dart';

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
      return left(
          GetShoppingListFailure(AppLocalizations.current.errorToGetLists));
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
      return left(
          GetShoppingListFailure(AppLocalizations.current.errorToGetLists));
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
      return left(CreateShoppingListFailure(
          AppLocalizations.current.errorToCreateList));
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
      return left(UpdateShoppingListFailure(
          AppLocalizations.current.errorToUpdateList));
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
      return left(DeleteShoppingListFailure(
          AppLocalizations.current.errorToDeleteList));
    }
  }

  @override
  Future<Either<Failure, Unit>> addCollaboratorToList(
    String shoppingListId,
    String email,
  ) async {
    try {
      await datasource.addCollaboratorToList(shoppingListId, email);
      return right(unit);
    } on Failure catch (e) {
      return left(AddCollaboratorFailure(e.message));
    } catch (e) {
      return left(AddCollaboratorFailure(
          AppLocalizations.current.errorToAddCollaborator));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeCollaboratorFromList(
    String shoppingListId,
    String email,
  ) async {
    try {
      await datasource.removeCollaboratorFromList(shoppingListId, email);
      return right(unit);
    } on Failure catch (e) {
      return left(RemoveCollaboratorFailure(e.message));
    } catch (e) {
      return left(RemoveCollaboratorFailure(
          AppLocalizations.current.errorToRemoveCollaborator));
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
      return left(GetItemsFailure(AppLocalizations.current.errorToGetItems));
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
      return left(GetItemsFailure(AppLocalizations.current.errorToGetItems));
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
      return left(AddItemFailure(AppLocalizations.current.errorToAddItem));
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
      return left(
          UpdateItemFailure(AppLocalizations.current.errorToUpdateItem));
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
      return left(
          DeleteItemFailure(AppLocalizations.current.errorToDeleteItem));
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
      return left(
          ReorderItemFailure(AppLocalizations.current.errorToReorderItems));
    }
  }

  @override
  Future<Either<Failure, Unit>> checkItemInList(
      String shoppingListId, String itemId, bool isChecked) async {
    try {
      await datasource.checkItemInList(shoppingListId, itemId, isChecked);
      return right(unit);
    } on Failure catch (e) {
      return left(CheckItemFailure(e.message));
    } catch (e) {
      return left(CheckItemFailure(AppLocalizations.current.errorToUpdateItem));
    }
  }
}
