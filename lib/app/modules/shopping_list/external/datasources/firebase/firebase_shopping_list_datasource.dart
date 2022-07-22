import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';

import 'package:easy_market/app/modules/shopping_list/infra/datasources/shopping_list_datasource.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/item_model.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/shopping_list_model.dart';

import 'models/firebase_shopping_list_model.dart';

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

  @override
  Future<List<FirebaseShoppingListModel>> getShoppingLists(
      String userId) async {
    try {
      final snapshot = await _firestore
          .collection(shoppingListsTable)
          .where('users', arrayContains: userId)
          .get();
      final result = _snapshotToListOfShoppingListModel(snapshot.docs);
      return result;
    } catch (e) {
      throw ShoppingListFailure(message: 'Error to get data from firebase');
    }
  }

  List<FirebaseShoppingListModel> _snapshotToListOfShoppingListModel(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshot) {
    final result = snapshot
        .map((e) =>
            FirebaseShoppingListModel.fromMap(e.data()).copyWith(id: e.id))
        .toList();
    return result;
  }

  @override
  Stream<List<FirebaseShoppingListModel>> listenShoppingLists(String userId) {
    try {
      Stream<QuerySnapshot> snapshots = _firestore
          .collection(shoppingListsTable)
          .where('users', arrayContains: userId)
          .snapshots();
      final result = _querySnapshotToShoppingListModel(snapshots);
      return result;
    } catch (e) {
      throw ShoppingListFailure(message: 'Error to listen data from firebase');
    }
  }

  Stream<List<FirebaseShoppingListModel>> _querySnapshotToShoppingListModel(
      Stream<QuerySnapshot<Object?>> snapshot) {
    final result = snapshot.map((query) => query.docs
        .map((DocumentSnapshot document) =>
            _documentSnapshotToShoppingListModel(document))
        .toList());
    return result;
  }

  FirebaseShoppingListModel _documentSnapshotToShoppingListModel(
      DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final result = FirebaseShoppingListModel.fromMap(data);
    return result.copyWith(id: snapshot.id);
  }

  @override
  Stream<FirebaseShoppingListModel> listenShoppingListById(String id) {
    try {
      Stream<DocumentSnapshot> snapshots =
          _firestore.collection(shoppingListsTable).doc(id).snapshots();
      final result = _streamDocumentSnapshotToShoppingListModel(snapshots);
      return result;
    } catch (e) {
      throw ShoppingListFailure(message: 'Error to listen data from firebase');
    }
  }

  Stream<FirebaseShoppingListModel> _streamDocumentSnapshotToShoppingListModel(
      Stream<DocumentSnapshot<Object?>> snapshot) {
    final result = snapshot
        .map((document) => _documentSnapshotToShoppingListModel(document));
    return result;
  }

  @override
  Future<FirebaseShoppingListModel> createShoppingList(
      ShoppingListModel shoppingList) async {
    try {
      final toSave =
          FirebaseShoppingListModel.fromShoppingListModel(shoppingList)
              .toCreate();
      final reference =
          await _firestore.collection(shoppingListsTable).add(toSave);
      return FirebaseShoppingListModel(
          id: reference.id,
          name: shoppingList.name,
          items: [],
          owner: shoppingList.owner,
          users: [shoppingList.owner]);
    } catch (e) {
      throw ShoppingListFailure(message: 'Error to save data on firebase');
    }
  }

  @override
  Future<void> deleteShoppingList(String id) async {
    try {
      final reference = _firestore.collection(shoppingListsTable).doc(id);
      await reference.delete();
    } catch (e) {
      throw ShoppingListFailure(message: 'Error to delete data from firebase');
    }
  }

  @override
  Future<void> updateShoppingList(ShoppingListModel shoppingList) async {
    try {
      final toSave =
          FirebaseShoppingListModel.fromShoppingListModel(shoppingList)
              .toUpdate();
      await _firestore
          .collection(shoppingListsTable)
          .doc(shoppingList.id)
          .update(toSave);
    } catch (e) {
      throw ShoppingListFailure(message: 'Error to save data on firebase');
    }
  }

  @override
  Future<List<ItemModel>> getItemsFromList(String shoppingListId) async {
    try {
      final snapshot = await _firestore
          .collection(itemsTable)
          .where('shoppingListId', isEqualTo: shoppingListId)
          .get();
      final result = _snapshotToListOfItemModel(snapshot.docs);
      return result;
    } catch (e) {
      throw ShoppingListFailure(message: 'Error to save data on firebase');
    }
  }

  List<ItemModel> _snapshotToListOfItemModel(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshot) {
    final result = snapshot
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
      final result = _querySnapshotToItemModel(snapshots);
      return result;
    } catch (e) {
      throw ShoppingListFailure(message: 'Error to listen data from firebase');
    }
  }

  Stream<List<ItemModel>> _querySnapshotToItemModel(
      Stream<QuerySnapshot<Object?>> snapshot) {
    final result = snapshot.map((query) => query.docs
        .map((DocumentSnapshot document) =>
            _documentSnapshotToItemModel(document))
        .toList());
    return result;
  }

  ItemModel _documentSnapshotToItemModel(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final result = ItemModel.fromMap(data);
    return result.copyWith(id: snapshot.id);
  }

  @override
  Future<ItemModel> addItemToList(ItemModel item) async {
    try {
      final toSave = item.toCreate();
      final reference = await _firestore.collection(itemsTable).add(toSave);
      return ItemModel(
        id: reference.id,
        name: item.name,
        quantity: item.quantity,
        price: item.price,
        type: item.type,
        shoppingListId: item.shoppingListId,
      );
    } catch (e) {
      throw ShoppingListFailure(message: 'Error to save data on firebase');
    }
  }

  @override
  Future<void> updateItemInList(ItemModel item) async {
    try {
      final toSave = item.toUpdate();
      await _firestore.collection(itemsTable).doc(item.id).update(toSave);
    } catch (e) {
      throw ShoppingListFailure(message: 'Error to save data on firebase');
    }
  }

  @override
  Future<void> deleteItemFromList(String itemId) async {
    try {
      await _firestore.collection(itemsTable).doc(itemId).delete();
    } catch (e) {
      throw ShoppingListFailure(message: 'Error to delete data from firebase');
    }
  }
}
