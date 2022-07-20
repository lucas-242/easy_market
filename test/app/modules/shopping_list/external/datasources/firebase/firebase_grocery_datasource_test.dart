import 'package:easy_market/app/modules/shopping_list/external/datasources/firebase/models/firebase_shopping_list_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/external/datasources/firebase/firebase_shopping_list_datasource.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/shopping_list_model.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/item_model.dart';
import 'package:easy_market/app/modules/shopping_list/shopping_list.dart';

import '../../../mock_shopping_list_test.dart' as mock;

void main() {
  final database = FakeFirebaseFirestore();
  final datasource = FirebaseShoppingListDatasource(database);

  Future<ShoppingList> _createMockShoppingList() async {
    final shoppingList = mock.shoppingListModelToCreate;
    final listReference = await database
        .collection(datasource.shoppingListsTable)
        .add(FirebaseShoppingListModel.fromShoppingListModel(shoppingList)
            .toCreate());
    final result = shoppingList.copyWith(id: listReference.id);
    return result;
  }

  group('Create ShoppingList', () {
    test('Should create ShoppingList', () async {
      final result = await _createMockShoppingList();
      expect(result.id, isNotEmpty);
      expect(result.name, mock.shoppingListModelToCreate.name);
    });
  });

  //TODO: Create Errors to ShoppingList module

  group('Get ShoppingList', () {
    test('Should get all ShoppingLists', () async {
      await _createMockShoppingList();
      final result = await datasource.getShoppingLists();
      expect(result, isNotEmpty);
      expect(
          result
              .every((element) => element.id.isNotEmpty && element.isValidName),
          true);
    });

    test('Should listen all ShoppingLists', () async {
      await _createMockShoppingList();
      final result = datasource.listenShoppingLists();
      result.listen((data) {
        expect(data, isNotEmpty);
        expect(data.every((element) => element.id.isNotEmpty), true);
      });
    });
  });

  group('Delete ShoppingList', () {
    test('Should delete ShoppingList', () async {
      final shoppingListToDelete = await _createMockShoppingList();
      await datasource.deleteShoppingList(shoppingListToDelete.id);
      final shoppingLists = await datasource.getShoppingLists();
      expect(shoppingLists.map((e) => e.id),
          isNot(contains(shoppingListToDelete.id)));
    });
  });

  group('Update ShoppingList', () {
    Future<ShoppingListModel> _setupUpdateTest() async {
      final shoppingListCreated = await _createMockShoppingList();
      const newName = 'testing update';
      final shoppingListToUpdate =
          ShoppingListModel.fromShoppingList(shoppingListCreated)
              .copyWith(name: newName);
      return shoppingListToUpdate;
    }

    test('Should update ShoppingList', () async {
      final shoppingListToUpdate = await _setupUpdateTest();
      await datasource.updateShoppingList(shoppingListToUpdate);
      final shoppingLists = await datasource.getShoppingLists();
      final result = shoppingLists
          .firstWhere((element) => element.id == shoppingListToUpdate.id);

      expect(result.name, shoppingListToUpdate.name);
    });
  });

  group('Item', () {
    late ShoppingListModel shoppingList;
    late ItemModel item;

    setUp(() async {
      final shoppingListToCreate = mock.shoppingListModelToCreate;
      final listReference = await database
          .collection(datasource.shoppingListsTable)
          .add(FirebaseShoppingListModel.fromShoppingListModel(
                  shoppingListToCreate)
              .toCreate());
      shoppingList = shoppingListToCreate.copyWith(id: listReference.id);

      final itemToAdd =
          mock.itemModelToAdd.copyWith(shoppingListId: shoppingList.id);
      final itemReference = await database
          .collection(datasource.itemsTable)
          .add(itemToAdd.toCreate());

      item = itemToAdd.copyWith(
        name: 'New Name',
        quantity: 40,
        id: itemReference.id,
      );
    });

    test('Should add Item', () async {
      final itemToAdd =
          mock.itemModelToAdd.copyWith(shoppingListId: shoppingList.id);
      final result = await datasource.addItemToList(itemToAdd);
      expect(result.id, isNotEmpty);
      expect(result.shoppingListId, shoppingList.id);
    });

    test('Should Get Items', () async {
      final result = await datasource.getItemsFromList(shoppingList.id);
      expect(result, isNotEmpty);
    });

    test('Should Listem Items stream', () async {
      final result = datasource.listenItemsFromList(shoppingList.id);
      result.listen((data) {
        expect(data, isNotEmpty);
        expect(
            data.every((element) => element.shoppingListId == shoppingList.id),
            true);
      });
    });

    test('Should update Item', () async {
      final itemToUpdate = item.copyWith(name: 'updated name');
      await datasource.updateItemInList(itemToUpdate);
      final itemsFromShoppingList =
          await datasource.getItemsFromList(itemToUpdate.shoppingListId);
      final result = itemsFromShoppingList
          .firstWhere((element) => element.id == itemToUpdate.id);
      expect(result.name, itemToUpdate.name);
      expect(result.quantity, itemToUpdate.quantity);
    });

    test('Should delete Item', () async {
      await datasource.deleteItemFromList(item.id);
      final itemsFromShoppingList =
          await datasource.getItemsFromList(item.shoppingListId);
      final result =
          itemsFromShoppingList.where((element) => element.id == item.id);
      expect(result, isEmpty);
    });
  });
}
