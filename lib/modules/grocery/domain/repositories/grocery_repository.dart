import 'package:market_lists/modules/grocery/domain/entities/grocery.dart';

abstract class GroceryRepository {
  Future<Grocery> create(Grocery grocery);
  Future<void> update(Grocery grocery);
  Future<void> delete(Grocery grocery);
}
