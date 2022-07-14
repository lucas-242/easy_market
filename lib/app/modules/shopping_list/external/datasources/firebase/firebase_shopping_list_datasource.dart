import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';

import 'package:easy_market/app/modules/shopping_list/infra/datasources/shopping_list_datasource.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/item_model.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/shopping_list_model.dart';

class FirebaseShoppingListDatasource implements ShoppingListDatasource {
  final String shoppingListsTable = 'shoppingLists';
  final String itemsTable = 'items';
  final FirebaseFirestore _firestore;
  final bool _useFirebaseEmulator;
  FirebaseShoppingListDatasource(this._firestore,
      {bool useFirebaseEmulator = false})
      : _useFirebaseEmulator = useFirebaseEmulator {
    if (_useFirebaseEmulator) {
      _firestore.useFirestoreEmulator('localhost', 8080);
    }
  }

  //TODO: ADD userId in the created data and where clauses to the gets

  @override
  Future<List<ShoppingListModel>> getShoppingLists() async {
    try {
      var reference = _firestore.collection(shoppingListsTable);
      var snapshot = await reference.get();
      var result = _snapshotToListOfShoppingListModel(snapshot.docs);
      return result;
    } catch (e) {
      throw ShoppingListFailure(message: 'Erro to get data from firebase');
    }
  }

  List<ShoppingListModel> _snapshotToListOfShoppingListModel(
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
      var result = _querySnapshotToShoppingListModel(snapshots);
      return result;
    } catch (e) {
      throw ShoppingListFailure(message: 'Erro to listen data from firebase');
    }
  }

  Stream<List<ShoppingListModel>> _querySnapshotToShoppingListModel(
      Stream<QuerySnapshot<Object?>> snapshot) {
    var result = snapshot.map((query) => query.docs
        .map((DocumentSnapshot document) =>
            _documentSnapshotToShoppingListModel(document))
        .toList());
    return result;
  }

  ShoppingListModel _documentSnapshotToShoppingListModel(
      DocumentSnapshot snapshot) {
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
        items: [],
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
  Future<List<ItemModel>> getItemsFromList(String shoppingListId) async {
    try {
      var reference = _firestore
          .collection(itemsTable)
          .where('shoppingListId', isEqualTo: shoppingListId);
      var snapshot = await reference.get();
      var result = _snapshotToListOfItemModel(snapshot.docs);
      return result;
    } catch (e) {
      throw ShoppingListFailure(message: 'Erro to save data on firebase');
    }
  }

  List<ItemModel> _snapshotToListOfItemModel(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshot) {
    var result = snapshot
        .map((e) => ItemModel.fromMap(e.data()).copyWith(id: e.id))
        .toList();
    return result;
  }

  @override
  Stream<List<ItemModel>> listenItemsFromList(String shoppingListId) {
    try {
      Stream<QuerySnapshot> snapshots = _firestore
          .collection(itemsTable)
          .where('shoppingListId', isEqualTo: shoppingListId)
          .snapshots();
      var result = _querySnapshotToItemModel(snapshots);
      return result;
    } catch (e) {
      throw ShoppingListFailure(message: 'Erro to listen data from firebase');
    }
  }

  Stream<List<ItemModel>> _querySnapshotToItemModel(
      Stream<QuerySnapshot<Object?>> snapshot) {
    var result = snapshot.map((query) => query.docs
        .map((DocumentSnapshot document) =>
            _documentSnapshotToItemModel(document))
        .toList());
    return result;
  }

  ItemModel _documentSnapshotToItemModel(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    var result = ItemModel.fromMap(data);
    return result.copyWith(id: snapshot.id);
  }

  @override
  Future<ItemModel> addItemToList(ItemModel item) async {
    try {
      var reference = _firestore.collection(itemsTable).doc();
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
      var reference = _firestore.collection(itemsTable).doc(item.id);
      var toSave = item.toMapUpdate();
      await reference.update(toSave);
    } catch (e) {
      throw ShoppingListFailure(message: 'Erro to save data on firebase');
    }
  }

  @override
  Future<void> deleteItemFromList(String itemId) async {
    try {
      var reference = _firestore.collection(itemsTable).doc(itemId);
      await reference.delete();
    } catch (e) {
      throw ShoppingListFailure(message: 'Erro to delete data from firebase');
    }
  }
}
