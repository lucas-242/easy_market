import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/l10n/generated/l10n.dart';
import '../../../domain/errors/errors.dart';
import '../../../infra/datasources/shopping_list_datasource.dart';
import '../../../infra/models/item_model.dart';
import '../../../infra/models/shopping_list_model.dart';
import 'package:lexicographical_order/lexicographical_order.dart';

import 'models/firebase_shopping_list_model.dart';

class FirebaseShoppingListDatasource implements ShoppingListDatasource {
  final String shoppingListsTable = 'shoppingLists';
  final String itemsTable = 'items';
  final FirebaseFirestore _firestore;
  final bool _useFirebaseEmulator;
  List<ItemModel>? _cachedItems;

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
          .orderBy('createdAt')
          .get();
      final result = _snapshotToListOfShoppingListModel(snapshot.docs);
      return result;
    } catch (e) {
      throw GetShoppingListFailure(AppLocalizations.current.errorToGetLists);
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
          .orderBy('createdAt')
          .snapshots();
      final result = _querySnapshotToShoppingListModel(snapshots);
      return result;
    } catch (e) {
      throw GetShoppingListFailure(AppLocalizations.current.errorToGetLists);
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
      throw CreateShoppingListFailure(
          AppLocalizations.current.errorToCreateList);
    }
  }

  @override
  Future<void> deleteShoppingList(String id) async {
    try {
      final reference = _firestore.collection(shoppingListsTable).doc(id);
      await reference.delete();
    } catch (e) {
      throw DeleteShoppingListFailure(
          AppLocalizations.current.errorToDeleteList);
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
      throw UpdateShoppingListFailure(
          AppLocalizations.current.errorToUpdateList);
    }
  }

  @override
  Future<void> addCollaboratorToList(
    String shoppingListId,
    String email,
  ) async {
    try {
      await _firestore
          .collection(shoppingListsTable)
          .doc(shoppingListId)
          .update({
        "users": FieldValue.arrayUnion([email])
      });
    } catch (e) {
      throw AddCollaboratorFailure(
          AppLocalizations.current.errorToAddCollaborator);
    }
  }

  @override
  Future<void> removeCollaboratorFromList(
    String shoppingListId,
    String email,
  ) async {
    try {
      await _firestore
          .collection(shoppingListsTable)
          .doc(shoppingListId)
          .update({
        "users": FieldValue.arrayRemove([email])
      });
    } catch (e) {
      throw RemoveCollaboratorFailure(
          AppLocalizations.current.errorToRemoveCollaborator);
    }
  }

  @override
  Future<List<ItemModel>> getItemsFromList(String shoppingListId) async {
    try {
      final snapshot = await _firestore
          .collection(shoppingListsTable)
          .doc(shoppingListId)
          .collection(itemsTable)
          .orderBy('orderKey')
          .get();
      final result = _snapshotToListOfItemModel(snapshot.docs);
      return result;
    } catch (e) {
      throw GetItemsFailure(AppLocalizations.current.errorToGetItems);
    }
  }

  List<ItemModel> _snapshotToListOfItemModel(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshot) {
    final result = snapshot
        .map((e) => ItemModel.fromMap(e.data()).copyWith(id: e.id))
        .toList();
    _cachedItems = result;
    return result;
  }

  @override
  Stream<List<ItemModel>> listenItemsFromList(String shoppingListId) {
    try {
      Stream<QuerySnapshot> snapshots = _firestore
          .collection(shoppingListsTable)
          .doc(shoppingListId)
          .collection(itemsTable)
          .orderBy('orderKey')
          .snapshots();
      final result = _querySnapshotToItemModel(snapshots);
      return result;
    } catch (e) {
      throw GetItemsFailure(AppLocalizations.current.errorToGetItems);
    }
  }

  Stream<List<ItemModel>> _querySnapshotToItemModel(
      Stream<QuerySnapshot<Object?>> snapshot) {
    final result = snapshot.map((query) {
      final items = query.docs
          .map((DocumentSnapshot document) =>
              _documentSnapshotToItemModel(document))
          .toList();
      _cachedItems = items;
      return items;
    });
    return result;
  }

  ItemModel _documentSnapshotToItemModel(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final result = ItemModel.fromMap(data).copyWith(id: snapshot.id);
    return result;
  }

  @override
  Future<ItemModel> addItemToList(ItemModel item) async {
    try {
      final toSave =
          item.copyWith(orderKey: _generateOrderKeyToNewItem()).toCreate();
      final reference = await _firestore
          .collection(shoppingListsTable)
          .doc(item.shoppingListId)
          .collection(itemsTable)
          .add(toSave);

      return ItemModel(
        id: reference.id,
        name: item.name,
        quantity: item.quantity,
        price: item.price,
        type: item.type,
        orderKey: item.orderKey,
        shoppingListId: item.shoppingListId,
      );
    } catch (e) {
      throw AddItemFailure(AppLocalizations.current.errorToAddItem);
    }
  }

  String _generateOrderKeyToNewItem() {
    if (_cachedItems == null || _cachedItems!.isEmpty) {
      return generateOrderKeys(1).first;
    }

    return between(prev: _cachedItems!.last.orderKey);
  }

  @override
  Future<void> updateItemInList(ItemModel item) async {
    try {
      final toSave = item.toUpdate();
      await _firestore
          .collection(shoppingListsTable)
          .doc(item.shoppingListId)
          .collection(itemsTable)
          .doc(item.id)
          .update(toSave);
    } catch (e) {
      throw UpdateItemFailure(AppLocalizations.current.errorToUpdateItem);
    }
  }

  @override
  Future<void> deleteItemFromList(ItemModel item) async {
    try {
      await _firestore
          .collection(shoppingListsTable)
          .doc(item.shoppingListId)
          .collection(itemsTable)
          .doc(item.id)
          .delete();
    } catch (e) {
      throw DeleteItemFailure(AppLocalizations.current.deleteItem);
    }
  }

  @override
  Future<void> reorderItemInList(ItemModel item,
      {ItemModel? prev, ItemModel? next}) async {
    try {
      final newOrderKey = _generateOrderKeyToOldItem(prev: prev, next: next);
      final toSave = item.copyWith(orderKey: newOrderKey).toUpdate();
      await _firestore
          .collection(shoppingListsTable)
          .doc(item.shoppingListId)
          .collection(itemsTable)
          .doc(item.id)
          .update(toSave);
    } catch (e) {
      throw UpdateItemFailure(AppLocalizations.current.errorToReorderItems);
    }
  }

  String _generateOrderKeyToOldItem({ItemModel? prev, ItemModel? next}) =>
      between(prev: prev?.orderKey, next: next?.orderKey);

  @override
  Future<void> checkItemInList(
      String shoppingListId, String itemId, bool isChecked) async {
    try {
      await _firestore
          .collection(shoppingListsTable)
          .doc(shoppingListId)
          .collection(itemsTable)
          .doc(itemId)
          .update({"isChecked": isChecked});
    } catch (e) {
      throw UpdateItemFailure(AppLocalizations.current.errorToUpdateItem);
    }
  }
}
