import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/grocery/external/datasources/firebase/firebase_grocery_datasource.dart';
import 'package:market_lists/app/modules/grocery/grocery.dart';
import 'package:market_lists/app/modules/grocery/infra/models/grocery_list_model.dart';

import '../../../mock_groceries_test.dart' as mock;

void main() {
  final database = FakeFirebaseFirestore();
  final datasource = FirebaseGroceryDatasource(database);

  Future<GroceryList> _createMockGroceryList() async {
    var groceryList = mock.groceryListModelToCreate;
    var result = await datasource.createGroceryList(groceryList);
    return result;
  }

  group('Create GroceryList', () {
    test('Should create GroceryList', () async {
      var result = await _createMockGroceryList();
      expect(result.id, isNotEmpty);
      expect(result.name, mock.groceryListModelToCreate.name);
    });
  });

  group('Get GroceryList', () {
    test('Should get all GroceryLists', () async {
      await _createMockGroceryList();
      var result = await datasource.getGroceryLists();
      expect(result, isNotEmpty);
      expect(
          result
              .every((element) => element.id.isNotEmpty && element.isValidName),
          true);
    });

    test('Should listen all GroceryLists', () async {
      await _createMockGroceryList();
      var result = datasource.listenGroceryLists();
      result.listen((data) {
        expect(data, isNotEmpty);
        expect(data.every((element) => element.id.isNotEmpty), true);
      });
    });
  });

  group('Delete GroceryList', () {
    test('Should delete GroceryList', () async {
      var groceryListToDelete = await _createMockGroceryList();
      await datasource.deleteGroceryList(groceryListToDelete.id);
      var groceryLists = await datasource.getGroceryLists();
      expect(groceryLists.map((e) => e.id),
          isNot(contains(groceryListToDelete.id)));
    });
  });

  group('Update GroceryList', () {
    Future<GroceryListModel> _setupUpdateTest() async {
      var groceryListCreated = await _createMockGroceryList();
      var newName = 'testing update';
      var groceryListToUpdate =
          GroceryListModel.fromGroceryList(groceryListCreated)
              .copyWith(name: newName);
      return groceryListToUpdate;
    }

    test('Should update GroceryList', () async {
      var groceryListToUpdate = await _setupUpdateTest();
      await datasource.updateGroceryList(groceryListToUpdate);
      var groceryLists = await datasource.getGroceryLists();
      var result = groceryLists
          .firstWhere((element) => element.id == groceryListToUpdate.id);

      expect(result.name, groceryListToUpdate.name);
    });
  });

  group('Add Grocery', () {
    test('Should add Grocery', () async {
      var grocery = mock.groceryModelToAdd;
      var result = await datasource.addGroceryToList(grocery);
      expect(result.id, isNotEmpty);
      expect(result.groceryListId, isNotEmpty);
    });
  });
}
