import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/shopping_list/external/datasources/firebase/firebase_shopping_list_datasource.dart';
import 'package:market_lists/app/modules/shopping_list/infra/models/shopping_list_model.dart';
import 'package:market_lists/app/modules/shopping_list/infra/models/item_model.dart';
import 'package:market_lists/app/modules/shopping_list/shopping_list.dart';

import '../../../mock_shopping_list_test.dart' as mock;

void main() {
  final database = FakeFirebaseFirestore();
  final datasource = FirebaseShoppingListDatasource(database);

  Future<ShoppingList> _createMockShoppingList() async {
    var shoppingList = mock.shoppingListModelToCreate;
    var listReference = await database
        .collection(datasource.shoppingListsTable)
        .add(shoppingList.toMapCreate());
    var result = shoppingList.copyWith(id: listReference.id);
    return result;
  }

  group('Create ShoppingList', () {
    test('Should create ShoppingList', () async {
      var result = await _createMockShoppingList();
      expect(result.id, isNotEmpty);
      expect(result.name, mock.shoppingListModelToCreate.name);
    });
  });

  group('Get ShoppingList', () {
    test('Should get all ShoppingLists', () async {
      await _createMockShoppingList();
      var result = await datasource.getShoppingLists();
      expect(result, isNotEmpty);
      expect(
          result
              .every((element) => element.id.isNotEmpty && element.isValidName),
          true);
    });

    test('Should listen all ShoppingLists', () async {
      await _createMockShoppingList();
      var result = datasource.listenShoppingLists();
      result.listen((data) {
        expect(data, isNotEmpty);
        expect(data.every((element) => element.id.isNotEmpty), true);
      });
    });
  });

  group('Delete ShoppingList', () {
    test('Should delete ShoppingList', () async {
      var shoppingListToDelete = await _createMockShoppingList();
      await datasource.deleteShoppingList(shoppingListToDelete.id);
      var shoppingLists = await datasource.getShoppingLists();
      expect(shoppingLists.map((e) => e.id),
          isNot(contains(shoppingListToDelete.id)));
    });
  });

  group('Update ShoppingList', () {
    Future<ShoppingListModel> _setupUpdateTest() async {
      var shoppingListCreated = await _createMockShoppingList();
      var newName = 'testing update';
      var shoppingListToUpdate =
          ShoppingListModel.fromShoppingList(shoppingListCreated)
              .copyWith(name: newName);
      return shoppingListToUpdate;
    }

    test('Should update ShoppingList', () async {
      var shoppingListToUpdate = await _setupUpdateTest();
      await datasource.updateShoppingList(shoppingListToUpdate);
      var shoppingLists = await datasource.getShoppingLists();
      var result = shoppingLists
          .firstWhere((element) => element.id == shoppingListToUpdate.id);

      expect(result.name, shoppingListToUpdate.name);
    });
  });

  group('Item', () {
    late ShoppingListModel shoppingList;
    late ItemModel item;

    setUp(() async {
      var shoppingListToCreate = mock.shoppingListModelToCreate;
      var listReference = await database
          .collection(datasource.shoppingListsTable)
          .add(shoppingListToCreate.toMapCreate());
      shoppingList = shoppingListToCreate.copyWith(id: listReference.id);

      var itemToAdd =
          mock.itemModelToAdd.copyWith(shoppingListId: shoppingList.id);
      var itemReference = await database
          .collection(datasource.itemsTable)
          .add(itemToAdd.toMapCreate());

      item = itemToAdd.copyWith(
        name: 'New Name',
        quantity: 40,
        id: itemReference.id,
      );
    });

    test('Should add Item', () async {
      var itemToAdd =
          mock.itemModelToAdd.copyWith(shoppingListId: shoppingList.id);
      var result = await datasource.addItemToList(itemToAdd);
      expect(result.id, isNotEmpty);
      expect(result.shoppingListId, shoppingList.id);
    });

    test('Should Get Items', () async {
      var result = await datasource.getItemsFromList(shoppingList.id);
      expect(result, isNotEmpty);
    });

    test('Should update Item', () async {
      var itemToUpdate = item.copyWith(name: 'updated name');
      await datasource.updateItemInList(itemToUpdate);
      var itemsFromShoppingList =
          await datasource.getItemsFromList(itemToUpdate.shoppingListId);
      var result = itemsFromShoppingList
          .firstWhere((element) => element.id == itemToUpdate.id);
      expect(result.name, itemToUpdate.name);
      expect(result.quantity, itemToUpdate.quantity);
    });
  });
}
