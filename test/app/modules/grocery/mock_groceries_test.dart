import 'package:market_lists/app/modules/grocery/grocery.dart';
import 'package:market_lists/app/modules/grocery/infra/datasources/grocery_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class GroceryRepositoryTest extends Mock implements GroceryRepository {}

class GroceryDatasourceTest extends Mock implements GroceryDatasource {}

/// GroceryList without id
GroceryList get groceryListToCreate => GroceryList(
      name: 'Test',
      groceries: const [
        Grocery(name: 'product1', quantity: 5),
        Grocery(name: 'product2', quantity: 3),
      ],
    );

/// GroceryList with id
GroceryList get groceryListToUpdate => GroceryList(
      id: '123',
      name: 'Test',
      groceries: const [
        Grocery(name: 'product1', quantity: 5),
        Grocery(name: 'product2', quantity: 3),
      ],
    );

@GenerateMocks([GroceryRepositoryTest, GroceryDatasourceTest])
void main() {}
