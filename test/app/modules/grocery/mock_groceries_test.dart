import 'package:market_lists/app/modules/grocery/grocery.dart';
import 'package:market_lists/app/modules/grocery/infra/datasources/grocery_datasource.dart';
import 'package:market_lists/app/modules/grocery/infra/models/grocery_list_model.dart';
import 'package:market_lists/app/modules/grocery/infra/models/grocery_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class GroceryRepositoryTest extends Mock implements GroceryRepository {}

class GroceryDatasourceTest extends Mock implements GroceryDatasource {}

class StreamGroceryListsTest extends Mock
    implements Stream<List<GroceryListModel>> {}

/// GroceryList without id
GroceryList get groceryListToCreate => GroceryList(
      name: 'Test',
      groceries: const [
        Grocery(name: 'product1', quantity: 5),
        Grocery(name: 'product2', quantity: 3),
      ],
    );

/// GroceryListmodel without id
GroceryListModel get groceryListModelToCreate => GroceryListModel(
      name: 'Test',
      groceries: [
        GroceryModel(name: 'product1', quantity: 5),
        GroceryModel(name: 'product2', quantity: 3),
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

/// GroceryListModel with id
GroceryListModel get groceryListModelToUpdate => GroceryListModel(
      id: '123',
      name: 'Test',
      groceries: [
        GroceryModel(name: 'product1', quantity: 5),
        GroceryModel(name: 'product2', quantity: 3),
      ],
    );

///List of GroceryList
List<GroceryList> get groceryLists => [
      GroceryList(
        id: '123',
        name: 'Test1',
        groceries: [
          const Grocery(name: 'product1', quantity: 5),
          const Grocery(name: 'product2', quantity: 3),
        ],
      ),
      GroceryList(
        id: '1234',
        name: 'Test2',
        groceries: [
          const Grocery(name: 'product1', quantity: 5),
          const Grocery(name: 'product2', quantity: 3),
        ],
      ),
      GroceryList(
        id: '12345',
        name: 'Test3',
        groceries: [
          const Grocery(name: 'product1', quantity: 5),
          const Grocery(name: 'product2', quantity: 3),
        ],
      ),
    ];

///List of GroceryListModel
List<GroceryListModel> get groceryListModelList => [
      GroceryListModel(
        id: '123',
        name: 'Test1',
        groceries: [
          GroceryModel(name: 'product1', quantity: 5),
          GroceryModel(name: 'product2', quantity: 3),
        ],
      ),
      GroceryListModel(
        id: '1234',
        name: 'Test2',
        groceries: [
          GroceryModel(name: 'product1', quantity: 5),
          GroceryModel(name: 'product2', quantity: 3),
        ],
      ),
      GroceryListModel(
        id: '12345',
        name: 'Test3',
        groceries: [
          GroceryModel(name: 'product1', quantity: 5),
          GroceryModel(name: 'product2', quantity: 3),
        ],
      ),
    ];

/// Grocery without id
Grocery get groceryToAdd => const Grocery(
      name: 'product1',
      quantity: 5,
      groceryListId: '123',
    );

@GenerateMocks(
    [GroceryRepositoryTest, GroceryDatasourceTest, StreamGroceryListsTest])
void main() {}
