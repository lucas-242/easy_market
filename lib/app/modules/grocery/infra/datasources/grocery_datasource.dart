import 'package:market_lists/app/modules/grocery/domain/entities/grocery_list.dart';

abstract class GroceryDatasource {
  Future<GroceryList> createGroceryList(GroceryList groceryList);
  Future<void> updateGroceryList(GroceryList groceryList);
  Future<void> deleteGroceryList(String id);
}
