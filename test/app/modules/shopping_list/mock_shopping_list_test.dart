import 'package:market_lists/app/modules/shopping_list/infra/datasources/shopping_list_datasource.dart';
import 'package:market_lists/app/modules/shopping_list/infra/models/item_model.dart';
import 'package:market_lists/app/modules/shopping_list/infra/models/shopping_list_model.dart';
import 'package:market_lists/app/modules/shopping_list/shopping_list.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class ShoppingListRepositoryTest extends Mock
    implements ShoppingListRepository {}

class ShoppingListDatasourceTest extends Mock
    implements ShoppingListDatasource {}

class StreamShoppingListsTest extends Mock
    implements Stream<List<ShoppingListModel>> {}

/// ShoppingList without id
ShoppingList get shoppingListToCreate => ShoppingList(
      name: 'Test',
      groceries: const [
        Item(name: 'product1', quantity: 5),
        Item(name: 'product2', quantity: 3),
      ],
    );

/// ShoppingListmodel without id
ShoppingListModel get shoppingListModelToCreate => ShoppingListModel(
      name: 'Test',
      groceries: [
        ItemModel(name: 'product1', quantity: 5),
        ItemModel(name: 'product2', quantity: 3),
      ],
    );

/// ShoppingList with id
ShoppingList get shoppingListToUpdate => ShoppingList(
      id: '123',
      name: 'Test',
      groceries: const [
        Item(name: 'product1', quantity: 5),
        Item(name: 'product2', quantity: 3),
      ],
    );

/// ShoppingListModel with id
ShoppingListModel get shoppingListModelToUpdate => ShoppingListModel(
      id: '123',
      name: 'Test',
      groceries: [
        ItemModel(name: 'product1', quantity: 5),
        ItemModel(name: 'product2', quantity: 3),
      ],
    );

///List of ShoppingList
List<ShoppingList> get shoppingLists => [
      ShoppingList(
        id: '123',
        name: 'Test1',
        groceries: [
          const Item(name: 'product1', quantity: 5),
          const Item(name: 'product2', quantity: 3),
        ],
      ),
      ShoppingList(
        id: '1234',
        name: 'Test2',
        groceries: [
          const Item(name: 'product1', quantity: 5),
          const Item(name: 'product2', quantity: 3),
        ],
      ),
      ShoppingList(
        id: '12345',
        name: 'Test3',
        groceries: [
          const Item(name: 'product1', quantity: 5),
          const Item(name: 'product2', quantity: 3),
        ],
      ),
    ];

///List of ShoppingListModel
List<ShoppingListModel> get shoppingListModelList => [
      ShoppingListModel(
        id: '123',
        name: 'Test1',
        groceries: [
          ItemModel(name: 'product1', quantity: 5),
          ItemModel(name: 'product2', quantity: 3),
        ],
      ),
      ShoppingListModel(
        id: '1234',
        name: 'Test2',
        groceries: [
          ItemModel(name: 'product1', quantity: 5),
          ItemModel(name: 'product2', quantity: 3),
        ],
      ),
      ShoppingListModel(
        id: '12345',
        name: 'Test3',
        groceries: [
          ItemModel(name: 'product1', quantity: 5),
          ItemModel(name: 'product2', quantity: 3),
        ],
      ),
    ];

/// Item without id
Item get itemToAdd => const Item(
      name: 'product1',
      quantity: 5,
      shoppingListId: '123',
    );

/// ItemModel without id
ItemModel get itemModelToAdd => ItemModel(
      name: 'product1',
      quantity: 5,
      shoppingListId: '123',
    );

/// Item with id
Item get itemToUpdate => const Item(
      id: '123',
      name: 'product1',
      quantity: 5,
      shoppingListId: '123',
    );

/// ItemModel with id
ItemModel get itemModelToUpdate => ItemModel(
      id: '123',
      name: 'product1',
      quantity: 5,
      shoppingListId: '123',
    );

@GenerateMocks([
  ShoppingListRepositoryTest,
  ShoppingListDatasourceTest,
  StreamShoppingListsTest
])
void main() {}
