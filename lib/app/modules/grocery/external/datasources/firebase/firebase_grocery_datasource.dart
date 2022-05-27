import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';

import 'package:market_lists/app/modules/grocery/infra/datasources/grocery_datasource.dart';
import 'package:market_lists/app/modules/grocery/infra/models/grocery_list_model.dart';

class FirebaseGroceryDatasource implements GroceryDatasource {
  final String groceryListsTable = 'groceryLists';
  final FirebaseFirestore _firestore;
  FirebaseGroceryDatasource(this._firestore);

  //TODO: ADD userId in the created data and where clauses to the gets

  @override
  Future<List<GroceryListModel>> getGroceryLists() async {
    try {
      var reference = _firestore.collection(groceryListsTable);
      var snapshot = await reference.get();
      var result = _convertQueryDocumentSnapshot(snapshot.docs);
      return result;
    } catch (e) {
      throw GroceryListFailure(message: 'Erro to get data from firebase');
    }
  }

  List<GroceryListModel> _convertQueryDocumentSnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshot) {
    var result = snapshot
        .map((e) => GroceryListModel.fromMap(e.data()).copyWith(id: e.id))
        .toList();
    return result;
  }

  @override
  Stream<List<GroceryListModel>> listenGroceryLists() {
    try {
      Stream<QuerySnapshot> snapshots =
          _firestore.collection(groceryListsTable).snapshots();
      var result = _convertQuerySnapshot(snapshots);
      return result;
    } catch (e) {
      throw GroceryListFailure(message: 'Erro to listen data from firebase');
    }
  }

  Stream<List<GroceryListModel>> _convertQuerySnapshot(
      Stream<QuerySnapshot<Object?>> snapshot) {
    var result = snapshot.map((query) => query.docs
        .map((DocumentSnapshot document) => _convertDocumentSnapshot(document))
        .toList());
    return result;
  }

  GroceryListModel _convertDocumentSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    var result = GroceryListModel.fromMap(data);
    return result.copyWith(id: snapshot.id);
  }

  @override
  Future<GroceryListModel> createGroceryList(
      GroceryListModel groceryList) async {
    try {
      var reference = _firestore.collection(groceryListsTable).doc();
      var toSave = groceryList.toMapCreate();
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
  Future<void> deleteGroceryList(String id) async {
    try {
      var reference = _firestore.collection(groceryListsTable).doc(id);
      await reference.delete();
    } catch (e) {
      throw GroceryListFailure(message: 'Erro to delete data from firebase');
    }
  }

  @override
  Future<void> updateGroceryList(GroceryListModel groceryList) {
    // TODO: implement updateGroceryList
    throw UnimplementedError();
  }
}
