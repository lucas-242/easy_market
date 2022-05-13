import 'package:market_lists/modules/grocery/grocery.dart';

class GroceryRepositoryImpl implements GroceryRepository {
  final GroceryDatasource _datasource;
  GroceryRepositoryImpl(GroceryDatasource datasource)
      : _datasource = datasource;

  @override
  Future<Grocery> create(Grocery grocery) => _datasource.create(grocery);

  @override
  Future<void> delete(Grocery grocery) => _datasource.delete(grocery.id);

  @override
  Future<void> update(Grocery grocery) => _datasource.update(grocery);
}
