import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/grocery/external/datasources/shared_preferences/shared_preferences_grocery_datasource.dart';
import 'package:market_lists/app/modules/grocery/infra/models/grocery_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../mock_groceries_test.dart' as mock;

void main() {
  late SharedPreferencesGroceryDatasource datasource;

  Map<String, Object> _getSharedPreferencesMockInitialValues() {
    List<String> initialValue = [
      GroceryListModel.fromGroceryList(mock.groceryListToCreate).toJson()
    ];
    return <String, Object>{
      SharedPreferencesGroceryDatasource.groceryListsStorageName: initialValue
    };
  }

  setUp(() {
    datasource = SharedPreferencesGroceryDatasource();
    var initialValue = _getSharedPreferencesMockInitialValues();
    SharedPreferences.setMockInitialValues(initialValue);
  });

  test('Should create GroceryList', () async {
    var groceryList = mock.groceryListToCreate;
    var result = await datasource.createGroceryList(groceryList);

    expect(result, groceryList);
  });
}
