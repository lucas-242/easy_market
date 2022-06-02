import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';

import 'package:market_lists/app/modules/shopping_list/infra/datasources/shopping_list_datasource.dart';
import 'package:market_lists/app/modules/shopping_list/infra/models/item_model.dart';
import 'package:market_lists/app/modules/shopping_list/infra/models/shopping_list_model.dart';

class FirebaseShoppingListDatasource implements ShoppingListDatasource {
  final String shoppingListsTable = 'shoppingLists';
  final String itemTable = 'item';
  final FirebaseFirestore _firestore;
  FirebaseShoppingListDatasource(this._firestore);

  //TODO: ADD userId in the created data and where clauses to the gets

  @override
  Future<List<ShoppingListModel>> getShoppingLists() async {
    try {
      var reference = _firestore.collection(shoppingListsTable);
      var snapshot = await reference.get();
      var result = _convertQueryDocumentSnapshot(snapshot.docs);
      return result;
    } catch (e) {
      throw ShoppingListFailure(message: 'Erro to get data from firebase');
    }
  }

  List<ShoppingListModel> _convertQueryDocumentSnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshot) {
    var result = snapshot
        .map((e) => ShoppingListModel.fromMap(e.data()).copyWith(id: e.id))
        .toList();
    return result;
  }

  @override
  Stream<List<ShoppingListModel>> listenShoppingLists() {
    try {
      Stream<QuerySnapshot> snapshots =
          _firestore.collection(shoppingListsTable).snapshots();
      var result = _convertQuerySnapshot(snapshots);
      return result;
    } catch (e) {
      throw ShoppingListFailure(message: 'Erro to listen data from firebase');
    }
  }

  Stream<List<ShoppingListModel>> _convertQuerySnapshot(
      Stream<QuerySnapshot<Object?>> snapshot) {
    var result = snapshot.map((query) => query.docs
        .map((DocumentSnapshot document) => _convertDocumentSnapshot(document))
        .toList());
    return result;
  }

  ShoppingListModel _convertDocumentSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    var result = ShoppingListModel.fromMap(data);
    return result.copyWith(id: snapshot.id);
  }

  @override
  Future<ShoppingListModel> createShoppingList(
      ShoppingListModel shoppingList) async {
    try {
      var reference = _firestore.collection(shoppingListsTable).doc();
      var toSave = shoppingList.toMapCreate();
      await reference.set(toSave);
      return ShoppingListModel(
        id: reference.id,
        name: shoppingList.name,
        groceries: [],
      );
    } catch (e) {
      throw ShoppingListFailure(message: 'Erro to save data on firebase');
    }
  }

  @override
  Future<void> deleteShoppingList(String id) async {
    try {
      var reference = _firestore.collection(shoppingListsTable).doc(id);
      await reference.delete();
    } catch (e) {
      throw ShoppingListFailure(message: 'Erro to delete data from firebase');
    }
  }

  @override
  Future<void> updateShoppingList(ShoppingListModel shoppingList) async {
    try {
      var reference =
          _firestore.collection(shoppingListsTable).doc(shoppingList.id);
      var toSave = shoppingList.toMapUpdate();
      await reference.update(toSave);
    } catch (e) {
      throw ShoppingListFailure(message: 'Erro to save data on firebase');
    }
  }

  @override
  Future<ItemModel> addItemToList(ItemModel item) async {
    try {
      var reference = _firestore.collection(itemTable).doc();
      var toSave = item.toMapCreate();
      await reference.set(toSave);
      return ItemModel(
        id: reference.id,
        name: item.name,
        quantity: item.quantity,
        price: item.price,
        type: item.type,
        shoppingListId: item.shoppingListId,
      );
    } catch (e) {
      throw ShoppingListFailure(message: 'Erro to save data on firebase');
    }
  }

  @override
  Future<void> updateItemInList(ItemModel item) async {
    try {
      var reference = _firestore.collection(itemTable).doc(item.id);
      var toSave = item.toMapUpdate();
      await reference.update(toSave);
    } catch (e) {
      throw ShoppingListFailure(message: 'Erro to save data on firebase');
    }
  }
}
