import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';

import 'package:market_lists/app/modules/grocery/infra/datasources/grocery_datasource.dart';
import 'package:market_lists/app/modules/grocery/infra/models/grocery_list_model.dart';

class FirebaseGroceryDatasource implements GroceryDatasource {
  final String groceryListsTable = 'groceryLists';
  final FirebaseFirestore _firestore;
  FirebaseGroceryDatasource(this._firestore);

  @override
  Future<GroceryListModel> createGroceryList(
      GroceryListModel groceryList) async {
    try {
      var reference = _firestore.collection(groceryListsTable).doc();
      var toSave = groceryList.toMapCreateOrUpdate();
      await reference.set(toSave);
      return GroceryListModel(
        id: reference.id,
        name: groceryList.name,
        groceries: [],
      );
    } catch (e) {
      throw GroceryListFailure(message: 'Erro to save data on firebase');
    }
  }

  @override
  Future<void> deleteGroceryList(String id) {
    // TODO: implement deleteGroceryList
    throw UnimplementedError();
  }

  @override
  Future<void> updateGroceryList(GroceryListModel groceryList) {
    // TODO: implement updateGroceryList
    throw UnimplementedError();
  }
}
