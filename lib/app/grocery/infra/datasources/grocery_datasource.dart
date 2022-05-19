import 'package:market_lists/app/grocery/domain/entities/grocery.dart';

abstract class GroceryDatasource {
  Future<Grocery> create(Grocery grocery);
  Future<void> update(Grocery grocery);
  Future<void> delete(String id);
}
