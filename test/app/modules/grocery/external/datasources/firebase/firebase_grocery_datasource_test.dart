import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/grocery/external/datasources/firebase/firebase_grocery_datasource.dart';

import '../../../mock_groceries_test.dart' as mock;

void main() {
  final database = FakeFirebaseFirestore();
  final datasource = FirebaseGroceryDatasource(database);

  test('Should create GroceryList', () async {
    var groceryList = mock.groceryListModelToCreate;
    var result = await datasource.createGroceryList(groceryList);
    expect(result.id, isNotNull);
    expect(result.id, isNotEmpty);
    expect(result.name, groceryList.name);
  });
}
