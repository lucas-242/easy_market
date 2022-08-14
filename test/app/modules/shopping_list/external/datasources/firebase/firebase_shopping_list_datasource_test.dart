import 'package:easy_market/app/modules/shopping_list/external/datasources/firebase/models/firebase_shopping_list_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/external/datasources/firebase/firebase_shopping_list_datasource.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/shopping_list_model.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/item_model.dart';
import 'package:easy_market/app/modules/shopping_list/shopping_list.dart';

import '../../../mock_shopping_list_test.dart';

void main() {
  final database = FakeFirebaseFirestore();
  final datasource = FirebaseShoppingListDatasource(database);

  Future<ShoppingList> _createMockShoppingList(
      {ShoppingListModel? mock}) async {
    final list = mock ?? shoppingList;
    final listReference = await database
        .collection(datasource.shoppingListsTable)
        .add(FirebaseShoppingListModel.fromShoppingListModel(list).toCreate());
    final result = list.copyWith(id: listReference.id);
    return result;
  }

  group('Create ShoppingList', () {
    test('Should create ShoppingList', () async {
      final result = await _createMockShoppingList();
      expect(result.id, isNotEmpty);
      expect(result.name, equals(shoppingList.name));
    });
  });

  group('Get ShoppingList', () {
    test('Should get all ShoppingLists', () async {
      await _createMockShoppingList();
      final result = await datasource.getShoppingLists(userEmail);
      expect(result, isNotEmpty);
      expect(
          result
              .every((element) => element.id.isNotEmpty && element.isValidName),
          true);
    });

    test('Should listen all ShoppingLists', () async {
      await _createMockShoppingList();
      final result = datasource.listenShoppingLists(userEmail);
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
      final shoppingLists = await datasource.getShoppingLists(userEmail);
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
      final shoppingLists = await datasource.getShoppingLists(userEmail);
      final result = shoppingLists
          .firstWhere((element) => element.id == shoppingListToUpdate.id);

      expect(result.name, equals(shoppingListToUpdate.name));
    });
  });

  group('Collaborator operations', () {
    const collaboratorEmail = 'collaborator@email.com';

    Future<ShoppingList> getShoppingList(String id) async {
      final shoppingLists = await datasource.getShoppingLists(userEmail);
      return shoppingLists.firstWhere((e) => e.id == id);
    }

    test('Should add collaborator', () async {
      final shoppingList = await _createMockShoppingList();
      await datasource.addCollaboratorToList(
          shoppingList.id, collaboratorEmail);
      final result = await getShoppingList(shoppingList.id);
      expect(result.users, contains(collaboratorEmail));
    });

    test('Should remove collaborator', () async {
      final list = await _createMockShoppingList(
          mock: shoppingList.copyWith(users: [userEmail, collaboratorEmail]));
      await datasource.removeCollaboratorFromList(list.id, collaboratorEmail);
      final result = await getShoppingList(list.id);
      expect(result.users, isNot(contains(collaboratorEmail)));
    });
  });

  group('Item', () {
    late ShoppingListModel mockShoppingList;
    late ItemModel mockItem;

    Future<void> _setUpMockShoppingList() async {
      final listReference = await database
          .collection(datasource.shoppingListsTable)
          .add(FirebaseShoppingListModel.fromShoppingListModel(shoppingList)
              .toCreate());
      mockShoppingList = shoppingList.copyWith(id: listReference.id);
    }

    Future<void> _setUpMockItem() async {
      final itemToAdd = item.copyWith(shoppingListId: mockShoppingList.id);
      final itemReference = await database
          .collection(datasource.shoppingListsTable)
          .doc(itemToAdd.shoppingListId)
          .collection(datasource.itemsTable)
          .add(itemToAdd.toCreate());

      mockItem = itemToAdd.copyWith(
        name: 'New Name',
        quantity: 40,
        id: itemReference.id,
      );
    }

    setUp(() async {
      await _setUpMockShoppingList();
      await _setUpMockItem();
    });

    test('Should add Item', () async {
      final itemToAdd = mockItem.copyWith(shoppingListId: mockShoppingList.id);
      final result = await datasource.addItemToList(itemToAdd);
      expect(result.id, isNotEmpty);
      expect(result.shoppingListId, equals(mockShoppingList.id));
    });

    test('Should Get Items', () async {
      final result = await datasource.getItemsFromList(mockShoppingList.id);
      expect(result, isNotEmpty);
    });

    test('Should Listem Items stream', () async {
      final result = datasource.listenItemsFromList(mockShoppingList.id);
      result.listen((data) {
        expect(data, isNotEmpty);
        expect(
            data.every(
                (element) => element.shoppingListId == mockShoppingList.id),
            true);
      });
    });

    test('Should update Item', () async {
      final itemToUpdate = mockItem.copyWith(name: 'updated name');
      await datasource.updateItemInList(itemToUpdate);
      final itemsFromShoppingList =
          await datasource.getItemsFromList(itemToUpdate.shoppingListId);
      final result = itemsFromShoppingList
          .firstWhere((element) => element.id == itemToUpdate.id);
      expect(result.name, equals(itemToUpdate.name));
      expect(result.quantity, equals(itemToUpdate.quantity));
    });

    test('Should delete Item', () async {
      await datasource.deleteItemFromList(mockItem);
      final itemsFromShoppingList =
          await datasource.getItemsFromList(mockItem.shoppingListId);
      final result =
          itemsFromShoppingList.where((element) => element.id == mockItem.id);
      expect(result, isEmpty);
    });

    test('Should reorder Item', () async {
      var itemToAdd = mockItem.copyWith(name: 'new item');
      itemToAdd = await datasource.addItemToList(itemToAdd);

      final itemsFromShoppingList =
          await datasource.getItemsFromList(itemToAdd.shoppingListId);
      final firstItem = itemsFromShoppingList.first;
      await datasource.reorderItemInList(itemToAdd, next: firstItem);

      final reorderedItems =
          await datasource.getItemsFromList(itemToAdd.shoppingListId);
      expect(reorderedItems.first.id, itemToAdd.id);
      expect(reorderedItems[1].id, equals(firstItem.id));
    });

    test('Should check Item', () async {
      var itemToAdd = mockItem.copyWith(name: 'new item');
      itemToAdd = await datasource.addItemToList(itemToAdd);

      await datasource.checkItemInList(
          itemToAdd.shoppingListId, itemToAdd.id, !itemToAdd.isChecked);

      final allItems =
          await datasource.getItemsFromList(itemToAdd.shoppingListId);
      final result = allItems.firstWhere((item) => item.id == itemToAdd.id);

      expect(result.isChecked, equals(!itemToAdd.isChecked));
    });
  });
}
